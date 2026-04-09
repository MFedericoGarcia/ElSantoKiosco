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
    
    @State private var nombre = ""
    @State private var tipo = Producto.TipoProducto.bebidas
    @State private var costo = 0.0
    @State private var venta = 0.0
    
    var body: some View {
        VStack {
            List {
                TextField("Nombre del Producto", text: $nombre)
                Picker("Tipo del Producto", selection: $tipo) {
                    ForEach(Producto.TipoProducto.allCases, id: \.self){ tipo in
                        Text(String(tipo.rawValue))
                    }
                }
                Section("Precio de costo"){
                        
                        TextField("Precio de Costo", value: $costo, format: .currency(code: "ARS"))
                }
                        Section("Precio de Venta"){
                                TextField("Precio de Venta", value: $venta, format: .currency(code: "ARS"))
                        
                }
            }
            
            Button("Agregar Producto") {
                modelContext.insert(Producto(nombre: nombre, precioCosto: costo, precioVenta: venta, tipoProducto: tipo))
                dismiss()
            }
            
        }
        .presentationDetents([.medium])

    }
}

#Preview {
    NuevoProductoView()
}
