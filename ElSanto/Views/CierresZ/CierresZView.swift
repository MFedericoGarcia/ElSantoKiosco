//
//  CierresZView.swift
//  ElSanto
//
//  Created by Fede Garcia on 13/04/2026.
//

import SwiftData
import SwiftUI

struct CierresZView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \CierresZ.fecha) var cierresZ : [CierresZ]
    
    @State private var isShowingSheet = false
    @State private var fecha: Date = .now
    @State private var cigarrillos = 0.0
    @State private var varios = 0.0
    
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
                Button {
                    isShowingSheet = true
                } label: {
                    AddButton()
                }
                .buttonStyle(.borderedProminent)

            }
            .sheet(isPresented: $isShowingSheet) {
                VStack {
                    Text("Nuevo Z")
                        .font(.title)
                        .padding()
                    
                    List {
                        Section("Varios"){
                            TextField("Varios", value: $varios, format: .currency(code: "ARS"))
                        }
                        Section("Cigarrillos"){
                            TextField("Cigarrillos", value: $cigarrillos, format: .currency(code: "ARS"))
                        }
                        DatePicker("Fecha", selection: $fecha, displayedComponents: .date)
                        
                    }
                    Button("Agregar Z") {
                        modelContext.insert(CierresZ(fecha: fecha, cigarrillos: cigarrillos, varios: varios))
                    }
                    .padding()
                    .font(.title3)
                    .tint(.orange.opacity(0.5))
                    .buttonStyle(.borderedProminent)
                    .foregroundStyle(.white)
                }
                .presentationDetents([.height(500)])
            }
        }
    }
}

#Preview {
    CierresZView(/*cierresZ: CierresZ.ejemplos*/)
}
