//
//  NuevoProductoVM.swift
//  ElSanto
//
//  Created by Fede Garcia on 09/04/2026.
//

import CodeScanner
import SwiftData
import SwiftUI

extension NuevoProductoView {
    @Observable
    class ViewModel {
        var isShowingScan = false
        var modelContext: ModelContext? = nil
        var nombre = ""
        var costo = 0.0
        var venta = 0.0
        var tipo = Producto.TipoProducto.bebidas
        var porcentajeGanancia = 0.0
        var codigoDeBarras = ""
        
        
        func agregarProducto() {
            modelContext?.insert(Producto(nombre: nombre, precioCosto: costo, precioVenta: venta, tipoProducto: tipo, codigoDeBarras: codigoDeBarras))
            
        }
        
        func agregarProductoPorPorcentaje() {
            modelContext?.insert(Producto(nombre: nombre, precioCosto: costo, tipoProducto: tipo, porcentajeGanancia: porcentajeGanancia, codigoDeBarras: codigoDeBarras))
        }
        
        func handleScann( result: Result<ScanResult, ScanError>){
            switch result {
            case .success(let result):
                codigoDeBarras = result.string
                print(codigoDeBarras)
                isShowingScan = false
            case .failure(let error):
                print("Scanning failed: \(error.localizedDescription)")
            }
            
        }
    }
}
