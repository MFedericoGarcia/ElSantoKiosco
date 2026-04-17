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
    @State private var searchText: String = ""
    @State private var searching = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color.brown.opacity(0.2)
                    .ignoresSafeArea()
                VStack{
                    if searching == false && viewModel.proveedores.isEmpty && searchText.isEmpty{
                        
                        ContentUnavailableView("No hay Proveedores cargados", systemImage: "truck.box.badge.clock")
                        
                    } else {
                        List {
                            ForEach(viewModel.proveedores, id: \.id) { proveedor in
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
                                        }
                                    }
                                }
                            }
                            .onDelete { index in
                                viewModel.deleteProveedor(at: index)
                            }
                            .onChange(of: searchText, { oldValue, newValue in
                                    searching = true
                                    viewModel.fetchProveedor(fetchByName: newValue)
                                
                            })
                        }
                        .padding(.horizontal, 10)
                        .listStyle(.automatic)
                        .listRowBackground(Color.clear)
                        .scrollContentBackground(.hidden)
                        .searchable(text: $searchText, prompt: "Buscar por nombre")
                        
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
                    .task {
                        viewModel.modelContext = modelContext
                        viewModel.fetchProveedor()
                    }
                }
                
            }
        }
        .onAppear {
            viewModel.modelContext = modelContext
            viewModel.fetchProveedor()
            searching = false
        }
    }
}
#Preview {
    ProveedoresView()
}
