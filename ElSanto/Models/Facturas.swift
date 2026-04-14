//
//  Facturas.swift
//  ElSanto
//
//  Created by Fede Garcia on 07/04/2026.
//

import SwiftData
import SwiftUI

@Model
class Facturas: Comparable {
    
    var id: UUID
    var monto: Double
    var fecha: Date
    var facturacion: BlancoONegro
    
    enum BlancoONegro: String, Codable, CaseIterable {
        case blanco = "Blanco"
        case negro = "Negro"
        case cigarrillos = "Cigarrillos"
    }
    
    
    init(id: UUID = UUID(), monto: Double, fecha: Date, facturacion: BlancoONegro) {
        
        self.id = id
        self.monto = monto
        self.fecha = fecha
        self.facturacion = facturacion
        
    }
    
    static func < (lhs: Facturas, rhs: Facturas) -> Bool {
        lhs.fecha < rhs.fecha
    }

    static func == (lhs: Facturas, rhs: Facturas) -> Bool {
        lhs.fecha == rhs.fecha && lhs.monto == rhs.monto
    }
    
    var fechaString: String {
        String(fecha.formatted(date: .abbreviated, time: .omitted))
    }
    
}
