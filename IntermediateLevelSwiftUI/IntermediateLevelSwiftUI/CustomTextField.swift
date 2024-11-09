//
//  CustomTextField.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 24.05.2024.
//

import SwiftUI

struct CustomTextField: View {
    var body: some View {
        ScrollView {
            let columns: [GridItem] = Array(repeating: .init(.fixed(40)), count: 5)

            LazyVGrid(columns: columns, alignment: .center, spacing: 12, pinnedViews: [], content: {
                ForEach(0 ..< 20, id: \.self) { _ in
                    TextField("", text: .constant(""))
                        .frame(height: 40)
                        .background(.gray.opacity(0.5))
                        .cornerRadius(12)
                }
            })
        }
        .background(.red)
        .clipped()
    }
}

#Preview {
    CustomTextField()
}
