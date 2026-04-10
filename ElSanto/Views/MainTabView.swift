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
            ContentView()
                .tabItem {
                    Label("Productos", systemImage: "chart.bar.horizontal.page")
                }
            
            ProveedoresView()
                .tabItem {
                    Label("Proveedores", systemImage: "truck.box")
                }
            
            Gastos()
                .tabItem {
                    Label("Gastos", systemImage: "dollarsign.gauge.chart.leftthird.topthird.rightthird")
                }
        }
    }
}

#Preview {
    MainTabView()
}
