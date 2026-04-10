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
                }
                
                Section("Precio de Venta"){
                    TextField("Precio de Venta", value: $viewModel.venta, format: .currency(code: "ARS"))
                }
            }
            .onAppear{
                viewModel.modelContext = modelContext
            }
            
            Button("Agregar Producto") {
                viewModel.agregarProducto()
                refresh()
                dismiss()
            }
            
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    NuevoProductoView() {
        
    }
}
