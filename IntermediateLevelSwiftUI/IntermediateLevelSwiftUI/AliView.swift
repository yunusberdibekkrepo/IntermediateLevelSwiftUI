//
//  AliView.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 29.05.2024.
//

import SwiftUI

struct AliView: View {
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    VStack {
                        ForEach(0 ..< 3, id: \.self) { _ in
                            messiView(geo: geometry)
                        }
                    }
                }
            }
        }
        .padding(.top, 24)
        .padding(.horizontal, 24)
    }

    func messiView(geo: GeometryProxy) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            let columns = 8
            let itemWidth: CGFloat = 32
            let spacing: CGFloat = 8

            let totalItemWidth = itemWidth * CGFloat(columns) + spacing * CGFloat(columns - 1)
            let remainingSpace = geo.size.width - totalItemWidth
            let sidePadding = max(0, remainingSpace / 2)

            Text(geo.size.width.description)
            Text(remainingSpace.description)

            LazyVGrid(columns: Array(repeating: .init(.fixed(32)), count: columns), alignment: .center, spacing: 4) {
                ForEach(0 ..< 10, id: \.self) { _ in
                    HStack(spacing: .zero) {
//                        Spacer(minLength: 33)
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 32, height: 40)
//                        Spacer(minLength: sidePadding)
                    }
                }
            }
//            .frame(width: geo.size.width, alignment: .center)
            .background(.blue)
        }
        .background(.red)
    }
}

#Preview {
    AliView()
}
