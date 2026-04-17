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
            
            ZStack{
                LinearGradient(colors: [Color.indigo, Color.black], startPoint: .topLeading, endPoint: .bottomTrailing)
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
                            .foregroundStyle(AppGradient.primaryStyle)
                    }
                }
                
                // Botón flotante en bottom trailing
                GeometryReader { proxy in
                    let size = proxy.size
                    Button {
                        viewModel.isShowingScan = true
                    } label: {
                        HStack(spacing: 8) {
                            Text("Buscar")
                                .foregroundStyle(.white)
                            Image(systemName: "barcode.viewfinder")
                                .font(.title2)
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Capsule().fill(Color.accentColor))
                        .shadow(radius: 4, y: 2)
                    }
                    .disabled(viewModel.productos.isEmpty)
                    .position(x: size.width - 16 - 60, y: size.height - 24 - 24)
                    // Nota: 60 es aprox. medio ancho; ajusta según tu diseño o calcula dinámicamente
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
                    }
                    .buttonStyle(.borderedProminent)

                }
                
                

            }
            .sheet(isPresented: $isShowingSheet) {
                NuevoProductoView(){
                    viewModel.fetchProductos()
                }
                .task {
                    viewModel.modelContext = modelContext
                    viewModel.fetchProductos()
                }
            }
            .sheet(isPresented: $viewModel.isShowingScan) {
                    CodeScannerView(
                                    codeTypes: [.gs1DataBar, .code39, .codabar, .code128, .code39Mod43, .code93, .ean13, .ean8, .gs1DataBarExpanded, .gs1DataBarLimited],
                                    scanMode: .once,
                                    completion: viewModel.handleScann)
                 
                
            }
            .sheet(item: $viewModel.barcodeScaned) { code in
                ProductoDetailView(producto: code)
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

