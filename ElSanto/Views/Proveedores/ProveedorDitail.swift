//
//  ProveedorDitail.swift
//  ElSanto
//
//  Created by Fede Garcia on 10/04/2026.
//

import SwiftUI

struct ProveedorDitail: View {
    var proveedor: Proveedor
    
    var body: some View {
        Text(proveedor.name)
        
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
}

#Preview {
    ProveedorDitail(proveedor: .ejemplo)
}
