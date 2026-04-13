//
//  ProductosListView.swift
//  ElSanto
//
//  Created by Fede Garcia on 10/04/2026.
//

import CodeScanner
import SwiftData
import SwiftUI
internal import AVFoundation

struct ProductosListView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var viewModel = ViewModel()
    
    @State private var isShowingSheet = false
    @State private var searchText = ""

    
    var body: some View {
        NavigationStack {
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
                    
                    .searchable(text: $searchText, prompt: "Buscar por nombre")
                    
                } else {
                    ContentUnavailableView("No hay Productos cargados", systemImage: "basket")
                }
            }
            .navigationTitle("Productos")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button{
                        isShowingSheet = true
                    } label: {
                        AddButton()
                            .font(.title)
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.isShowingScan = true
                } label: {
                    Image(systemName: "barcode.viewfinder")
                        .font(.title)
                }
                }
            }
            .sheet(isPresented: $isShowingSheet) {
                NuevoProductoView(){
                    viewModel.fetchProductos()
                }
            }
            .sheet(isPresented: $viewModel.isShowingScan) {
                    CodeScannerView(
                                    codeTypes: [.gs1DataBar, .code39, .codabar, .code128, .code39Mod43, .code93, .ean13, .ean8, .gs1DataBarExpanded, .gs1DataBarLimited],
                                    scanMode: .once,
                                    completion: viewModel.handleScann)
                 
                
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

