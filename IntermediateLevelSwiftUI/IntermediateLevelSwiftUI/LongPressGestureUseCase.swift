//
//  LongPressGestureUseCase.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 14.04.2024.
//

import SwiftUI

/*
  Minimum duration: En az x sn basılı tutmamız lazım. MaximumDistance: Tıkladıktan sonra parmağı x point götürmemizi sağlar. Mesela tıklanmanın zor olduğu yerlerde kullanınılır.
 */
struct LongPressGestureUseCase: View {
    @State var globeIsSuccess: Bool = false
    @State var externalDriveIsSuccess: Bool = false
    @State var heartIsSuccess: Bool = false
    @State var trashIsSuccess: Bool = false
    @State var trashIsComplete: Bool = false

    var body: some View {
        ScrollView {
            VStack(spacing: 50) {
                Image(systemName: "globe")
                    .onLongPressGesture {
                        withAnimation(.easeIn(duration: 0.5)) {
                            globeIsSuccess.toggle()
                        }
                    }

                Rectangle()
                    .fill(globeIsSuccess ? .green : .blue)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .clipShape(.rect(cornerRadius: 12))

                Image(systemName: "externaldrive.fill")
                    .onLongPressGesture(minimumDuration: 5) {
                        withAnimation(.snappy) {
                            externalDriveIsSuccess.toggle()
                        }
                    }

                Rectangle()
                    .fill(externalDriveIsSuccess ? .green : .brown)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .clipShape(.rect(cornerRadius: 12))

                Image(systemName: "heart.fill")
                    .onLongPressGesture(maximumDistance: 5) {
                        withAnimation(.linear) {
                            heartIsSuccess.toggle()
                        }
                    }

                Rectangle()
                    .fill(heartIsSuccess ? .green : .cyan)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .clipShape(.rect(cornerRadius: 12))

                Image(systemName: "trash.fill")
                    .onLongPressGesture(minimumDuration: 1, maximumDistance: 50) {
                        withAnimation(.easeIn(duration: 1.0)) {
                            trashIsSuccess = true
                        }
                    } onPressingChanged: { isPressing in
                        if isPressing {
                            print("Is pressing")

                            withAnimation(.easeInOut(duration: 1.0)) {
                                trashIsComplete.toggle()
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                if !trashIsSuccess {
                                    withAnimation(.easeInOut) {
                                        trashIsComplete = true
                                    }
                                }
                            }
                        }
                    }

                Rectangle()
                    .fill(trashIsSuccess ? .green : .red)
                    .frame(maxWidth: trashIsComplete ? .infinity : 0)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.yellow)
                    .clipShape(.rect(cornerRadius: 12))

                Image(systemName: "folder.fill")

                Rectangle()
                    .fill(.gray)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .clipShape(.rect(cornerRadius: 12))

                Image(systemName: "tray.fill")

                Rectangle()
                    .fill(.orange)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .clipShape(.rect(cornerRadius: 12))
            }
            .font(.largeTitle)
            .imageScale(.large)
            .foregroundStyle(.tint)
        }
        .scrollIndicators(.hidden)
        .padding(.all)
    }
}

#Preview {
    LongPressGestureUseCase()
}
