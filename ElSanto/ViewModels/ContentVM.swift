//
//  ContentVM.swift
//  ElSanto
//
//  Created by Fede Garcia on 09/04/2026.
//

import SwiftData
import SwiftUI


extension ContentView {
    
    @Observable
    class ViewModel {
        var modelContext: ModelContext? = nil
        var productos: [Producto] = []
        
        func fetchProductos() {
            let fetchDescriptor = FetchDescriptor<Producto>(sortBy: [SortDescriptor(\.nombre)])
            
            productos = (try? (modelContext?.fetch(fetchDescriptor) ?? [])) ?? []
        }
        
        func deleteProducto(at offsets: IndexSet) {
            for index in offsets {
                let producto = productos[index]
                if let modelContext = modelContext {
                    modelContext.delete(producto)
                }
                do {
                    try modelContext?.save()
                } catch {
                    print("Error at saving the model \(error.localizedDescription)")
                }
            }
        }
        
        func filtrarProductos( searchText: String) -> [Producto] {
            if searchText.isEmpty {
                productos
            } else {
                productos.filter { producto in
                    producto.nombre.localizedStandardContains(searchText)
                }
            }
        }
    }
    
}
