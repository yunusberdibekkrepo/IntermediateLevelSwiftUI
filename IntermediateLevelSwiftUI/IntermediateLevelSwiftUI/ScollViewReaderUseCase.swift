//
//  ScollViewReaderUseCase.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 18.04.2024.
//

import SwiftUI

struct ScollViewReaderUseCase: View {
    @State var scrollIndex: Int = 0
    @State var indexString: String = "0"

    var body: some View {
        ScrollView {
            TextField("Index", text: $indexString)
                .textFieldStyle(.roundedBorder)
                .padding()

            Button("Go") {
                if let index = Int(indexString) {
                    withAnimation(.smooth) {
                        scrollIndex = index
                    }
                }
            }

            ScrollViewReader { proxy in
                ForEach(0 ..< 50) { index in
                    Rectangle()
                        .fill(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 250)
                        .shadow(color: .black, radius: 10)
                        .padding()
                        .id(index)
                }
//                .onChange(of: scrollIndex) { _, newValue in
//                    proxy.scrollTo(newValue, anchor: .center)
//                }
                .onChange(of: scrollIndex) {
                    withAnimation(.spring()) {
                        proxy.scrollTo(scrollIndex, anchor: .center)
                    }
                }
            }
        }
    }
}

#Preview {
    ScollViewReaderUseCase()
}
