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
    var montos = [Facturas]()
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
    
    func nuevaFactura(monto: Double, fecha: Date, facturacion: Facturas.BlancoONegro) {
        montos.append(Facturas(monto: monto, fecha: fecha, facturacion: facturacion))
        save()
    }
    
   
    
    /// Suma los montos de las facturas que pertenecen al mismo mes y año de la fecha indicada.
    /// - Parameter fecha: Fecha de referencia cuyo mes y año se usarán para filtrar.
    /// - Returns: Total de montos para el mes y año de la fecha proporcionada.
    
    func montosTotal(en fecha: Date) -> String {
        let calendar = Calendar.current
        let target = calendar.dateComponents([.year, .month], from: fecha)
        var total = 0.0
        for factura in montos {
            let comps = calendar.dateComponents([.year, .month], from: factura.fecha)
            if comps.year == target.year && comps.month == target.month {
                total += factura.monto
            }
        }
        let finalTotal = (String((total).formatted(.currency(code: "ARS").grouping(.automatic))))
        return finalTotal
    }
    
    func save() {
        if let context = self.modelContext {
            try? context.save()
        }
    }
#if DEBUG
    static var ejemplo = Proveedor(name: "Osle", boletaFacturacion: .blanco, montos: [Facturas(monto: 200090.00, fecha: .now, facturacion: .blanco), Facturas(monto: 50000.00, fecha: .now, facturacion: .blanco)] )
#endif
    
}
