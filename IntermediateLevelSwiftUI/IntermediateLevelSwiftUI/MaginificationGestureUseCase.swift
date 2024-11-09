//
//  MaginificationGestureUseCase.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 17.04.2024.
//

import SwiftUI

struct MaginificationGestureUseCase: View {
    @State var currentAmount: CGFloat = .zero
    @State var lastAmount: CGFloat = .zero

    var body: some View {
        Text("Leo Messi")
            .font(.title)
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(.red)
            .cornerRadius(20)
            .scaleEffect(1 + currentAmount + lastAmount)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        currentAmount = value
                    }
                    .onEnded { value in
                        lastAmount += value
                        currentAmount = .zero
                    }
            )
    }
}

#Preview {
    MaginificationGestureUseCase()
}
