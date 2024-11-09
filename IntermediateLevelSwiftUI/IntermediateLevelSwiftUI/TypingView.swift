//
//  TypingView.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 23.05.2024.
//

import Combine
import SwiftUI

struct TypingView: View {
    @StateObject var viewModel: TypingViewModel = .init()

    var body: some View {
        VStack(spacing: 50) {
            TextField("Messi", text: $viewModel.userInput)
                .padding()
                .background(.gray.opacity(0.15))
                .cornerRadius(5)
                .padding(.horizontal)

            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(0 ..< viewModel.predictedWords.count, id: \.self) { wIndex in
                            let predictedWord = viewModel.predictedWords[wIndex]

                            predictedWordView(
                                predictedWord: predictedWord, wIndex: wIndex,
                                proxy: geometry
                            )
                        }
                    }
                    .frame(width: geometry.size.width,
                           height: geometry.size.height, alignment: .top)
                }
            }
        }
        .padding(.horizontal, 24)
    }

    func predictedWordView(predictedWord: PredictedWord, wIndex: Int, proxy: GeometryProxy) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0 ..< predictedWord.word.count, id: \.self) { cIndex in
                    customTextField(predictedWord: predictedWord, wIndex: wIndex, cIndex: cIndex)
                }
            }
            .frame(minWidth: proxy.size.width,
                   alignment: .center)
        }
    }

    func customTextField(predictedWord: PredictedWord, wIndex: Int, cIndex: Int) -> some View {
        TextField(
            "",
            text: Binding(
                get: { String(predictedWord.characters[cIndex].char) },
                set: {
//                    viewModel.userInput = $0
                    viewModel.multiplePredict(str: $0, wIndex: wIndex, cIndex: cIndex)
                }
            ),
            onEditingChanged: { isEditing in
                if isEditing {
                    viewModel.updateCharacterLimit(wIndex: wIndex, cIndex: cIndex)
                }
            }
        )
        .padding()
        .background(.gray.opacity(0.15))
        .cornerRadius(5)
        .padding(.horizontal)
        .frame(width: 80, height: 80, alignment: .center)
    }
}

#Preview {
    TypingView()
}

final class TypingViewModel: ObservableObject {
    @Published var names: [String] = []
    @Published var characterLimit: Int = .zero
    @Published var currentWordIndex: Int = .zero
    @Published var predictedWords: [PredictedWord] = []

    @Published var characters: [String] = []

    private var cancellables = Set<AnyCancellable>()

    @Published var userInput: String = ""

    init() {
        names = ["Ali", "Veli", "Cumali", "Hakan"]
        predictedWords = names.map { name in
            (name, name.map { _ in (String(""), .unvisited) })
        }

        addSubscribers()
    }

    func predict(wIndex: Int, cIndex: Int) {
        guard
            let pChar = userInput.lowercased().first,
            let tChar = predictedWords[wIndex].word.lowercased()[cIndex]
        else {
            updatePredictedWord("", wIndex, cIndex, .unvisited)
            return
        }

        if pChar == tChar {
            updatePredictedWord(String(pChar), wIndex, cIndex, .correct)
        } else {
            updatePredictedWord(String(pChar), wIndex, cIndex, .incorrect)
        }
    }

    // TODO: 1.indeks'i almıyor.
    func multiplePredict(str: String, wIndex: Int, cIndex: Int) {

        var newCIndex = cIndex
        var temp: Int = .zero

        characters = predictedWords[wIndex].word.map { _ in String("") }

        if !userInput.isEmpty {
            while temp != str.count {
                if
                    let pChar = str.lowercased()[temp],
                    let tChar = predictedWords[wIndex].word.lowercased()[newCIndex]
                {

                    if pChar == tChar {
                        updatePredictedWord(String(pChar),
                                            wIndex, newCIndex,
                                            .correct)
                        characters[newCIndex] = pChar.uppercased()
                    } else {
                        updatePredictedWord(String(pChar),
                                            wIndex, newCIndex,
                                            .incorrect)
                        characters[newCIndex] = ""
                    }
                }

                temp += 1
                newCIndex += 1
            }
        } else {
            updatePredictedWord("", wIndex, cIndex, .unvisited)
        }
    }

    /// Sets the character limit for the textfield according to the current word.
    func updateCharacterLimit(wIndex: Int, cIndex: Int) {
        let predictedWordCount = predictedWords[wIndex].word.count

        characterLimit = predictedWordCount - cIndex
    }
}

// MARK: - Privates

private extension TypingViewModel {
    func addSubscribers() {
        $userInput
            .debounce(for: .milliseconds(100), scheduler: DispatchQueue.main)
            .sink { newValue in
                if newValue.count > self.characterLimit {
                    self.userInput = String(newValue.prefix(self.characterLimit))
                }
            }
            .store(in: &cancellables)
    }

    func updatePredictedWord(_ char: String, _ wIndex: Int, _ cIndex: Int, _ type: PredictionType) {
        predictedWords[wIndex].characters[cIndex].char = String(char)
        predictedWords[wIndex].characters[cIndex].type = type
    }
}

extension String {
    subscript(index: Int) -> Character? {
        guard index >= 0, index < self.count else {
            return nil
        }
        let stringIndex = self.index(self.startIndex, offsetBy: index)
        return self[stringIndex]
    }
}

enum PredictionType {
    case unvisited
    case correct
    case incorrect
}

typealias PredictedWord = (word: String, characters: [(char: String, type: PredictionType)])
