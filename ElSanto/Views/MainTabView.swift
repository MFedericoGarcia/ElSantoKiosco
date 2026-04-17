//
//  MainTabView.swift
//  ElSanto
//
//  Created by Fede Garcia on 10/04/2026.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    var body: some View {
        
            if #available(iOS 26.3, *) {
                TabView {
                    Tab("Productos" , systemImage: "chart.bar.horizontal.page") {
                        ProductosListView()
                            .tint(.indigo)
                    }
                    
                    Tab("Proveedores", systemImage: "truck.box") {
                        ProveedoresView()
                            .tint(.brown)
                    }
                    
                    Tab("Gastos", systemImage: "dollarsign.gauge.chart.leftthird.topthird.rightthird") {
                        Gastos()
                            .tint(.teal)
                    }
                    
                    Tab("Contable", systemImage: "text.rectangle.page") {
                        CierresZView()
                            .tint(.orange)
                    }
                }
                .preferredColorScheme(.dark)
            } else {
                TabView {
                    ProductosListView()
                        .tabItem {
                            Label("Productos", systemImage: "chart.bar.horizontal.page")
                        }
                        .tint(.indigo)
                    
                    ProveedoresView()
                        .tabItem {
                            Label("Proveedores", systemImage: "truck.box")
                        }
                        .tint(.brown)
                    
                    Gastos()
                        .tabItem {
                            Label("Gastos", systemImage: "dollarsign.gauge.chart.leftthird.topthird.rightthird")
                        }
                        .tint(.teal)
                    
                    CierresZView()
                        .tabItem {
                            Label("Contable", systemImage: "text.rectangle.page")
                        }
                        .tint(.orange)
                }
                .preferredColorScheme(.dark)
            }
        }
       
}

#Preview {
    MainTabView()
}
