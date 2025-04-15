//
//  AchievementDetailView.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 09.04.25.
//

import SwiftUI

struct AchievementDetailView: View {
    let achievement: Achievement

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(achievement.title)
                .font(.title2)
                .bold()
                .multilineTextAlignment(.leading)

            Text(achievement.detail)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)

            Spacer()
        }
        .padding()
        .navigationTitle("Achievement")
    }
}
