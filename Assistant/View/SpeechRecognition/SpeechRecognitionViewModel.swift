//
//  SpeechRecognitionViewModel.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 15.04.25.
//

import Foundation
import AVFoundation
import Speech
final class SpeechRecognitionViewModel: ObservableObject {
    @Published var transcribedText: String = ""
    @Published var isListening: Bool = false
    @Published var selectedLocale = Locale(identifier: "en-US")

    let supportedLocales: [Locale] = [
        Locale(identifier: "en-US"),
        Locale(identifier: "fr-FR"),
        Locale(identifier: "de-DE"),
        Locale(identifier: "es-ES"),
        Locale(identifier: "it-IT"),
        Locale(identifier: "ru-RU"),
    ]

    private var speechRecognizer: SFSpeechRecognizer?
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?

    func requestPermissions() {
        SFSpeechRecognizer.requestAuthorization { status in
            DispatchQueue.main.async {
                if status != .authorized {
                    self.transcribedText = "Speech recognition not authorized"
                }
            }
        }

        AVAudioSession.sharedInstance()
            .requestRecordPermission { granted in
                DispatchQueue.main.async {
                    if !granted {
                        self.transcribedText = "Microphone access denied"
                    }
                }
            }
    }

    func startListening() {
        stopListening()
        isListening = true
        transcribedText = ""

        guard let speechRecognizer = SFSpeechRecognizer(locale: selectedLocale), speechRecognizer.isAvailable else {
            // TODO: Show error
            return
        }
        self.speechRecognizer = speechRecognizer

        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest else {
            // TODO: Show error
            return
        }

        recognitionRequest.shouldReportPartialResults = true

        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [weak self] result, error in
            if let result {
                DispatchQueue.main.async {
                    self?.transcribedText = result.bestTranscription.formattedString
                }
            }

            if error != nil || (result?.isFinal ?? false) {
                // TODO: Show error
                self?.stopListening()
            }
        }

        let format = audioEngine.inputNode.outputFormat(forBus: 0)
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { [weak self] buffer, _ in
            self?.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()
        try? audioEngine.start()
    }

    func stopListening() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()

        recognitionRequest = nil
        recognitionTask = nil
        speechRecognizer = nil

        isListening = false
    }
}
