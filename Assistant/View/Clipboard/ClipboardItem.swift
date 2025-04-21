//
//  ClipboardItem.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 21.04.25.
//

import Foundation
import SwiftData

@Model
final class ClipboardItem: Identifiable {
    @Attribute(.unique) var id: String = UUID().uuidString
    var content: String
    var timestamp: Date
    var isFavorite: Bool

    init(content: String, timestamp: Date = .now, isFavorite: Bool = false) {
        self.content = content
        self.timestamp = timestamp
        self.isFavorite = isFavorite
    }
}
