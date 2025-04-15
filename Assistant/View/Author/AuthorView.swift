//
//  AuthorView.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 09.04.25.
//

import SwiftUI

struct AuthorView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 48) {
                header

                Group {
                    aboutView

//                    skillsView

                    experienceView

                    achievementsView

                    projectsView

                    linksView

                    contactView

                    Spacer(minLength: 16)
                }
                .padding(.horizontal, 16)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationTitle("About the Author")
    }
}

private extension AuthorView {

    // MARKL: - Header
    var header: some View {
        ZStack {
            LinearGradient(
                colors: [.blue.opacity(0.6), .purple.opacity(0.4)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.top)

            VStack(spacing: 12) {
                Image("author")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    .shadow(radius: 10)

                Text("Giga Khizanishvili")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text("iOS Engineer • Educator • Competitive Programmer")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))

                Text(Constant.location)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.75))
            }
            .padding(.top, 160) // TODO: Fix
            .padding(.bottom, 32)
        }
    }

    // MARK: - About
    var aboutView: some View {
        makeSection("👋 About Me") {
            Text(
                    """
                    I'm a passionate iOS developer with a strong mathematical and algorithmic background. With years of hands-on experience building banking and gaming apps at scale, I focus on quality architecture, performance, and user experience.
                    
                    I thrive on solving complex problems, building useful tools, and teaching future developers.
                    """
            )
        }
    }

    // MARK: - Skills
    var skillsView: some View {
        makeSection("🧠 Skills & Technologies") {

            SkillChipsView(
                skills: [
                    "Swift",
                    "SwiftUI",
                    "UIKit",
                    "CoreData",
                    "Concurrency",
                    "MVVM",
                    "Algorithms",
                    "Distributed Systems",
                    "TDD",
                    "Python",
                    "Go",
                    "Java",
                    "C++",
                ]
            )
        }
    }

    // MARK: - Experience
    var experienceView: some View {
        makeSection("💼 Experience") {

            ForEach(ExperienceDataSource.all) { experience in
                ExperienceItemView(experience: experience)
            }
        }
    }

    // MARK: - Achievements
    var achievementsView: some View {
        makeSection("🏆 Achievements") {
            ForEach(AchievementDataSource.all) { achievement in
                NavigationLink(destination: AchievementDetailView(achievement: achievement)) {
                    Text(achievement.title)
                }
            }
        }
    }

    // MARK: - Projects
    var projectsView: some View {
        makeSection("🧪 Featured Projects") {

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ProjectCard(title: "Georgia Murals", tech: "iOS + SwiftUI", desc: "Interactive mural explorer app")
                ProjectCard(title: "Quiz App", tech: "Java + MySQL", desc: "Online multiplayer quiz platform")
                ProjectCard(title: "AI Pacman", tech: "Python", desc: "AI bots using Expectimax & RL")
                ProjectCard(title: "Raft Consensus", tech: "Go", desc: "Distributed KV store implementation")
            }
        }
    }

    // MARK: - Links
    var linksView: some View {
        makeSection("🌐 Links") {
            LinkListView()
        }
    }

    // MARK: - Contact
    var contactView: some View {
        makeSection("📬 Contact Me") {
            Text(Constant.email)
                .font(.body)
                .foregroundColor(.blue)
                .contextMenu {
                    Button(action: { UIPasteboard.general.string = Constant.email }) {
                        Text("Copy Email")
                        Image(systemName: "doc.on.doc")
                    }
                }
        }
    }
}

// MARK: - Private
private extension AuthorView {
    func makeSection(_ title: String, content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            makeSectionTitle(title)

            content()
        }
    }

    func makeSectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.title2)
            .bold()
    }
}

// MARK: - Constant
private extension AuthorView {
    enum Constant {
        static let email = "giga.khizanishvili@gmail.com"
        static let location = "Tbilisi, Georgia"
    }
}
