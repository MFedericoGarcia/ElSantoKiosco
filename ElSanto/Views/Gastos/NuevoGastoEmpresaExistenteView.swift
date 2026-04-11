//
//  NuevoGastoEmpresaExistenteView.swift
//  ElSanto
//
//  Created by Fede Garcia on 11/04/2026.
//

import SwiftUI

struct NuevoGastoEmpresaExistenteView: View {
    @Environment(\.dismiss) var dismiss
    
    var gasto: Gasto
    
    @State private var nuevoMonto = 0.0
    @State private var nuevaFecha = Date.now
    
    var body: some View {
        VStack{
            Text(gasto.nombre)
                .font(.headline)
            HStack{
                TextField("Monto: ", value: $nuevoMonto, format: .currency(code: "ARS").grouping(.automatic))
                    .keyboardType(.decimalPad)

                DatePicker("Fecha de Aumento", selection: $nuevaFecha, displayedComponents: .date)
                      .datePickerStyle(.compact)
                      .labelsHidden()
            }
            .padding(.horizontal, 30)
            Button("Agregar Gasto") {
                gasto.nuevoGasto(nuevoMonto: nuevoMonto, fecha: nuevaFecha)
                dismiss()
            }
            .buttonStyle(.bordered)
            .tint(.orange)
        }
        .presentationDetents([.height(300)])
    }
}

#Preview {
    NuevoGastoEmpresaExistenteView(gasto: .ejemplo)
}
