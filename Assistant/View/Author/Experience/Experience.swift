//
//  Experience.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 09.04.25.
//

struct Experience {
    let role: String
    let company: String
    let years: String
}

extension Experience: Identifiable {
    var id: String {
        role + company + years
    }
}
