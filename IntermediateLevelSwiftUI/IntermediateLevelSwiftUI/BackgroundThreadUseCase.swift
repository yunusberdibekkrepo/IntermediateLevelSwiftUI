//
//  BackgroundThreadUseCase.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 1.05.2024.
//

import SwiftUI

struct BackgroundThreadUseCase: View {
    @StateObject var viewModel: BackgroundThreadViewModel = .init()
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                Text("load data".uppercased())
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        viewModel.fetchData()
                    }

                ForEach(viewModel.dataArray, id: \.self) { element in
                    Text(element)
                        .font(.headline)
                        .foregroundStyle(.red)
                }
            }
        }
        .clipped()
    }
}

#Preview {
    BackgroundThreadUseCase()
}

class BackgroundThreadViewModel: ObservableObject {
    @Published var dataArray: [String] = []

    func fetchData() {
        DispatchQueue.global().async {
            let newData = self.downloadData()

            DispatchQueue.main.async {
                self.dataArray = newData
            }
        }
    }

    private func downloadData() -> [String] {
        var data: [String] = []

        for x in 0 ..< 100 {
            data.append(x.description)
        }

        return data
    }
}
