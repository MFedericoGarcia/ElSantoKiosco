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
            ZStack{
                Color.brown.opacity(0.2)
                    .ignoresSafeArea()
                VStack{
                    if !viewModel.proveedores.isEmpty{
                        List {
                            let filtrados = viewModel.filtrarProductos(searchText: searchText)
                            ForEach(filtrados, id: \.id) { proveedor in
                                NavigationLink {
                                    ProveedorDitailView(proveedor: proveedor)
                                } label: {
                                    VStack {
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
                        .padding(.horizontal, 10)
                        .listStyle(.automatic)
                        .listRowBackground(Color.clear)
                        .scrollContentBackground(.hidden)
                        .searchable(text: $searchText, prompt: "Buscar por nombre")
                        
                    } else {
                        ContentUnavailableView("No hay Proveedores cargados", systemImage: "truck.box.badge.clock")
                    }
                }
                .navigationTitle("Proveedores")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                        showSheet = true
                    } label: {
                        AddButton()
                    }
                    .buttonStyle(.borderedProminent)

                }
                .sheet(isPresented: $showSheet) {
                    NuevoProveedorView(){
                        viewModel.fetchProveedor()
                    }
                }
                
            }
        }
        .onAppear {
            print("Reload")
            viewModel.modelContext = modelContext
            viewModel.fetchProveedor()
        }
    }
}
#Preview {
    ProveedoresView()
}
