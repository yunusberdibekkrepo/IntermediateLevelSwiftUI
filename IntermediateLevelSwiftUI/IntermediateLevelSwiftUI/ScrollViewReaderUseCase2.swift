//
//  ScrollViewReaderUseCase2.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 19.04.2024.
//

import SwiftUI

struct ScrollViewReaderUseCase2: View {
    let turkishCharacters = ["a", "b", "c", "ç", "d", "e", "f", "g", "ğ", "h", "ı", "i", "j", "k", "l", "m", "n", "o", "ö", "p", "r", "s", "ş", "t", "u", "ü", "v", "y", "z"]

    var body: some View {
        VStack(content: {
            HStack(content: {
                Text("Messi")

                Spacer()

                ScrollView {
                    ForEach(turkishCharacters, id: \.self) {
                        Text($0.uppercased())
                            .font(.callout)
                    }
                }
                .padding()
            })

        })
        .padding(.top)
    }
}

#Preview {
    ScrollViewReaderUseCase2()
}
