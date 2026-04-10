//
//  ProveedoresView.swift
//  ElSanto
//
//  Created by Fede Garcia on 10/04/2026.
//

import SwiftUI
import SwiftData

struct ProveedoresView: View {
    @Environment(\.modelContext) var modelContext
    @State private var viewModel = ViewModel()
    
    @State private var showSheet = false
    @State private var searchText = ""

    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.filtrarProductos(searchText: searchText), id: \.id) { proveedor in
                    NavigationLink {
                        ProveedorDitailView(proveedor: proveedor)
                    }
                    label: {
                        VStack{
                            Text(proveedor.name)
                                .font(.title3)
                            HStack {
                                Text(proveedor.numeroContacto)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Text("Boleta : \(proveedor.boletaFacturacion.rawValue)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteProveedor)
            }
            .onAppear {
                viewModel.modelContext = modelContext
                viewModel.fetchProveedor()
            }
            .toolbar {
                Button {
                    showSheet = true
                } label: {
                    AddButton()
                }
            }
            .navigationTitle("Proveedores")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Buscar por nombre")
            .sheet(isPresented: $showSheet) {
                NuevoProveedorView(){
                    viewModel.fetchProveedor()
                }
            }
        }
        
    }
}

#Preview {
    ProveedoresView()
}
