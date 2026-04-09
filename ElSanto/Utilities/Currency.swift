//
//  Currency.swift
//  ElSanto
//
//  Created by Fede Garcia on 08/04/2026.
//

import Foundation

extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static func appCurrency(code: String = "ARS") -> Self {
        .currency(code: code)
    }
}
