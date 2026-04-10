//
//  ProveedoresView.swift
//  ElSanto
//
//  Created by Fede Garcia on 10/04/2026.
//

import SwiftUI
import SwiftData

struct ProveedoresView: View {
    @Environment(\.modelContext) var modelContext
    @Query() var proveedores: [Proveedor]
    
    var body: some View {
        NavigationStack {
            ScrollView  {
                ForEach(proveedores, id: \.id) { proveedor in
                    NavigationLink {
                        ProveedorDitail(proveedor: proveedor)
                    }
                    label: {
                        VStack{
                            Text(proveedor.name)
                                .font(.title)
                            HStack {
                                Text(proveedor.numeroContacto)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Text("Boleta : \(proveedor.boletaFacturacion.rawValue)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 400, height: 5)
                        .foregroundStyle(.secondary)
                }
            }
            .toolbar {
                Button {
                    modelContext.insert(Proveedor(name: "Coca-Cola", boletaFacturacion: .blanco,montos: [Facturas(monto: 200090.00, fecha: .now), Facturas(monto: 50000.00, fecha: .now)], numeroContacto: "11-2222-3333", ))
                } label: {
                    AddButton()
                }
            }
        }
        
    }
}

#Preview {
    ProveedoresView()
}
