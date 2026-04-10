//
//  CustomViewListLabel.swift
//  ElSanto
//
//  Created by Fede Garcia on 09/04/2026.
//

import SwiftUI

struct CustomViewListLabel: View {
    var producto: Producto
    
    var body: some View {
        HStack {
            Image(systemName: producto.sfImage)
                .font(.caption)
            
            Text(producto.nombre)
                .font(.headline)
            
            Spacer()
            
            Text(String(producto.precioCosto.formatted(.currency(code: "ARS").grouping(.automatic))))
        }
    }
}

#Preview {
    CustomViewListLabel(producto: .ejemplo)
}
