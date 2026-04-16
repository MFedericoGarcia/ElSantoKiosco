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
    
}
