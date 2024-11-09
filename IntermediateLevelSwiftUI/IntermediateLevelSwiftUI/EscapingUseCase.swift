//
//  EscapingUseCase.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 4.05.2024.
//

import SwiftUI

class EscapingUseCaseViewModel: ObservableObject {
    @Published var text: String = "Hello"

    func getData() {
        downloadData { [weak self] returnedString in
            self?.text = returnedString
        }
    }

    func getData2() {
        downloadData2 { [weak self] returnedString in
            self?.text = returnedString
        }
    }

    func downloadData(action: (String) -> Void) {
        action("Bonjour")
    }

    // async işlem olacağı zaman @escaping olacak.
    func downloadData2(action: @escaping DefaultCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            action("Hallo")
        }
    }
}

typealias DefaultCompletion = (String) -> Void

struct EscapingUseCase: View {
    @StateObject var viewModel: EscapingUseCaseViewModel = .init()

    var body: some View {
        VStack {
            Text(viewModel.text)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.blue)
                .onTapGesture {
                    viewModel.getData()
                }
        }
        .onAppear(perform: viewModel.getData2)
    }
}

struct AsyncButton<Content>: View where Content: View {
    var content: Content
    var action: () -> Void

    init(action: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.action = action
        self.content = content()
    }

    var body: some View {
        Button(action: action, label: {
            content
        })
    }
}

struct Label<Label>: View where Label: View {
    var label: Label

    var body: some View {
        label
    }
}

#Preview {
    EscapingUseCase()
}
