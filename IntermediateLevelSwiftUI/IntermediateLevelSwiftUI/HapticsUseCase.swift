//
//  HapticsUseCase.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 23.04.2024.
//

import SwiftUI

class HapticManager {
    static let shared = HapticManager()

    func notification(notificationType: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(notificationType)
    }

    // <# bir diaz daha>

    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct HapticsUseCase: View {
    @State var count: Int = 0

    var body: some View {
        VStack(spacing: 20) {
            Text(count.description)

            Button("Success") {
                HapticManager.shared.notification(notificationType: .success)
            }

            Button("Warning") {
                HapticManager.shared.notification(notificationType: .warning)
            }

            Button("Errror") {
                HapticManager.shared.notification(notificationType: .error)
            }

            Button("Impact heavy") {
                HapticManager.shared.impact(style: .heavy)
            }

            Button("Impact light") {
                HapticManager.shared.impact(style: .light)
            }

            Button("Impact medium") {
                HapticManager.shared.impact(style: .medium)
            }

            Button("Impact rigid") {
                HapticManager.shared.impact(style: .rigid)
            }

            Button("Impact rigid") {
                HapticManager.shared.impact(style: .soft)
            }
        }
    }
}

#Preview {
    HapticsUseCase()
}
