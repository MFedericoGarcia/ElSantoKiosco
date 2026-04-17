//
//  CustomColors.swift
//  ElSanto
//
//  Created by Fede Garcia on 17/04/2026.
//

import SwiftUI

/// A set of reusable app gradients that can be used anywhere a `ShapeStyle` is accepted,
/// e.g. `.foregroundStyle(AppGradient.primary.style)` or `.background(AppGradient.warning.style)`
enum AppGradient: CaseIterable {
    case primary
    case secondary
    case success
    case warning
    case danger
    case productBackground
}

extension AppGradient {
    /// Returns the underlying LinearGradient for this gradient preset
    var gradient: LinearGradient {
        switch self {
        case .primary:
            return LinearGradient(stops: Gradient(colors: [Color.gray, Color.white]).stops,
                                  startPoint: .leading, endPoint: .trailing)
        case .secondary:
            return LinearGradient(stops: Gradient(colors: [Color.blue.opacity(0.6), Color.cyan]).stops,
                                  startPoint: .topLeading, endPoint: .bottomTrailing)
        case .success:
            return LinearGradient(stops: Gradient(colors: [Color.green, Color.mint]).stops,
                                  startPoint: .leading, endPoint: .trailing)
        case .warning:
            return LinearGradient(stops: Gradient(colors: [Color.orange, Color.yellow]).stops,
                                  startPoint: .top, endPoint: .bottom)
        case .danger:
            return LinearGradient(stops: Gradient(colors: [Color.red, Color.pink]).stops,
                                  startPoint: .leading, endPoint: .trailing)
            
        case .productBackground:
            return LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.teal]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }

    /// Exposes a `ShapeStyle` for convenient use in `.foregroundStyle(...)`
    var style: some ShapeStyle { gradient }

    // Static conveniences so you can write `.foregroundStyle(AppGradient.primary)` directly
    // by leveraging the fact that LinearGradient conforms to ShapeStyle.
    static var primaryStyle: some ShapeStyle { AppGradient.primary.gradient }
    static var secondaryStyle: some ShapeStyle { AppGradient.secondary.gradient }
    static var successStyle: some ShapeStyle { AppGradient.success.gradient }
    static var warningStyle: some ShapeStyle { AppGradient.warning.gradient }
    static var dangerStyle: some ShapeStyle { AppGradient.danger.gradient }
}

// MARK: - Demo / Preview container (optional)
struct CustomColors: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Primary").foregroundStyle(AppGradient.primary.style)
            Text("Secondary").foregroundStyle(AppGradient.secondary.style)
            Text("Success").foregroundStyle(AppGradient.success.style)
            Text("Warning").foregroundStyle(AppGradient.warning.style)
            Text("Danger").foregroundStyle(AppGradient.danger.style)
        }
        .padding()
    }
}

#Preview {
    CustomColors()
}
