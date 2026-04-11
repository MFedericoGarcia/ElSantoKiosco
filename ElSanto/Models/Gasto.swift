//
//  Gasto.swift
//  ElSanto
//
//  Created by Fede Garcia on 11/04/2026.
//

import SwiftData
import SwiftUI

@Model
class Gasto {
    var id: UUID
    var nombre: String
    var monto: Double
    var fecha: Date
    
    var gastosHistoricos = [GastosHistoricos]()
        
    init(id: UUID = UUID(), nombre: String, monto: Double, fecha: Date) {
        self.id = id
        self.nombre = nombre
        self.monto = monto
        self.fecha = fecha
        
    }
    
    func nuevoGasto( nuevoMonto: Double, fecha: Date = .now) {
        monto = nuevoMonto
        gastosHistoricos.append(GastosHistoricos(fecha: fecha, monto: monto))
        save()
    }
    
    func save() {
        if let context = self.modelContext {
            try? context.save()
        }
    }
    
    func gastoTotal() -> String {
        var total = 0.0
        if gastosHistoricos.isEmpty {
            total = monto
        } else {
            for gastosHistorico in gastosHistoricos {
                total += gastosHistorico.monto
            }
        }
        
        return String(total.formatted())
    }
    
#if DEBUG
    static var ejemplo = Gasto(nombre: "Edenor", monto: 45000, fecha: .now)
#endif
}
