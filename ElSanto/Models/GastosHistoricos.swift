//
//  GastosHistoricos.swift
//  ElSanto
//
//  Created by Fede Garcia on 11/04/2026.
//

import SwiftData
import Foundation

@Model
class GastosHistoricos: Comparable {
    var fecha: Date
    var monto: Double
    
    init(fecha: Date = .now, monto: Double) {
        self.fecha = fecha
        self.monto = monto
    }
    
    static func < (lhs: GastosHistoricos, rhs: GastosHistoricos) -> Bool {
        lhs.fecha < rhs.fecha
    }

    static func == (lhs: GastosHistoricos, rhs: GastosHistoricos) -> Bool {
        lhs.fecha == rhs.fecha && lhs.monto == rhs.monto
    }
    
    var fechaString: String {
        String(fecha.formatted(date: .abbreviated, time: .omitted))
    }
}
