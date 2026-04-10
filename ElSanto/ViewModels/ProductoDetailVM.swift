//
//  ProductoDetailVM.swift
//  ElSanto
//
//  Created by Fede Garcia on 09/04/2026.
//

import SwiftData
import SwiftUI

extension ProductoDetailView {
    @Observable
    class ViewModel {
        var producto: Producto
        var listaDePrecios = [String]()
        
        init(producto: Producto) {
            self.producto = producto
        }
        
        
        
        func listToStrings() {
            listaDePrecios.append("Precios Historicos de: \(producto.nombre)")
            listaDePrecios.append(" ")
            listaDePrecios.append("Precios  ------- Fechas")
            
            for precio in producto.preciosHistoricos {
                let stringed = "\(precio.precio) ------- \(precio.fechaString)"
                listaDePrecios.append(stringed)
            }
        }
        
    }
    
    
    
}
