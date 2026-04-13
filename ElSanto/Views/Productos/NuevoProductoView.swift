//
//  NuevoProductoView.swift
//  ElSanto
//
//  Created by Fede Garcia on 07/04/2026.
//

import SwiftUI
import SwiftData

struct NuevoProductoView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var porcentajeOPrecio = false
    
    @State private var viewModel = ViewModel()
    var refresh: (() -> Void)
    
    var body: some View {
        VStack {
            List {
                TextField("Nombre del Producto", text: $viewModel.nombre)
                Picker("Tipo del Producto", selection: $viewModel.tipo) {
                    ForEach(Producto.TipoProducto.allCases, id: \.self){ tipo in
                        Text(String(tipo.rawValue))
                    }
                }
                Section("Precio de costo"){
                    
                    TextField("Precio de Costo", value: $viewModel.costo, format: .currency(code: "ARS"))
                        .keyboardType(.decimalPad)

                }
                
                Section("Agregar precio por: ") {
                    
                    Toggle(isOn: $porcentajeOPrecio)  {
                        HStack {
                            if porcentajeOPrecio {
                                Text("Precio Final   ")
                                Image(systemName: "numbers.rectangle")
                            } else {
                                Text("Porcentaje   ")
                                Image(systemName: "percent")
                            }
                            
                        }
                        .font(.title3)
                    }
                }
                
                if porcentajeOPrecio {
                    Section("Precio de Venta"){
                        TextField("Precio de Venta", value: $viewModel.venta, format: .currency(code: "ARS"))
                            .keyboardType(.decimalPad)

                    }
                } else {
                    Section("Porcentaje de Ganancia"){
                        TextField("Porcentaje", value: $viewModel.porcentajeGanancia, format: .percent)
                            .keyboardType(.decimalPad)

                    }
                }
            }
            
            .onAppear{
                viewModel.modelContext = modelContext
            }
            
            Button("Agregar Producto") {
                porcentajeOPrecio ? viewModel.agregarProducto() : viewModel.agregarProductoPorPorcentaje()

                refresh()
                dismiss()
            }
            
        }
        
    }
}

#Preview {
    NuevoProductoView() {
        
    }
}
