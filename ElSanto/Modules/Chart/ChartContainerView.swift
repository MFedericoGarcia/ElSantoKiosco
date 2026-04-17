//
//  ChartContainerView.swift
//  ElSanto
//
//  Created by Fede Garcia on 17/04/2026.
//

import SwiftUI


struct ChartContainer<Content: View>: View {
    
    
    var title: String
    
    
    @ViewBuilder var content: () -> Content
    
    
    
    var symbol: String = "calendar"
       
    
    var subtitle: String = "Evolución"
    
    var accessibilityLabel: String = "Gráfico de barras, Precios"
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            navigationLinkView
            
            content()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
        
    }
    
    //MARK: - NavigationLink
    
    var navigationLinkView: some View {
            HStack {
                titleView
                Spacer()
            }
        .foregroundStyle(.secondary)
        .padding(.bottom, 12)
        .accessibilityAddTraits(.isHeader)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint("toca dos veces para ir a la lista de datos")
        .accessibilityRemoveTraits(.isButton)
    }
        
    // MARK: - Title
    
    var titleView: some View {
        VStack(alignment: .leading) {
            Label(title, systemImage: symbol)
                .font(.title3.bold())
                .foregroundStyle(.indigo)
                
            Text(subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .accessibilityAddTraits(.isHeader)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityElement(children: .contain)
    }
}


