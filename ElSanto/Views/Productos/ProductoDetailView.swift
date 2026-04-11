//
//  ProductoDetailView.swift
//  ElSanto
//
//  Created by Fede Garcia on 08/04/2026.
//

import SwiftUI
import UniformTypeIdentifiers

struct ProductoDetailView: View {
    @State private var viewModel: ViewModel
        
    @State private var isShowingSheet = false
    @State private var isExporting = false
    
    
    var body: some View {
        VStack{
            List {
                HStack {
                    Text(viewModel.producto.nombre)
                        .font(.title)
                    
                    Spacer()
                    
                    VStack {
                        Text(String(describing: viewModel.producto.tipoProducto))
                        Image(systemName: viewModel.producto.sfImage)
                            .font(.title)
                    }
                }
                
                Section("Precio Actual") {
                    HStack {
                        Text(" \(viewModel.producto.precioCosto.formatted(.currency(code: "ARS")))")
                            .keyboardType(.decimalPad)
                            .font(.title3)
                        Spacer()
                        Button {
                            isShowingSheet.toggle()
                        } label: {
                            HStack {
                                Text("Nuevo Precio")
                                Image(systemName: "arrow.trianglehead.counterclockwise")
                            }
                        }
                    }
                    
                }
                
                Section("Precios anteriores") {
                    ForEach(viewModel.producto.preciosHistoricos.sorted(by: { lh, rh in
                        lh < rh
                    })) { historico in
                        HStack {
                            Text(String(historico.precio))
                            Spacer()
                            Text(historico.fechaString)
                        }
                    }
                }
            }
            .toolbar {
                Button("Export .txt") {
                    viewModel.listToStrings()
                    isExporting.toggle()
                }
                .fileExporter(
                    isPresented: $isExporting,
                    document: TextFile(initialLines: viewModel.listaDePrecios),
                    contentType: .plainText,
                    defaultFilename: viewModel.producto.nombre
                ) { result in
                    switch result {
                    case .success(let url):
                        print("Archivo exportado en: \(url)")
                    case .failure(let error):
                        print("Error al exportar: \(error.localizedDescription)")
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            EditPrecioView(producto: viewModel.producto)
        }
    }
    
    init(producto: Producto) {
        self.viewModel = ViewModel(producto: producto)
    }
    
    
}

#Preview {
    ProductoDetailView(producto: Producto.ejemplo)
}
