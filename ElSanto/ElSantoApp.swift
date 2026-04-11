//
//  ElSantoApp.swift
//  ElSanto
//
//  Created by Fede Garcia on 07/04/2026.
//

import SwiftData
import SwiftUI

@main
struct ElSantoApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(for: [Proveedor.self, Gasto.self])
    }
}
