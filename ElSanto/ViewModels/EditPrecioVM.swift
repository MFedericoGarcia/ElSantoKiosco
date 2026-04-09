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
        var nuevoPrecio = 0.0
        var fecha = Date.now
        
        func saveNewPrice(producto: Producto) {
            producto.nuevoPrecio(nuevoPrecio: nuevoPrecio, fecha: fecha)
        }
        
    }
}
