//
//  SettingsView.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 09.04.25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("enableHaptics") private var enableHaptics = true
    @AppStorage("darkMode") private var darkMode = false

    @EnvironmentObject private var coordinator: Coordinator

    var body: some View {
        Form {
            generalSection
            personalizationSection
            supportSection
            developerSection
            aboutSection
        }
        .navigationTitle("Settings")
    }
}


// MARK: - Sections
private extension SettingsView {
    var generalSection: some View {
        Section(
            header: Text("General"),
            footer: Text("You will be redirected to the settings native page.")
        ) {
            Button(
                action:  {
                    guard let url = URL(string: UIApplication.openSettingsURLString),
                          UIApplication.shared.canOpenURL(url) else { return }
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                },
                label: {
                    HStack {
                        Label("Language", systemImage: "globe")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
            )
        }
    }

    var personalizationSection: some View {
        Section(header: Text("Personalization")) {
            Toggle(isOn: $enableHaptics) {
                Label("Enable Haptics", systemImage: "iphone.radiowaves.left.and.right")
            }

            Toggle(isOn: $darkMode) {
                Label("Dark Mode", systemImage: "moon.fill")
            }
        }
    }

    var supportSection: some View {
        Section(header: Text("Support")) {
            Link(destination: URL(string: "https://apps.apple.com/app/idXXXXXXXX")!) {
                Label("Rate the App", systemImage: "star.fill")
            }

            Link(destination: URL(string: "mailto:Giga.Khizanishvili@gmail.com")!) {
                Label("Send Feedback", systemImage: "envelope")
            }
        }
    }

    var developerSection: some View {
        Section(header: Text("Developer")) {
            Button(
                action: {
                    coordinator.push(.author)
                },
                label: {
                    Label("Giga Khizanishvili", systemImage: "person.text.rectangle")
                }
            )
        }
    }

    var aboutSection: some View {
        Section(header: Text("About")) {
            HStack {
                Label("Version", systemImage: "info.circle")
                Spacer()
                Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0")
                    .foregroundColor(.secondary)
            }
        }
    }
}
