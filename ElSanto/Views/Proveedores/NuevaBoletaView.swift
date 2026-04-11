//
//  NuevaBoleta.swift
//  ElSanto
//
//  Created by Fede Garcia on 10/04/2026.
//

import SwiftUI

struct NuevaBoletaView: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            Text("Nueva Factura")
                .font(.largeTitle)
                .padding(.top, 10)
            
            List {
                HStack {
                    TextField("Monto de la boleta", value: $viewModel.monto, format: .currency(code: "ARS").grouping(.automatic) )
                        .keyboardType(.decimalPad)

                    DatePicker(selection: $viewModel.fecha, displayedComponents: .date) {
                        Text("")
                    }
                }
            }
            Button("Agregar Boleta") {
                dismiss()
                viewModel.saveNewFacturaProveedor()
            }
        }
        
        .presentationDetents([.height(250)])
    }
    
    init(proveedor: Proveedor) {
        self.viewModel = ViewModel(proveedor: proveedor)
    }
}

#Preview {
    NuevaBoletaView(proveedor: .ejemplo)
}
