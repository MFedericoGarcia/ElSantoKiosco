//
//  NuevoProveedorVM.swift
//  ElSanto
//
//  Created by Fede Garcia on 10/04/2026.
//

import SwiftData
import SwiftUI

extension NuevoProveedor {
    @Observable
    class ViewModel {
        var modelContext: ModelContext? = nil
        var nombre = ""
        var factura = Proveedor.Boleta.blanco
        var contacto = ""
        
        func agregarProveedor() {
            modelContext?.insert(Proveedor(name: nombre, boletaFacturacion: factura, numeroContacto: contacto))
        }
    }
}
