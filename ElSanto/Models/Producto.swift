//
//  Producto.swift
//  ElSanto
//
//  Created by Fede Garcia on 07/04/2026.
//

import Foundation
import SwiftData

@Model
class Producto {
    
    enum TipoProducto: String, Codable, CaseIterable {
        case bebidas = "Bebidas"
        case varios = "Varios"
        case cigarrillos = "Cigarrillos"
    }

    var id: UUID
    var nombre: String
    var precioCosto: Double
    var precioVenta: Double
    var tipoProducto: TipoProducto

    // Relationship to Proveedor (optional)
    var proveedores: Proveedor?
    var preciosHistoricos = [PreciosHistoricos]()
    
    

    init(id: UUID = UUID(), nombre: String, precioCosto: Double, precioVenta: Double, tipoProducto: TipoProducto, proveedores: Proveedor? = nil) {
        self.id = id
        self.nombre = nombre
        self.precioCosto = precioCosto
        self.precioVenta = precioVenta
        self.tipoProducto = tipoProducto
        self.proveedores = proveedores
        self.preciosHistoricos.append(PreciosHistoricos(fecha: .now, precio: precioCosto))
    }
    
    var sfImage: String {
        switch tipoProducto {
        case .bebidas:
            SFSymbols.bebidas
        case .varios:
            SFSymbols.varios
        case .cigarrillos:
            SFSymbols.cigarrillos
        }
    }
    
    func nuevoPrecio( nuevoPrecio: Double, fecha: Date) {
        precioCosto = nuevoPrecio
        preciosHistoricos.append(PreciosHistoricos(fecha: fecha, precio: nuevoPrecio))
    }
    
    static var ejemplo = Producto(nombre: "Caramelo", precioCosto: 80.0, precioVenta: 150.0, tipoProducto: .varios)
}
