//
//  ProjectCard.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 09.04.25.
//

import SwiftUI

struct ProjectCard: View {
    let title: String
    let tech: String
    let desc: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.headline)
            Text(tech)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(desc)
                .font(.footnote)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}
