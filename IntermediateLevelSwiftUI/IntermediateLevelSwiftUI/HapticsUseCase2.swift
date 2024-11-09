//
//  HapticsUseCase2.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 23.04.2024.
//

import SwiftUI

struct HapticsUseCase2: View {
    @State private var counter = 0

    var body: some View {
        Button("Tap count :\(counter.description)") {
            counter += 1
        }
        .sensoryFeedback(.increase, trigger: counter)
        .sensoryFeedback(.impact(flexibility: .soft, intensity: 1), trigger: counter)
    }
}

#Preview {
    HapticsUseCase2()
}
