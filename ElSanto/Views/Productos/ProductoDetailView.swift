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
    @Environment(\.dismiss) var dismiss

        
    @State private var isShowingSheet = false
    @State private var isExporting = false
    @State private var isShowingPercent = false
    @State private var nuevoPorcentaje = 0.0
    @State private var showChart = false
    
    
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
                
                Section("Precio de venta") {
                    HStack {
                        Text("\(viewModel.producto.precioVenta.formatted(.currency(code: "ARS")))")
                        Spacer()
                        
                        Button {
                            isShowingPercent = true
                        } label: {
                            HStack {
                                Text("Porcentaje")
                                Text("\(viewModel.producto.porcentajeGanancia.formatted(.percent))")
                            }
                            
                        }
                        
                        
                    }
                }
                
                Section("Precios anteriores") {
                    if showChart {
                        ChartPreciosView(producto: viewModel.producto)
                    } else {
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
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
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
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showChart.toggle()
                    } label: {
                        Text( showChart ? "Lista" : "Gráfico")
                        Image(systemName: showChart ? "list.bullet.rectangle.portrait" : "chart.bar" )
                    }
                }
                
                
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            EditPrecioView(producto: viewModel.producto)
        }
        .sheet(isPresented: $isShowingPercent) {
            PorcentajeSheetView(nuevoPorcentaje: $nuevoPorcentaje) {
                viewModel.producto.nuevoPorcentaje(porcentaje: nuevoPorcentaje)
            }
        }
    }
    
    init(producto: Producto) {
        self.viewModel = ViewModel(producto: producto)
    }
    
    
}

#Preview {
    ProductoDetailView(producto: Producto.ejemplo)
}


