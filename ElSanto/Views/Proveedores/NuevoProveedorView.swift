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
            .tint(LinearGradient(stops: Gradient(colors: [Color.red.opacity(0.2), Color.blue.opacity(0.2)]).stops, startPoint: .leading, endPoint: .trailing))
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
