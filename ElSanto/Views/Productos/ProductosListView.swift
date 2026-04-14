//
//  ProductosListView.swift
//  ElSanto
//
//  Created by Fede Garcia on 10/04/2026.
//

import SwiftData
import SwiftUI

struct ProductosListView: View {
    @Environment(\.modelContext) var modelContext
    @State private var viewModel = ViewModel()
    
    @State private var isShowingSheet = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            
            ZStack{
                Color.indigo.opacity(0.2)
                    .ignoresSafeArea()
            
                VStack {
                    if !viewModel.productos.isEmpty {
                        List {
                            ForEach(viewModel.filtrarProductos(searchText: searchText), id: \.id) { producto in
                                NavigationLink{
                                    ProductoDetailView(producto: producto)
                                } label: {
                                    CustomViewListLabel(producto: producto)
                                }
                            }
                            .onDelete(perform: viewModel.deleteProducto)
                        }
                        .padding(.horizontal, 10)
                        .listStyle(.automatic)
                        .listRowBackground(Color.clear)
                        .scrollContentBackground(.hidden)
                        .searchable(text: $searchText, prompt: "Buscar por nombre")
                        
                    } else {
                        ContentUnavailableView("No hay Productos cargados", systemImage: "basket")
                    }
                }
            }
            .navigationTitle("Productos")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button{
                    isShowingSheet = true
                } label: {
                    AddButton()
                }
                .buttonStyle(.borderedProminent)

            }
            .sheet(isPresented: $isShowingSheet) {
                NuevoProductoView(){
                    viewModel.fetchProductos()
                }
            }
        }
        .onAppear {
            viewModel.modelContext = modelContext
            viewModel.fetchProductos()
        }
    }
    
}

#Preview {
    ProductosListView()
}
