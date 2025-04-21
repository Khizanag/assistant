//
//  ClipboardView.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 21.04.25.
//

import SwiftUI
import SwiftData

struct ClipboardView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \ClipboardItem.timestamp, order: .reverse) private var items: [ClipboardItem]
    @StateObject private var store: ClipboardStore

    init() {
        let clipboardStore = ClipboardStore()
        _store = StateObject(wrappedValue: clipboardStore)

    }

    var body: some View {
        List {
            ForEach(items) { item in
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.content)
                            .lineLimit(2)
                            .font(.body)

                        Text(item.timestamp.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Button {
                        store.toggleFavorite(item)
                    } label: {
                        Image(systemName: item.isFavorite ? "star.fill" : "star")
                            .foregroundStyle(.yellow)
                    }

                    Menu {
                        Button("Copy") {
                            UIPasteboard.general.string = item.content
                        }

                        Button("Share") {
                            shareText(item.content)
                        }

                        Button(role: .destructive) {
                            store.delete(item)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("Clipboard History")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Clear All") {
                    store.clearAll(items)
                }
            }
        }
        .onAppear {
            store.setContext(context)
        }
    }

    private func shareText(_ text: String) {
        let av = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            scene.windows.first?.rootViewController?.present(av, animated: true)
        }
    }
}
