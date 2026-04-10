//
//  ProveedorDitail.swift
//  ElSanto
//
//  Created by Fede Garcia on 10/04/2026.
//

import SwiftUI

struct ProveedorDitail: View {
    var proveedor: Proveedor
    @State private var showSheet = false
    
    var body: some View {
        List {
            ForEach(proveedor.montos.sorted(by: { lh, rh in
                lh > rh
            })) { boleta in
                HStack {
                    Text(String(boleta.monto))
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
        }
        .sheet(isPresented: $showSheet, content: {
            NuevaBoleta(proveedor: proveedor)
        })
        .navigationTitle(proveedor.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProveedorDitail(proveedor: .ejemplo)
}
