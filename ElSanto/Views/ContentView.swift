//
//  ContentView.swift
//  ElSanto
//
//  Created by Fede Garcia on 07/04/2026.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query() var productos: [Producto]
    
    @State private var isShowingSheet = false
    @State private var searchText = ""
    
    var filteredProducts: [Producto] {
        if searchText.isEmpty {
            productos
        } else {
            productos.filter { producto in
                producto.nombre.localizedStandardContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredProducts, id: \.id) { producto in
                    NavigationLink{
                        ProductoDetailView(producto: producto)
                        
                    } label: {
                        HStack {
                            Image(systemName: producto.sfImage)
                                .font(.caption)
                            
                            Text(producto.nombre)
                                .font(.headline)
                            
                            Spacer()
                            
                            Text(String(producto.precioCosto.formatted(.currency(code: "ARS"))))
                        }
                    }
                }
            }
            .toolbar {
                Button{
                    isShowingSheet = true
                } label: {
                    Image(systemName: "plus")
                    Text("Nuevo")
                }
            }
            .navigationTitle("El Santo")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Buscar por nombre")
            .sheet(isPresented: $isShowingSheet) {
                NuevoProductoView()
            }
        }
    }
}

#Preview {
    ContentView()
}
