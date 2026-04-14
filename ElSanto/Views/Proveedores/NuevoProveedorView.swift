//
//  NuevoProveedor.swift
//  ElSanto
//
//  Created by Fede Garcia on 10/04/2026.
//

import SwiftUI
import SwiftData

struct NuevoProveedorView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel = ViewModel()
    
    var refresh: (() -> Void)
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            Text("Proveedor Nuevo")
                .font(.largeTitle)
                .padding(.top, 10)
            
            List {
                TextField("Nombre del Proveedor", text: $viewModel.nombre)
                Picker("Tipo de Boleta", selection: $viewModel.factura) {
                    ForEach(Proveedor.Boleta.allCases, id: \.self){ tipo in
                        Text(String(tipo.rawValue))
                    }
                }
                .pickerStyle(.segmented)
                TextField("Número de contacto", text: $viewModel.contacto)
            }
            .onAppear {
                viewModel.modelContext = modelContext
            }
            Button("Agregar Proveedor") {
                viewModel.agregarProveedor()
                print("Creado")
                refresh()
                dismiss()
                
            }
            .padding()
            .font(.title3)
            .tint(.brown.opacity(0.5))
            .buttonStyle(.borderedProminent)
            .foregroundStyle(.white)
        }
        
        .presentationDetents([.height(350)])
    }
}

#Preview {
    NuevoProveedorView() {
        
    }
}
