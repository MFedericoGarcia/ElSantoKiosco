//
//  EditPrecioVM.swift
//  ElSanto
//
//  Created by Fede Garcia on 09/04/2026.
//

import SwiftUI
internal import Combine

extension EditPrecioView {
    
    @Observable
    class ViewModel {
        var producto: Producto
        var nuevoPrecio = 0.0
        var fecha = Date.now
        
        init(producto: Producto) {
            self.producto = producto
        }
        
        func saveNewPrice() {
            producto.nuevoPrecio(nuevoPrecio: nuevoPrecio, fecha: fecha)
        }
        
    }
}
