//
//  AgrupadosView.swift
//  ElSanto
//
//  Created by Fede Garcia on 15/04/2026.
//

import SwiftData
import SwiftUI

struct AgrupadosView: View {
    @Environment(\.modelContext) var modelContext
    @State private var viewModel = ViewModel()
            
    var body: some View {
        VStack{
            List {
                ForEach(1..<13){ month in
                    if month <= viewModel.mesCorriente {
                        Section("\(viewModel.meses[month-1])"){
                                TabView {
                                    Text(viewModel.totalMes(month: month, modelContext: modelContext))
                                        .font(.title3.bold())
                                        .foregroundStyle((month == viewModel.mesCorriente ? .mint : .white))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()
                                    
                                    Text(viewModel.boletasTotalMes(month: month, modelContext: modelContext))
                                        .font(.title3.bold())
                                        .foregroundStyle((month == viewModel.mesCorriente ? .mint : .white))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()
                                }
                                .tabViewStyle(.page(indexDisplayMode: .automatic))
                                .frame( height: 140)
                        }
                    }
                }
            }
            
            .navigationTitle(" Z Agrupados")
        }
        
        
    }  
}

#Preview {
    AgrupadosView()
}
