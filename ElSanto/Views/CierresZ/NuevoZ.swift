//
//  NuevoZ.swift
//  ElSanto
//
//  Created by Fede Garcia on 15/04/2026.
//

import SwiftUI
import SwiftData

struct NuevoZ: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var fecha: Date = .now
    @State private var cigarrillos = 0.0
    @State private var varios = 0.0
    @State private var numeroDeZ = 0
    
    var body: some View {
        VStack {
            Text("Nuevo Z")
                .font(.title)
                .padding()
            
            Form {
                Section("Varios"){
                    TextField("Varios", value: $varios, format: .currency(code: "ARS").grouping(.automatic))
                        .keyboardType(.decimalPad)
                }
                Section("Cigarrillos"){
                    TextField("Cigarrillos", value: $cigarrillos, format: .currency(code: "ARS").grouping(.automatic))
                        .keyboardType(.decimalPad)
                }
                Section("Número de Z y fecha"){
                    HStack{
                        TextField("Num de Z", value: $numeroDeZ, format: .number)
                            .keyboardType(.decimalPad)
                       
                        DatePicker("Fecha", selection: $fecha, displayedComponents: .date)
                            .labelsHidden()
                    }
                }
                
            }
            Button("Agregar Z") {
                modelContext.insert(CierresZ(numeroDeZ: numeroDeZ, fecha: fecha, cigarrillos: cigarrillos, varios: varios))
                
                numeroDeZ = 0
                fecha = .now
                cigarrillos = 0
                varios = 0
                dismiss()
                
            }
            .padding()
            .font(.title3)
            .tint(.orange.opacity(0.5))
            .buttonStyle(.borderedProminent)
            .foregroundStyle(.white)
        }
        
        .presentationDetents([.height(550)])
    }
}

#Preview {
    NuevoZ()
}
