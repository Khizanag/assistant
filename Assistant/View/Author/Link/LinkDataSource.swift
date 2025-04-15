//
//  LinkDataSource.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 09.04.25.
//

import Foundation

enum LinkDataSource {
    static let all: [LinkModel] = [
        .init(
            title: "GitHub",
            url: URL(string: "https://github.com/khizanag")!,
            iconSystemName: "chevron.left.slash.chevron.right"
        ),
        .init(
            title: "LinkedIn",
            url: URL(string: "https://www.linkedin.com/in/khizanag")!,
            iconSystemName: "link"
        ),
        .init(
            title: "LeetCode",
            url: URL(string: "https://leetcode.com/khizanag")!,
            iconSystemName: "brain.head.profile"
        ),
        .init(
            title: "X",
            url: URL(string: "https://x.com/khizanag")!,
            iconSystemName: "xmark.circle"
        ),
    ]
}
