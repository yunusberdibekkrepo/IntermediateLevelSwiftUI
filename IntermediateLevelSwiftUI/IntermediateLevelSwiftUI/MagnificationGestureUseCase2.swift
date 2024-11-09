//
//  MagnificationGestureUseCase2.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 18.04.2024.
//

import SwiftUI

struct MagnificationGestureUseCase2: View {
    @State var currentScaleAmount: CGFloat = .zero
    @State var lastScaleAmount: CGFloat = .zero

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Circle()
                    .fill()
                    .frame(width: 32, height: 32)

                Text("@yunusberdibekk")

                Spacer()

                Image(systemName: "ellipsis")
            }
            .font(.callout)
            .padding(.horizontal)

            Rectangle()
                .frame(maxWidth: .infinity)
                .scaleEffect(1 + currentScaleAmount)
                .frame(height: 300)
                .gesture(
                    MagnifyGesture()
                        .onChanged { value in
                            currentScaleAmount = value.magnification - 1
                        }
                        .onEnded { _ in
                            withAnimation(.spring) {
                                currentScaleAmount = .zero
                            }
                        }
                )

            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")

                Spacer()
            }
            .font(.headline)
            .padding(.horizontal)

            Text("This is the caption for my photo")
                .font(.callout)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
    }
}

#Preview {
    MagnificationGestureUseCase2()
}
