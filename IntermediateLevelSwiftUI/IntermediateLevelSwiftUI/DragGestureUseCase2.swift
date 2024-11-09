//
//  DragGestureUseCase2.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 18.04.2024.
//

import SwiftUI

struct DragGestureUseCase2: View {
    @State var firstOffset: CGFloat = UIScreen.main.bounds.height * 0.725
    @State var currentOffset: CGFloat = .zero
    @State var lastOffset: CGFloat = .zero

    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()

            MockSignUpView()
                .offset(y: firstOffset)
                .offset(y: currentOffset)
                .offset(y: lastOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring) {
                                self.currentOffset = value.translation.height
                            }

                            print(value.translation.height.description)
                        }
                        .onEnded { _ in
                            withAnimation(.spring) {
                                if currentOffset < -150 {
                                    lastOffset = -firstOffset
                                }
                                else if lastOffset != .zero,
                                        currentOffset > 150
                                {
                                    lastOffset = .zero
                                }

                                currentOffset = .zero
                            }
                        }
                )
        }
    }
}

struct MockSignUpView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "chevron.up")

            Text("Sign Up")
                .font(.callout)
                .bold()

            Image(systemName: "flame.fill")
                .font(.system(size: 75))

            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                .font(.callout)
                .multilineTextAlignment(.center)
                .padding()

            Button("create an account".uppercased()) {}
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
        }
        .padding(.vertical)
        .background {
            Color.white
                .clipShape(.rect(cornerRadius: 12))
        }
    }
}

#Preview {
    DragGestureUseCase2()
}
