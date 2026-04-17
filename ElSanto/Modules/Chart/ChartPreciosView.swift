//
//  ChartPreciosView.swift
//  ElSanto
//
//  Created by Fede Garcia on 17/04/2026.
//


import SwiftData
import SwiftUI
import Charts

struct ChartPreciosView: View {
    var producto: Producto
    //MARK: - Variables
    
    @State private var rawSelectedDate : Date?
    @State private var selectedDay: Date?
    
    var chartData: [PreciosHistoricos] {
        // Return historical prices sorted by date ascending
        return producto.preciosHistoricos.sorted { lhs, rhs in
            lhs.fecha < rhs.fecha
        }
    }
    
    var fechaPrecioSeleccionado: PreciosHistoricos? {
        parseSelectedData(for: chartData, in: rawSelectedDate)
    }
        
    //MARK: - Body
    
    var body: some View {
        //MARK: - Container start

        ChartContainer(title: "Precios de \(producto.nombre)") {
            
                // MARK: - Chart
                
                Chart {
                    
                    if let fechaPrecioSeleccionado {
                        ChartAnnotationView(data: fechaPrecioSeleccionado)
                    }
                    
                    ForEach(chartData) { steps in
                        let xDate: Date = steps.fecha
                        let yPrice: Double = steps.precio
                        let isSelected: Bool = {
                            guard let rawSelectedDate else { return true }
                            return Calendar.current.isDate(xDate, inSameDayAs: fechaPrecioSeleccionado?.fecha ?? rawSelectedDate)
                        }()

                        BarMark(
                            x: .value("Fecha", xDate, unit: .day),
                            y: .value("Precio", yPrice)
                        )
                        .opacity(isSelected ? 1.0 : 0.3)
                        .foregroundStyle(Color.indigo.gradient)
                    }
                }
                .frame(height: 150)
                .chartXSelection(value: $rawSelectedDate.animation(.easeInOut))
                .chartXAxis{
                    AxisMarks(values: .automatic) {
                        AxisValueLabel(format: .dateTime.month(.defaultDigits).day(), centered: true)
                    }
                }
                .chartYAxis {
                    AxisMarks { value in
                        AxisGridLine()
                            .foregroundStyle(Color.secondary.opacity(0.3))
                        
                        AxisValueLabel((value.as(Double.self) ?? 0 ).formatted(.number.notation(.compactName)))
                    }
                }
            
                .overlay {
                    //MARK: - Empty View
                        
                    if chartData.isEmpty {
                        ContentUnavailableView("Sin Datos", systemImage: "chart.bar")
                    }
                }
        }
        .sensoryFeedback(.selection, trigger: selectedDay)
        .onChange(of: rawSelectedDate) { oldValue, newValue in
            selectedDay = newValue
        }
    }
    
    
    func parseSelectedData( for data: [PreciosHistoricos] ,in selectedDate: Date?) -> PreciosHistoricos? {
        guard let selectedDate else { return nil }
        return data.first {
            Calendar.current.isDate(selectedDate, inSameDayAs: $0.fecha)
        }
    }
}

