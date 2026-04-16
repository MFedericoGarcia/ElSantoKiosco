//
//  NuevaBoletaVM.swift
//  ElSanto
//
//  Created by Fede Garcia on 10/04/2026.
//

import SwiftUI

extension NuevaBoletaView {
    @Observable
    class ViewModel {
        var proveedor: Proveedor
        
        var monto: Double = 0.0
        var fecha: Date = .now
        var facturacion: String = "Blanco"
        
        init(proveedor: Proveedor) {
            self.proveedor = proveedor
        }
        
        func saveNewFacturaProveedor() {
            proveedor.nuevaFactura(monto: monto, fecha: fecha, facturacion: facturacion )
        }
    }
}
