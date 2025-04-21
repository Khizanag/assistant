//
//  ExperienceItem.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 09.04.25.
//

import SwiftUI

struct ExperienceItemView: View {
    let experience: Experience

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(experience.role)
                    .fontWeight(.semibold)

                Text(experience.company)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Text(experience.years)
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .contentShape(Rectangle())
        .contextMenu {
            Button(
                action: {
                    copyToClipboard(
                                    """
                                    Role: \(experience.role)
                                    Company: \(experience.company)
                                    Years: \(experience.years)
                                    """
                    )
                },
                label: {
                    Text("Copy Experience")
                    Image(systemName: "doc.on.doc")
                }
            )
        }
    }
}
