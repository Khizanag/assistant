//
//  HubView.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 09.04.25.
//

import SwiftUI

struct HubView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var remoteConfig: AppRemoteConfig

    @StateObject private var viewModel = HubViewModel()
    @State private var isEditing = false

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.items) { item in
                    Button(
                        action: {
                            coordinator.push(item.destinationPage)
                        },
                        label: {
                            HStack(spacing: 16) {
                                Image(systemName: item.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.accentColor)

                                VStack(alignment: .leading) {
                                    Text(item.title)
                                        .font(.headline)

                                    if let subtitle = item.subtitle {
                                        Text(subtitle)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    )
                    .disabled(!item.enabled)
                }
                .onMove(perform: viewModel.moveItem)
            }
#if os(iOS) || targetEnvironment(macCatalyst)
            .environment(\.editMode, .constant(isEditing ? .active : .inactive))
#endif
            .animation(.default, value: isEditing)
        }
        .navigationTitle(remoteConfig.hubTitle)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(isEditing ? "Done" : "Edit") {
                    isEditing.toggle()
                }
            }
            ToolbarItem(placement: .secondaryAction) {
                resetOrderButton
            }
        }
    }
}

// MARK: - Private
private extension HubView {
    var resetOrderButton: some View {
        Button(
            action: {
                withAnimation {
                    viewModel.resetOrder()
                    isEditing = false
                }
            },
            label: {
                Label(
                    title: { Text("Reset Order") },
                    icon: { Image(systemName: "arrow.counterclockwise") }
                )
            }
        )
    }
}
