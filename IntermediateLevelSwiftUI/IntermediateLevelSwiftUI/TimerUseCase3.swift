//
//  TimerUseCase3.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 8.05.2024.
//

import SwiftUI

struct TimerUseCase3: View {
    let timer = Timer.publish(
        every: 1.0,
        on: .main,
        in: .common).autoconnect()

    // CountDown
    @State var finishedText: String? = nil
    @State var count: Int = 0

    // CountDown to date
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(
        byAdding: .hour,
        value: 1,
        to: .now) ?? .now

    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents(
            [.minute, .second],
            from: .now,
            to: futureDate)

        timeRemaining = "\(remaining.minute ?? .zero) minutes, \(remaining.second ?? .zero) seconds"
    }

    var body: some View {
        VStack(spacing: 15) {
            Text("Time remaining: \(timeRemaining)")
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .foregroundStyle(.red)

            Text("Count:\(finishedText ?? count.description)")
                .foregroundStyle(.blue)
        }
        .font(.system(size: 50, weight: .semibold, design: .rounded))
        .onReceive(timer, perform: { _ in
            if count < 9 {
                count = count + 1
            } else {
                count = 0
            }

            updateTimeRemaining()
        })
    }
}

#Preview {
    TimerUseCase3()
}
