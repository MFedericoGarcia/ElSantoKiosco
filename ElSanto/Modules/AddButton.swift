//
//  AddButton.swift
//  ElSanto
//
//  Created by Fede Garcia on 09/04/2026.
//

import SwiftUI

struct AddButton: View {
    var body: some View {
        HStack {
            Image(systemName: "plus")
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    AddButton()
}
