//
//  HashableUseCase.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 23.04.2024.
//

import SwiftUI

struct CustomTitleModel: Hashable {
    let title: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct CustomTitleModel2: Identifiable {
    let id = UUID().uuidString
    let title: String
}

struct HashableUseCase: View {
    var titles: [CustomTitleModel] = [
        .init(title: "1"),
        .init(title: "2"),
        .init(title: "3")
    ]

    var titles2: [CustomTitleModel2] = [
        .init(title: "11"),
        .init(title: "22"),
        .init(title: "33")
    ]

    var body: some View {
        VStack {
            ForEach(titles, id: \.self) { item in
                Text(item.title)
            }

            Divider()

            ForEach(titles2, id: \.id) { item in
                Text(item.title)
            }
        }
    }
}

#Preview {
    HashableUseCase()
}
