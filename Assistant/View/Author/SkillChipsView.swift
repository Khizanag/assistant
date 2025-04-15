//
//  SkillChipsView.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 09.04.25.
//

import SwiftUI

struct SkillChipsView: View {
    let skills: [String]

    var body: some View {
        FlowLayout(spacing: 12) {
            ForEach(skills, id: \.self) { skill in
                Text(skill)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
            }
        }
    }
}
