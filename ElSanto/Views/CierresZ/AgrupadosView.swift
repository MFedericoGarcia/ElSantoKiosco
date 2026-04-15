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
    @Query() var cierresZ : [CierresZ]
    
    private let meses = [
          "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
          "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
      ]
    
    @State private var mesCorriente: Int = Calendar.current.component(.month, from: Date())
    
    var body: some View {
        VStack{
            List {
                ForEach(1..<13){ month in
                    if month <= mesCorriente {
                        Section("\(meses[month-1])"){
                                TabView {
                                    Text(totalMes(month: month, year: 2026, in: modelContext))
                                        .font(.title3.bold())
                                        .foregroundStyle((month == mesCorriente ? .mint : .white))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()
                                    
                                    Text(totalMes(month: month, year: 2026, in: modelContext))
                                        .font(.title3.bold())
                                        .foregroundStyle((month == mesCorriente ? .mint : .white))
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
    
    func totalMes(month: Int, year: Int, in context: ModelContext, calendar: Calendar = .current) -> String {
        var comps = DateComponents()
        comps.year = year
        comps.month = month
        comps.day = 1
        guard let startOfMonth = calendar.date(from: comps),
              let startOfNextMonth = calendar.date(byAdding: DateComponents(month: 1), to: startOfMonth) else {
            return "0"
        }

        // Construir un descriptor de fetch con filtro por rango de fechas
        var descriptor = FetchDescriptor<CierresZ>()
        descriptor.predicate = #Predicate<CierresZ> { item in
            item.fecha >= startOfMonth && item.fecha < startOfNextMonth
        }

        // Ejecutar el fetch y devolver el conteo
        do {
            let results = try context.fetch(descriptor)
            
            var totalVarios = 0.0
            var totalCigarrillos = 0.0

            for result in results {
                totalVarios += result.varios
                totalCigarrillos += result.cigarrillos
            }
            
            return "Cantidad de Z:  \(results.count) \nCigarrillos : \(totalCigarrillos)\nVarios : \(totalVarios)"
        } catch {
            print("Error fetching CierresZ for month: ", error.localizedDescription)
            return "0"
        }
    }
    
}

#Preview {
    AgrupadosView()
}
