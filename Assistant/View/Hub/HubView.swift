//
//  HubView.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 09.04.25.
//
import SwiftUI

struct HubView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel = HubViewModel()
    @State private var isEditing = false

    var body: some View {
        VStack {
            HStack {
                Spacer()

//                EditButton()
//                    .padding(.trailing, 16)
            }

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
                }
                .onMove(perform: viewModel.moveItem)
            }
            .environment(\.editMode, .constant(isEditing ? .active : .inactive))
            .animation(.default, value: isEditing)
        }
        .navigationTitle("Hub")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? "Done" : "Edit") {
                    isEditing.toggle()
                }
            }
        }
    }
}
