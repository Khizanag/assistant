//
//  FlowLayout.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 09.04.25.
//

import SwiftUI

struct FlowLayout<Content: View>: View {
    let spacing: CGFloat
    let content: () -> Content

    init(spacing: CGFloat = 8, @ViewBuilder content: @escaping () -> Content) {
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        VStack {
            HStack {
                content()
            }
        }
    }
}
