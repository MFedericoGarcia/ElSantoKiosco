//
//  ContentVM.swift
//  ElSanto
//
//  Created by Fede Garcia on 09/04/2026.
//

import CodeScanner
import SwiftData
import SwiftUI


extension ProductosListView {
    
    @Observable
    class ViewModel {
        var modelContext: ModelContext? = nil
        var productos: [Producto] = []
        
        var isShowingScan = false
        var barcodeScaned: Producto?
        
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
        
        func handleScann( result: Result<ScanResult, ScanError>){
            switch result {
            case .success(let result):
                let details = result.string
                print(details)
                isShowingScan = false
                productScanned(code: details)
                
            case .failure(let error):
                print("Scanning failed: \(error.localizedDescription)")
            }
            
        }
        
        func productScanned( code: String){
            for producto in productos {
                if producto.codigoDeBarras == code {
                    barcodeScaned = producto
                } else {
                    barcodeScaned = Producto(nombre: "Nuevo", precioCosto: 0, precioVenta: 0, tipoProducto: .varios, codigoDeBarras: code)
                }
            }
        }
        
    }
    
}
