//
//  GuadrarButton.swift
//  ElSanto
//
//  Created by Fede Garcia on 09/04/2026.
//

import SwiftUI

struct GuadrarButton: View {
    var body: some View {
        HStack{
            Text("Guardar")
                .font(.title)
            Image(systemName: "square.and.arrow.down.fill")
                .font(.title)
        }
        .buttonStyle(.bordered)
        .tint(.teal)
    }
    
}

#Preview {
    GuadrarButton()
}
