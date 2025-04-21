//
//  ClipboardStore.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 21.04.25.
//

import Foundation
import SwiftUI
import Combine
import SwiftData

@MainActor
final class ClipboardStore: ObservableObject {
    @Published var lastClipboard: String = ""
    private var timer: Timer?

    var modelContext: ModelContext?

    init() {

        startClipboardPolling()
    }

    func setContext(_ context: ModelContext) {
        self.modelContext = context
    }

    deinit {
        timer?.invalidate()
    }

    func startClipboardPolling() {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            self?.checkClipboard()
        }
    }

    private func checkClipboard() {
//        guard let clipboard = UIPasteboard.general.string, clipboard != lastClipboard else { return }
//        lastClipboard = clipboard
//
//        // Save to model if new
//        if !clipboard.trimmingCharacters(in: .whitespaces).isEmpty {
//            let item = ClipboardItem(content: clipboard)
//            modelContext?.insert(item)
//            try? modelContext?.save()
//        }
    }

    func toggleFavorite(_ item: ClipboardItem) {
        item.isFavorite.toggle()
        try? modelContext?.save()
    }

    func delete(_ item: ClipboardItem) {
        modelContext?.delete(item)
        try? modelContext?.save()
    }

    func clearAll(_ items: [ClipboardItem]) {
        for item in items {
            modelContext?.delete(item)
        }
        try? modelContext?.save()
    }
}
