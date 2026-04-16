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
    @State private var showingDatePicker = false

    
    var body: some View {
        VStack {
            List {
                TextField("Nuevo Precio", value: $viewModel.nuevoPrecio, format: .currency(code: "ARS").grouping(.automatic))
                    .font(.title)
                    .keyboardType(.decimalPad)
                
                
                Button {
                    showingDatePicker = true
                } label: {
                    HStack {
                        Text("Fecha del aumento")
                        Image(systemName: "calendar")
                        Spacer()
                        Text(viewModel.fecha.formatted(date: .abbreviated, time: .omitted))
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: 150)
            .listStyle(.plain)
            .popover(isPresented: $showingDatePicker) {
                VStack {
                    DatePicker(
                        "",
                        selection: $viewModel.fecha,
                        in: ...Date(),
                        displayedComponents: .date
                    )
                    .labelsHidden()
                    .datePickerStyle(.wheel)

                    Button("Listo") {
                        showingDatePicker = false // cierra SOLO este sheet
                    }
                    .padding(.top)
                }
                .presentationDetents([.height(300)])
            }
            
            Button {
                showingAlert = true
            } label: {
                GuadrarButton()
            }
            
            
            
        }
        .presentationDetents([.medium])
        .alert("Nuevo Precio", isPresented: $showingAlert) {
            Button("Confirmar") {
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

