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
    var fecha: Date
    var cigarrillos: Double
    var varios: Double
    
    init(fecha: Date, cigarrillos: Double, varios: Double) {
        self.fecha = fecha
        self.cigarrillos = cigarrillos
        self.varios = varios
    }
    
    static func totalMes(month: Int, year: Int, in context: ModelContext, calendar: Calendar = .current) -> String {
        var comps = DateComponents()
        comps.year = year
        comps.month = month
        comps.day = 1
        guard let startOfMonth = calendar.date(from: comps),
              let startOfNextMonth = calendar.date(byAdding: DateComponents(month: 1), to: startOfMonth) else {
            return "0"
        }

        // Construir un descriptor de fetch con filtro por rango de fechas
        var descriptor = FetchDescriptor<CierresZ>()
        descriptor.predicate = #Predicate<CierresZ> { item in
            item.fecha >= startOfMonth && item.fecha < startOfNextMonth
        }

        // Ejecutar el fetch y devolver el conteo
        do {
            let results = try context.fetch(descriptor)
            
            var totalVarios = 0.0
            var totalCigarrillos = 0.0

            for result in results {
                totalVarios += result.varios
                totalCigarrillos += result.cigarrillos
            }
            
            return "en \(results.count) \n Cigarrillos : \(totalCigarrillos)\n Varios : \(totalVarios)"
        } catch {
            print("Error fetching CierresZ for month: ", error.localizedDescription)
            return "0"
        }
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
            CierresZ(fecha: f1, cigarrillos: 1200.0, varios: 800.0),
            CierresZ(fecha: f2, cigarrillos: 900.0, varios: 450.0),
            CierresZ(fecha: f3, cigarrillos: 1500.0, varios: 600.0),
            CierresZ(fecha: f4, cigarrillos: 700.0, varios: 300.0),
            CierresZ(fecha: f5, cigarrillos: 1100.0, varios: 500.0)
        ]
    }
}
