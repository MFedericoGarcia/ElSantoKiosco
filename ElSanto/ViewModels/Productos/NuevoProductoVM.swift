//
//  NuevoProductoVM.swift
//  ElSanto
//
//  Created by Fede Garcia on 09/04/2026.
//

import SwiftData
import SwiftUI

extension NuevoProductoView {
    @Observable
    class ViewModel {
        var modelContext: ModelContext? = nil
        var nombre = ""
        var costo = 0.0
        var venta = 0.0
        var tipo = Producto.TipoProducto.bebidas
        
        
        func agregarProducto() {
            modelContext?.insert(Producto(nombre: nombre, precioCosto: costo, precioVenta: venta, tipoProducto: tipo))
            
        }
        
    }
}
