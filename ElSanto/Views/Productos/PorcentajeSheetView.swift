//
//  PorcentajeSheetView.swift
//  ElSanto
//
//  Created by Fede Garcia on 13/04/2026.
//

import SwiftUI

struct PorcentajeSheetView: View {
    @Binding var nuevoPorcentaje: Double
    var onSave: () -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        List {
            Section("Nuevo porcentaje") {
                TextField("Nuevo Porcentaje", value: $nuevoPorcentaje, format: .percent)
            }
            Button("Guardar Porcentaje") {
                onSave()
                dismiss()
            }
        }
        .presentationDetents([.height(200)])
    }
}

