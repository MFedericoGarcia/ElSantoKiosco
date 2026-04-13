//
//  ProveedoresVM.swift
//  ElSanto
//
//  Created by Fede Garcia on 10/04/2026.
//

import SwiftData
import SwiftUI

extension ProveedoresView {
    
    @Observable
    class ViewModel {
        var modelContext: ModelContext? = nil
        var proveedores: [Proveedor] = []
        var isEmpty = false
        
        func fetchProveedor() {
            let fetchDescriptor = FetchDescriptor<Proveedor>(sortBy: [SortDescriptor(\.name)])
            
            proveedores = (try? (modelContext?.fetch(fetchDescriptor) ?? [])) ?? []
            proveedores.isEmpty ? (isEmpty = true) : (isEmpty = false)
        }
        
        func deleteProveedor(at offsets: IndexSet) {
            for index in offsets {
                let proveedor = proveedores[index]
                if let modelContext = modelContext {
                    modelContext.delete(proveedor)
                }
                do {
                    try modelContext?.save()
                } catch {
                    print("Error at saving the model \(error.localizedDescription)")
                }
            }
        }
        
        func deleteProveedorByID( id: UUID) {
            for proveedor in proveedores {
                if proveedor.id == id {
                    modelContext?.delete(proveedor)
                }
                do {
                    try modelContext?.save()
                } catch {
                    print("Error at saving the model \(error.localizedDescription)")
                }
            }
        }
        
        func filtrarProductos( searchText: String) -> [Proveedor] {
            if searchText.isEmpty {
                proveedores
            } else {
                proveedores.filter { producto in
                    producto.name.localizedStandardContains(searchText)
                }
            }
        }
        
    }
}
