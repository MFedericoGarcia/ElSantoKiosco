//
//  PreciosHistoricos.swift
//  ElSanto
//
//  Created by Fede Garcia on 08/04/2026.
//

import SwiftData
import Foundation

@Model
class PreciosHistoricos {
    var fecha: Date
    var precio: Double
    
    init(fecha: Date = .now, precio: Double) {
        self.fecha = fecha
        self.precio = precio
    }
    
    var fechaString: String {
        String(fecha.formatted(date: .abbreviated, time: .omitted)
)    }
    
}
