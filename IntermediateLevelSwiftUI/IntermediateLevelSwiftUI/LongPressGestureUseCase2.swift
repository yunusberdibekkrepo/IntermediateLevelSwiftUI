//
//  LongPressGestureUseCase2.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 17.04.2024.
//

import SwiftUI

struct LongPressGestureUseCase2: View {
    @State var isPressing: Bool = false
    @State var isAnimating: Bool = false

    var body: some View {
        VStack(content: {
            Circle()
                .trim(from: isAnimating ? 0 : 1, to: 1)
                .stroke(isPressing ? .green : .black, lineWidth: 50)

            Text("Tıkla")
                .onLongPressGesture(minimumDuration: 1, maximumDistance: 50) {
                    // Perform
                    // 1sn basıldıktan sonraJest  çalışacak kısım.
                    withAnimation(.easeIn) {
                        isPressing = true
                    }
                } onPressingChanged: { isPressing in
                    // Kullanıcı basma işlemini gerçekleştirdiği sürece çalışır. Daha sonra perform içine girer.
                    if isPressing {
                        withAnimation(.easeInOut(duration: 1)) {
                            isAnimating.toggle()
                        }
                    } else {
                        withAnimation(.easeInOut(duration: 1)) {
                            isAnimating = false
                        }
                    }
                }

        })
    }
}

#Preview {
    LongPressGestureUseCase2()
}
