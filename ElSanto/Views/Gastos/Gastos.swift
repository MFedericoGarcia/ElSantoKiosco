//
//  Gastos.swift
//  ElSanto
//
//  Created by Fede Garcia on 10/04/2026.
//

import SwiftData
import SwiftUI

struct Gastos: View {
    @Environment(\.modelContext) var modelContext
    @Query() var gastos: [Gasto]
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showSheet = false
    @State private var showAlert = false
    
    
    @State private var selectedGasto: Gasto?
    @State private var selectedTotal = ""
    
    var body: some View {
        NavigationStack {
            
            ZStack{
                Color.teal.opacity(0.2)
                    .ignoresSafeArea()
                
                VStack{
                    if !gastos.isEmpty {
                        List {
                            ForEach(gastos, id: \.id) { gasto in
                                Button {
                                    selectedGasto = gasto
                                }
                                label: {
                                    HStack{
                                        Text(gasto.nombre)
                                        Text(String(gasto.monto.formatted(.currency(code: "ARS").grouping(.automatic))))
                                    }
                                }
                                .swipeActions {
                                    Button("Delete", systemImage: "trash", role: .destructive) {
                                        modelContext.delete(gasto)
                                    }
                                }
                                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                    Button("Total", systemImage: "sum") {
                                        selectedTotal = gasto.gastoTotal()
                                        showAlert.toggle()
                                    }
                                    .tint(.cyan)
                                }
                            }
                            
                            
                        }
                        .padding(.horizontal, 10)
                        .listStyle(.automatic)
                        .listRowBackground(Color.clear)
                        .scrollContentBackground(.hidden)
                    } else {
                        ContentUnavailableView("Todavia no ingresaste Gastos", systemImage: "text.page.badge.magnifyingglass")
                    }
                }
            }
            .navigationTitle("Gastos")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $selectedGasto) { gasto in
                NuevoGastoEmpresaExistenteView(gasto: gasto)
            }
            .sheet(isPresented: $showSheet , content: {
                NuevoGastoView()
            })
            .alert("Gastos totales", isPresented: $showAlert) {
            } message: {
                Text(selectedTotal)
            }
            .toolbar {
                Button {
                    showSheet.toggle()
                } label: {
                     AddButton()
                }
                .buttonStyle(.borderedProminent)

            }
            

        }
    }
}

#Preview {
    Gastos()
}
