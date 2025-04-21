//
//  HubItem.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 09.04.25.
//

import Foundation

struct HubItem: Identifiable, Equatable {
    var id: String {
        icon + "$" + title + "$" + (subtitle ?? "")
    }
    let icon: String
    let title: String
    let subtitle: String?
    let destinationPage: Page
    let enabled: Bool
}
