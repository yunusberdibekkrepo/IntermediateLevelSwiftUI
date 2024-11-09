//
//  SoundsUseCase.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 22.04.2024.
//

import AVKit // Audio Video Kit
import SwiftUI

class SoundManager {
    enum SoundOptions: String {
        case tada = "Tada-sound"
        case badum = "Badum-tss"
    }

    static let shared: SoundManager = .init()

    var player: AVAudioPlayer?

    private init() {}

    func playSound(option: SoundOptions) {
        guard let url = Bundle.main.url(forResource: option.rawValue, withExtension: ".mp3") else { return }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            dump(error)
        }
    }
}

struct SoundsUseCase: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Play sound1") {
                SoundManager.shared.playSound(option: .tada)
            }

            Button("Play sound2") {
                SoundManager.shared.playSound(option: .badum)
            }
        }
    }
}

#Preview {
    SoundsUseCase()
}
