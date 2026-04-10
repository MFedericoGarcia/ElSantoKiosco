//
//  EditPrecioView.swift
//  ElSanto
//
//  Created by Fede Garcia on 08/04/2026.
//

import SwiftUI

struct EditPrecioView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel: ViewModel
    @State private var showingAlert = false
   
    
    var body: some View {
        VStack {
            List {
                TextField("Nuevo Precio", value: $viewModel.nuevoPrecio, format: .currency(code: "ARS").grouping(.automatic))
                    .font(.title)
                DatePicker("Fecha de Aumento", selection: $viewModel.fecha, displayedComponents: .date)
                      .datePickerStyle(.compact)
                      .font(.title3)
            }
            .frame(maxWidth: .infinity, maxHeight: 150)
            .listStyle(.plain)
            
            Button {
                showingAlert = true
            } label: {
                GuadrarButton()
            }
            
        }
        .presentationDetents([.medium])
        .alert("Nuevo Precio", isPresented: $showingAlert) {
            Button("Confirmar", role: .confirm) {
                viewModel.saveNewPrice()
                showingAlert = false
                dismiss()
            }
            Button("Cancelar", role: .cancel) {
                viewModel.nuevoPrecio = 0.0
                viewModel.fecha = .now
                
            }
            
        } message: {
            Text("Está seguro de actualizar / modificar el precio de \(viewModel.producto.nombre) ?")
        }
    }
    
    init(producto: Producto) {
        self.viewModel = ViewModel(producto: producto)
    }
    
    
}

