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
    var porcentajeGanancia: Double
    var codigoDeBarras: String = ""

    // Relationship to Proveedor (optional)
    var proveedores: Proveedor?
    var preciosHistoricos = [PreciosHistoricos]()
    
    

    init(id: UUID = UUID(), nombre: String, precioCosto: Double, precioVenta: Double, tipoProducto: TipoProducto, codigoDeBarras: String = "", proveedores: Proveedor? = nil) {
        self.id = id
        self.nombre = nombre
        self.precioCosto = precioCosto
        self.precioVenta = precioVenta
        self.tipoProducto = tipoProducto
        self.proveedores = proveedores
        self.porcentajeGanancia = ((precioVenta - precioCosto) / precioCosto) * 100
        
        self.codigoDeBarras = codigoDeBarras
        
        self.preciosHistoricos.append(PreciosHistoricos(fecha: .now, precio: precioCosto))
    }
    
    init(id: UUID = UUID(), nombre: String, precioCosto: Double, tipoProducto: TipoProducto, porcentajeGanancia: Double, codigoDeBarras: String = "", proveedores: Proveedor? = nil) {
        self.id = id
        self.nombre = nombre
        self.precioCosto = precioCosto
        self.precioVenta = precioCosto * (1 + porcentajeGanancia)
        self.tipoProducto = tipoProducto
        self.proveedores = proveedores
        self.porcentajeGanancia = porcentajeGanancia
        
        self.codigoDeBarras = codigoDeBarras
        
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
        precioVenta = precioCosto * ( 1 + porcentajeGanancia)
        save()
    }
    
    func nuevoPorcentaje( porcentaje: Double) {
        porcentajeGanancia = porcentaje
        precioVenta = precioCosto * (1 + porcentaje)
    }
    
    // Guarda los cambios del producto en su ModelContext
    func save() {
        if let context = self.modelContext {
            try? context.save()
        }
    }
    
#if DEBUG
    static var ejemplo = Producto(nombre: "Caramelo", precioCosto: 80.0, precioVenta: 150.0, tipoProducto: .varios)
#endif
    
   
}
