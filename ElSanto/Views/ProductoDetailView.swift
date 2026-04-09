//
//  ProductoDetailView.swift
//  ElSanto
//
//  Created by Fede Garcia on 08/04/2026.
//

import SwiftUI
import UniformTypeIdentifiers

struct ProductoDetailView: View {
    
    var producto: Producto
    @State private var isShowingSheet = false
    @State private var listaDePrecios = [String]()
    @State private var isExporting = false
    
    
    var body: some View {
        VStack{
            List {
                HStack {
                    Text(producto.nombre)
                        .font(.title)
                    
                    Spacer()
                    
                    VStack {
                        Text(String(describing: producto.tipoProducto))
                        Image(systemName: producto.sfImage)
                            .font(.title)
                    }
                }
                
                Section("Precio Actual") {
                    HStack {
                        Text(" \(producto.precioCosto.formatted(.currency(code: "ARS")))")
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
                    ForEach(producto.preciosHistoricos) { historico in
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
                    listToStrings()
                    isExporting.toggle()
                }
                .fileExporter(
                    isPresented: $isExporting,
                    document: TextFile(initialLines: listaDePrecios),
                    contentType: .plainText,
                    defaultFilename: producto.nombre
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
            EditPrecioView(producto: producto)
        }
    }
    
    func listToStrings() {
        listaDePrecios.append("Precios Historicos de: \(producto.nombre)")
        listaDePrecios.append(" ")
        listaDePrecios.append("Precios  ------- Fechas")
        for precio in producto.preciosHistoricos {
            let stringed = "\(precio.precio) ------- \(precio.fechaString)"
            listaDePrecios.append(stringed)
        }
    }
    
}

#Preview {
    ProductoDetailView(producto: Producto.ejemplo)
}
