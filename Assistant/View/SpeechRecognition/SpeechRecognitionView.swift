//
//  SpeechRecognitionView.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 15.04.25.
//

import SwiftUI
import Speech
import AVFoundation
import SwiftUI
import Speech
import AVFoundation

struct SpeechRecognitionView: View {
    @StateObject private var viewModel = SpeechRecognitionViewModel()

    // MARK: - Body
    var body: some View {
        VStack(spacing: 16) {
            localePicker

            transcribedText

            startStopButton

            copyButton

            Spacer()
        }
        .padding()
        .navigationTitle("Speech to Text")
        .onAppear {
            viewModel.requestPermissions()
        }
    }
}

// MARK: - Private
private extension SpeechRecognitionView {
    var localePicker: some View {
        Picker("Language", selection: $viewModel.selectedLocale) {
            ForEach(viewModel.supportedLocales, id: \.identifier) { locale in
                Text(locale.localizedString(forIdentifier: locale.identifier) ?? locale.identifier)
                    .tag(locale)
            }
        }
        .pickerStyle(.menu)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .disabled(viewModel.isListening)
    }

    var transcribedText: some View {
        Text(viewModel.transcribedText)
            .padding()
            .frame(maxWidth: .infinity, minHeight: 200, alignment: .topLeading)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
    }

    var startStopButton: some View {
        Button(
            action: {
                viewModel.isListening ? viewModel.stopListening() : viewModel.startListening()
            },
            label: {
                Label(
                    title: {
                        Text(
                            viewModel.isListening ? "Stop Listening" : "Start Listening"
                        )
                        .font(.headline)
                    },
                    icon: {
                        Image(systemName: viewModel.isListening ? "stop.circle.fill" : "mic.circle.fill")
                    }
                )
                .padding()
                .frame(maxWidth: .infinity)
                .background(viewModel.isListening ? Color.red : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
        )
    }

    @ViewBuilder
    var copyButton: some View {
        if !viewModel.transcribedText.isEmpty {
            Button(
                action: {
                    UIPasteboard.general.string = viewModel.transcribedText
                },
                label: {
                    Label(
                        title: { Text("Copy Text") },
                        icon: { Image(systemName: "doc.on.doc") }
                    )
                }
            )
        }
    }
}
