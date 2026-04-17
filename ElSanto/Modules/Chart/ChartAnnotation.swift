//
//  ChartAnnotation.swift
//  ElSanto
//
//  Created by Fede Garcia on 17/04/2026.
//

import SwiftUI
import Charts

struct ChartAnnotationView: ChartContent {
    
    let data: PreciosHistoricos
   
    
    var body: some ChartContent {
        RuleMark(x: .value("Selected Metric", data.fecha, unit: .day))
            .foregroundStyle(Color.secondary.opacity(0.3))
            .offset(y: -5)
            .annotation(position: .top, spacing: 0, overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) { annotationView }
    }
    
    var annotationView: some View {
        VStack(alignment: .leading) {
            Text(data.fecha, format:
                    .dateTime.weekday(.abbreviated).day().month(.abbreviated))
            .font(.footnote.bold())
            .foregroundStyle(.secondary)
            Text(data.precio, format: .currency(code: "ARS").grouping(.automatic))
                .fontWeight(.heavy)
                .foregroundStyle(.indigo)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: .secondary.opacity(0.3), radius: 2, x: 2, y: 2))
        .frame(width: 150)
    }
    
}
