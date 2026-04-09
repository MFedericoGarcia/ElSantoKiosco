//
//  TextFile.swift
//  ElSanto
//
//  Created by Fede Garcia on 08/04/2026.
//

import SwiftUI
import UniformTypeIdentifiers

struct TextFile: FileDocument {
    // Soporte de Archivos de plain text
    static var readableContentTypes: [UTType] { [.plainText] }

    var text: String

    // MARK: - Initializers

    init(initialLines: [String] = []) {
        self.text = initialLines.joined(separator: "\n")
    }

    init(initialText: String = "") {
        self.text = initialText
    }

    // Read initializer required by FileDocument
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents,
           let contents = String(data: data, encoding: .utf8) {
            self.text = contents
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }

    // Write method required by FileDocument
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }

    // get set [String]
    var lines: [String] {
        get { text.components(separatedBy: "\n") }
        set { text = newValue.joined(separator: "\n") }
    }
}
