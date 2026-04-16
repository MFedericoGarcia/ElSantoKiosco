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
    
    @State private var showingDatePicker = false

    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            Text("Nueva Factura")
                .font(.largeTitle)
                .padding(.top, 10)
            
            List {
                HStack {
                    TextField("Monto de la boleta", value: $viewModel.monto, format: .currency(code: "ARS").grouping(.automatic) )
                        .keyboardType(.decimalPad)

                    Button {
                        showingDatePicker = true
                    } label: {
                        Text(viewModel.fecha.formatted(date: .abbreviated, time: .omitted))
                    }
                        
                    
                    
                }
                Picker("Tipo de Boleta", selection: $viewModel.facturacion) {
                    Text("Blanco").tag("Blanco")
                    Text("Cigarrillos").tag("Cigarrillos")
                    Text("Presupuesto").tag("Negro")
                }
                .pickerStyle(.segmented)
            }
            .popover(isPresented: $showingDatePicker) {
                VStack {
                    DatePicker(
                        "",
                        selection: $viewModel.fecha,
                        in: ...Date(),
                        displayedComponents: .date
                    )
                    .labelsHidden()
                    .datePickerStyle(.wheel) // opcional

                    Button("Listo") {
                        showingDatePicker = false // cierra SOLO este sheet
                    }
                    .padding(.top)
                }
                .presentationDetents([.height(300)])
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
