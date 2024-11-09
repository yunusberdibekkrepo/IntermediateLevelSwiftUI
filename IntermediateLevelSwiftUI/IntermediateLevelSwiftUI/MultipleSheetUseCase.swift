//
//  MultipleSheetUseCase.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 20.04.2024.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID()
    let title: String
}

struct MultipleSheetBootcamp: View {
    @State private var selectedModel: RandomModel? = nil
    @State private var showSheet1: Bool = false
    @State private var showSheet2: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Button("Sheet 1") {
                selectedModel = RandomModel(title: "SHEET 1")
                showSheet1.toggle()
            }

            Button("Sheet 2") {
                selectedModel = RandomModel(title: "SHEET 2")
                showSheet2.toggle()
            }
        }
        .sheet(item: $selectedModel) { item in
            CustomView(model: item)
        }
    }
}

struct CustomView: View {
    var model: RandomModel

    var body: some View {
        Text(model.title)
    }
}

#Preview {
    MultipleSheetBootcamp()
}
