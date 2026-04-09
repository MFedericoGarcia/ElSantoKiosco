//
//  Proveedor.swift
//  ElSanto
//
//  Created by Fede Garcia on 07/04/2026.
//

import Foundation
import SwiftData

@Model
class Proveedor {
    
    var id: String
    var name: String
    var boletaFacturacion: String
//    var montos = [Facturas] ()
    var productos = [Producto]()
    
    init(id: String, name: String, boletaFacturacion: String, /*montos: [Facturas] = [Facturas] (),*/ productos: [Producto] = [Producto]()) {
        self.id = id
        self.name = name
        self.boletaFacturacion = boletaFacturacion
//        self.montos = montos
        self.productos = productos
    }
    
}
