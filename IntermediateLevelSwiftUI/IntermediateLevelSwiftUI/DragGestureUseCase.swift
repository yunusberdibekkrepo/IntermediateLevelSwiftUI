//
//  DragGestureUseCase.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 17.04.2024.
//

import SwiftUI

struct DragGestureUseCase: View {
    @State var offset: CGSize = .zero

    var body: some View {
        Rectangle()
            .clipShape(.rect(cornerRadius: 12))
            .frame(maxWidth: .infinity)
            .frame(height: 500)
            .padding()
            .offset(offset)
            .scaleEffect(getScaleAmount())
            .rotationEffect(.degrees(getRotationAmount()))
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation(.spring) {
                            offset = value.translation
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.spring) {
                            offset = .zero
                        }
                    }
            )
    }

    private func getScaleAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / max

        return 1 - min(percentage, 0.5) * 0.5
    }

    private func getRotationAmount() -> Double {
        let max = UIScreen.main.bounds.height / 2
        let currentAmount = offset.width
        let percentage = currentAmount / max
        let percentageAsDouble = Double(percentage)
        let maxAngle: Double = 10
        return percentageAsDouble * maxAngle
    }
}

#Preview {
    DragGestureUseCase()
}
