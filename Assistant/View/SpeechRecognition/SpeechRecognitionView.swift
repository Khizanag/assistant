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

    var body: some View {
        VStack(spacing: 24) {
            localePicker

            // MARK: - Transcribed Text
            Text(viewModel.transcribedText)
                .padding()
                .frame(maxWidth: .infinity, minHeight: 200, alignment: .topLeading)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)

            startStopButton

            // MARK: - Copy Button
            if !viewModel.transcribedText.isEmpty {
                Button("Copy Text") {
                    UIPasteboard.general.string = viewModel.transcribedText
                }
                .padding(.top)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Speech to Text")
        .onAppear {
            viewModel.requestPermissions()
        }
    }
}

extension SpeechRecognitionView {
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

    var startStopButton: some View {
        Button(viewModel.isListening ? "Stop Listening" : "Start Listening") {
            viewModel.isListening ? viewModel.stopListening() : viewModel.startListening()
        }
        .font(.headline)
        .padding()
        .frame(maxWidth: .infinity)
        .background(viewModel.isListening ? Color.red : Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}
