//
//  AchievementDataSource.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 09.04.25.
//

enum AchievementDataSource {
    static var all: [Achievement] = [
        .init(
            title: "Gold Medal - International Young Naturalists Tournament",
            detail: "Won gold in Belgrade, Serbia representing Georgia."
        ),
        .init(
            title: "100% Scholarship for National Exam Scores",
            detail: "Awarded full government scholarship for academic excellence."
        ),
        .init(
            title: "ACM ICPC NE Finals 2020 Participant",
            detail: "Competed in one of the most prestigious competitive programming events."
        ),
        .init(
            title: "National Olympiad Wins",
            detail: "Multiple wins in Math, Programming, and Physics Olympiads."
        ),
    ]
}
