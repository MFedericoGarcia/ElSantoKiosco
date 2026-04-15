//
//  CierresZ.swift
//  ElSanto
//
//  Created by Fede Garcia on 13/04/2026.
//

import SwiftData
import Foundation

@Model
class CierresZ {
    
    var numeroDeZ: Int
    var fecha: Date
    var cigarrillos: Double
    var varios: Double
    
    init(numeroDeZ: Int, fecha: Date, cigarrillos: Double, varios: Double) {
        self.numeroDeZ = numeroDeZ
        self.fecha = fecha
        self.cigarrillos = cigarrillos
        self.varios = varios
    }
        
    // Datos de ejemplo para pruebas
    static var ejemplos: [CierresZ] {
        let cal = Calendar.current
        let now = Date()
        // Crear fechas en meses distintos (algunos en el mes actual, otros en meses anteriores)
        let f1 = now
        let f2 = cal.date(byAdding: .day, value: -3, to: now) ?? now
        let f3 = cal.date(byAdding: .month, value: -1, to: now) ?? now
        let f4 = cal.date(byAdding: .month, value: -2, to: now) ?? now
        let f5 = cal.date(byAdding: .month, value: -2, to: now).flatMap { cal.date(byAdding: .day, value: 10, to: $0) } ?? now

        return [
            CierresZ(numeroDeZ: 25, fecha: f1, cigarrillos: 1200.0, varios: 800.0),
            CierresZ(numeroDeZ: 19, fecha: f2, cigarrillos: 900.0, varios: 450.0),
            CierresZ(numeroDeZ: 24, fecha: f3, cigarrillos: 1500.0, varios: 600.0),
            CierresZ(numeroDeZ: 21, fecha: f4, cigarrillos: 700.0, varios: 300.0),
            CierresZ(numeroDeZ: 22, fecha: f5, cigarrillos: 1100.0, varios: 500.0)
        ]
    }
}
