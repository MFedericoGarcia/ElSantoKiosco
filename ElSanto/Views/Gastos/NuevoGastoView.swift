//
//  NuevoGastoView.swift
//  ElSanto
//
//  Created by Fede Garcia on 11/04/2026.
//

import SwiftUI
import SwiftData

struct NuevoGastoView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var nombre = ""
    @State private var monto: Double = 0.0
    @State private var nuevaFecha: Date = .now
    
    var body: some View {
        List{
            TextField("Empresa / Nombre", text: $nombre)
                .font(.title2)
            HStack {
                TextField("", value: $monto, format: .currency(code: "ARS").grouping(.automatic))
                DatePicker("Fecha de Aumento", selection: $nuevaFecha, displayedComponents: .date)
                      .datePickerStyle(.compact)
                      .labelsHidden()
            }
            HStack(){
                Spacer()
                Button("Agregar Nuevo Gasto") {
                    modelContext.insert(Gasto(nombre: nombre, monto: monto, fecha: nuevaFecha))
                    dismiss()
                }
                Spacer()
            }
        }
        .presentationDetents([.height(250)])
    }
}

#Preview {
    NuevoGastoView()
}
