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
    
    enum Boleta: String, Codable, CaseIterable {
        case blanco = "Blanco"
        case negro = "Negro"
    }
    
    var id: UUID
    var name: String
    var boletaFacturacion: Boleta
    var montos = [Facturas] ()
    var productos = [Producto]()
    var numeroContacto: String
    
    init(id: UUID = UUID(), name: String, boletaFacturacion: Boleta, montos: [Facturas] = [Facturas](), productos: [Producto] = [Producto](), numeroContacto: String = "") {
        self.id = id
        self.name = name
        self.boletaFacturacion = boletaFacturacion
        self.montos = montos
        self.productos = productos
        self.numeroContacto = numeroContacto
    }
    
#if DEBUG
    static var ejemplo = Proveedor(name: "Osle", boletaFacturacion: .blanco, montos: [Facturas(monto: 200090.00, fecha: .now), Facturas(monto: 50000.00, fecha: .now)] )
#endif
    
}
