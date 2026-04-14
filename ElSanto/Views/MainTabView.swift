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
        TabView {
            ProductosListView()
                .tabItem {
                    Label("Productos", systemImage: "chart.bar.horizontal.page")
                }
                .tint(.indigo.opacity(0.5))
            
            ProveedoresView()
                .tabItem {
                    Label("Proveedores", systemImage: "truck.box")
                }
                .tint(.brown.opacity(0.5))
            
            Gastos()
                .tabItem {
                    Label("Gastos", systemImage: "dollarsign.gauge.chart.leftthird.topthird.rightthird")
                }
                .tint(.teal.opacity(0.5))
            
            CierresZView()
                .tabItem {
                    Label("Contable", systemImage: "text.rectangle.page")
                }
                .tint(.red.opacity(0.5))
        
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    MainTabView()
}
