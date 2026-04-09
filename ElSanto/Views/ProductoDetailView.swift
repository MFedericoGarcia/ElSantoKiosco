//
//  ProductoDetailView.swift
//  ElSanto
//
//  Created by Fede Garcia on 08/04/2026.
//

import SwiftUI

struct ProductoDetailView: View {
    
    var producto: Producto
    @State private var isShowingSheet = false
    
    
    var body: some View {
        VStack{
            List {
                HStack {
                    Text(producto.nombre)
                        .font(.title)
                    
                    Spacer()
                    
                    VStack {
                        Text(String(describing: producto.tipoProducto))
                        Image(systemName: producto.sfImage)
                            .font(.title)
                    }
                }
                
                Section("Precio Actual") {
                    HStack {
                        Text(" \(producto.precioCosto.formatted(.currency(code: "ARS")))")
                            .font(.title3)
                        Spacer()
                        Button {
                            isShowingSheet.toggle()
                        } label: {
                            HStack {
                                Text("Nuevo Precio")
                                Image(systemName: "arrow.trianglehead.counterclockwise")
                            }
                        }
                    }
                    
                }
                
                Section("Precios anteriores") {
                    ForEach(producto.preciosHistoricos) { historico in
                        HStack {
                            Text(String(historico.precio))
                            Spacer()
                            Text(historico.fechaString)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            EditPrecioView(producto: producto)
        }
    }
}

#Preview {
    ProductoDetailView(producto: Producto.ejemplo)
}
