//
//  ContentView.swift
//  ElSanto
//
//  Created by Fede Garcia on 07/04/2026.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var viewModel = ViewModel()
    
    @State private var isShowingSheet = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.filtrarProductos(searchText: searchText), id: \.id) { producto in
                    NavigationLink{
                        ProductoDetailView(producto: producto)
                    } label: {
                        CustomViewListLabel(producto: producto)
                    }
                }
            }
            .onAppear {
                viewModel.modelContext = modelContext
                viewModel.fetchProductos()
            }
            .toolbar {
                Button{
                    isShowingSheet = true
                } label: {
                    AddButton()
                }
            }
            .navigationTitle("El Santo")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Buscar por nombre")
            .sheet(isPresented: $isShowingSheet) {
                NuevoProductoView()
            }
        }
    }
}

#Preview {
    ContentView()
}
