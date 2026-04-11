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
            }

        }
    }
}

#Preview {
    Gastos()
}
