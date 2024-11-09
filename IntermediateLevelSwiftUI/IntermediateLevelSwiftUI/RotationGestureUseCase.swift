//
//  RotationGestureUseCase.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 17.04.2024.
//

import SwiftUI

struct RotationGestureUseCase: View {
    @State var rotationDegree: Double = .zero

    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.red)
            .cornerRadius(12)
            .padding()
            .rotationEffect(.degrees(rotationDegree))
            .gesture(
                RotateGesture()
                    .onChanged { value in
                        rotationDegree = value.rotation.degrees
                    }
                    .onEnded { _ in
                        withAnimation(.spring) {
                            rotationDegree = .zero
                        }
                    }
            )
    }
}

#Preview {
    RotationGestureUseCase()
}
