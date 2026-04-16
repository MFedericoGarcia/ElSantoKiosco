//
//  NuevoProveedorVM.swift
//  ElSanto
//
//  Created by Fede Garcia on 10/04/2026.
//

import SwiftData
import SwiftUI

extension NuevoProveedorView {
    @Observable
    class ViewModel {
        var modelContext: ModelContext? = nil
        var nombre = ""
        var contacto = ""
        
        func agregarProveedor() {
            modelContext?.insert(Proveedor(name: nombre, numeroContacto: contacto))
        }
    }
}
