//
//  ProveedorDitail.swift
//  ElSanto
//
//  Created by Fede Garcia on 10/04/2026.
//

import SwiftUI

struct ProveedorDitailView: View {
    var proveedor: Proveedor
    @State private var showSheet = false
    @State private var showAlert = false
    
    var body: some View {
        List {
            ForEach(proveedor.montos.sorted(by: { lh, rh in
                lh > rh
            })) { boleta in
                HStack {
                    Text(String((boleta.monto).formatted(.currency(code: "ARS").grouping(.automatic))))
                    Spacer()
                    Text(boleta.fechaString)
                }
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    showSheet.toggle()
                } label: {
                    AddButton()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showAlert.toggle()
                } label: {
                    Text("Total")
                    Image(systemName: "list.bullet.rectangle.portrait")
                }
            }
        }
        .sheet(isPresented: $showSheet, content: {
            NuevaBoletaView(proveedor: proveedor)
        })
        .navigationTitle(proveedor.name)
        .navigationBarTitleDisplayMode(.inline)
        
        //MARK: -- Transformar esto en una nueva vista con Posibilidad de elegir mes de total
        
        .alert("Total de Facturas de \(proveedor.name)", isPresented: $showAlert) {
            
        } message: {
            Text("El total es :\n \(proveedor.montosTotal(en: .now))")
        }
        
    }
}

#Preview {
    ProveedorDitailView(proveedor: .ejemplo)
}
