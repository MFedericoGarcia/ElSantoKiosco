//
//  NuevaBoleta.swift
//  ElSanto
//
//  Created by Fede Garcia on 10/04/2026.
//

import SwiftUI

struct NuevaBoleta: View {
    @Environment(\.dismiss) var dismiss
    var proveedor: Proveedor
    
    @State private var monto: Double = 0.0
    @State private var fecha: Date = .now
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            Text("Nueva Factura")
                .font(.largeTitle)
                .padding(.top, 10)
            
            List {
                HStack {
                    TextField("Monto de la boleta", value: $monto, format: .currency(code: "ARS") )
                    DatePicker(selection: $fecha, displayedComponents: .date) {
                        Text("")
                    }
                }
            }
            Button("Agregar Boleta") {
                dismiss()
                // AGREGAR SAVE()
            }
        }
        
        .presentationDetents([.height(250)])
    }
}

#Preview {
    NuevaBoleta(proveedor: .ejemplo)
}
