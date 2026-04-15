//
//  CierresZView.swift
//  ElSanto
//
//  Created by Fede Garcia on 13/04/2026.
//

import SwiftData
import SwiftUI

struct CierresZView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Query(sort: \CierresZ.fecha, order: .reverse) var cierresZ : [CierresZ]
    
    @State private var isShowingSheet = false
    
    
    var body: some View {
        NavigationStack {
            
            ZStack{
                Color.orange.opacity(0.2)
                    .ignoresSafeArea()
                
                VStack {
                    if !cierresZ.isEmpty {
                        List {
                            ForEach(cierresZ, id: \.self) { cierre in
                                Section("\(cierre.fecha.formatted(date: .abbreviated, time: .omitted))"){
                                    HStack{
                                        Text("Cigarrillos: \(cierre.cigarrillos.formatted(.currency(code: "ARS")))")
                                        Spacer()
                                        Text("Varios: \(cierre.varios.formatted(.currency(code: "ARS")))")
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                        .listStyle(.automatic)
                        .listRowBackground(Color.clear)
                        .scrollContentBackground(.hidden)
                    } else {
                        ContentUnavailableView("Todavia no hay 'Z's ingresados", systemImage: "z.square")
                    }
                }
            }
            .navigationTitle("Cierres Z")
            .navigationBarTitleDisplayMode(.inline)

            .toolbar {
                    ToolbarItem {
                        Button {
                            isShowingSheet = true
                        } label: {
                            AddButton()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink {
                        AgrupadosView()
                    } label: {
                        Text("Agrupados")
                    }
                }
            

            }
            .sheet(isPresented: $isShowingSheet) {
                NuevoZ()
            }
        }
    }
}

#Preview {
    CierresZView()
}
