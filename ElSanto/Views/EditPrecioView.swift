//
//  EditPrecioView.swift
//  ElSanto
//
//  Created by Fede Garcia on 08/04/2026.
//

import SwiftData
import SwiftUI

struct EditPrecioView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var nuevoPrecio = 0.0
    @State private var fecha = Date.now
    @State private var showingAlert = false
    
    var producto: Producto
    
    var body: some View {
        VStack {
            List {
                TextField("Nuevo Precio", value: $nuevoPrecio, format: .currency(code: "ARS"))
                    .font(.title)
                DatePicker("Fecha de Aumento", selection: $fecha, displayedComponents: .date)
                      .datePickerStyle(.compact)
                      .font(.title3)
            }
            .frame(maxWidth: .infinity, maxHeight: 150)
            .listStyle(.plain)
            
            Button {
                showingAlert = true
            } label: {
                HStack{
                    Text("Guardar")
                        .font(.title)
                    Image(systemName: "square.and.arrow.down.fill")
                        .font(.title)
                }
            }
            .buttonStyle(.bordered)
            .tint(.teal)
            
        }
        .presentationDetents([.medium])
        .alert("Nuevo Precio", isPresented: $showingAlert) {
            Button("Confirmar", role: .confirm) {
                saveNewPrice(precio: nuevoPrecio, fecha: fecha, id: producto.id)
                showingAlert = false
                dismiss()
            }
            Button("Cancelar", role: .cancel) {
                nuevoPrecio = 0.0
                fecha = .now
            }
            
        } message: {
            Text("Está seguro de actualizar / modificar el precio de \(producto.nombre) ?")
        }
    }
    
    func saveNewPrice(precio: Double, fecha: Date, id: UUID) {
        producto.nuevoPrecio(nuevoPrecio: precio, fecha: fecha)
    }
}

#Preview {
    EditPrecioView(producto: .ejemplo)
}
