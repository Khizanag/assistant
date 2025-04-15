//
//  ContentView.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 09.04.25.
//

import SwiftUI

struct ContentView: View {
//    enum Tab {
//        case home
//        case hub
//        case author
//    }
//
//    @State private var tab: Tab = .author
//
//    var body: some View {
//        TabView(selection: $tab) {
//            HomeView()
//                .tabItem {
//                    Label("Home", systemImage: "house")
//                }
//                .tag(Tab.home)
//
//            HubView()
//                .tabItem {
//                    Label("Hub", systemImage: "square.grid.2x2")
//                }
//                .tag(Tab.hub)
//
//            AuthorView()
//                .tabItem {
//                    Label("Author", systemImage: "person.crop.circle.fill")
//                }
//                .tag(Tab.author)
//        }
//    }
    var body: some View {
        HubView()
            .navigationTitle("Hub")
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
