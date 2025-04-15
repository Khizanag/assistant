//
//  LinkListView.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 09.04.25.
//

import SwiftUI

struct LinkListView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(LinkDataSource.all, id: \.title) { linkModel in
                Link(destination: linkModel.url) {
                    HStack(spacing: 12) {
                        Image(systemName: linkModel.iconSystemName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.accentColor)

                        Text(linkModel.title)
                            .font(.body)
                            .foregroundColor(.primary)

                        Spacer()

                        Image(systemName: "arrow.up.right")
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                .contextMenu {
                    Button(action: { UIPasteboard.general.string = "\(linkModel.url)" }) {
                        Text("Copy Link")
                        Image(systemName: "doc.on.doc")
                    }
                }
            }
        }
    }
}
