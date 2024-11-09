//
//  FileManagerBootcamp.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 18.05.2024.
//

import SwiftUI

struct FileManagerBootcamp: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(.neymar)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipped()
                    .cornerRadius(10)
            }
            .navigationTitle("File Manager")
        }
    }
}

#Preview {
    FileManagerBootcamp()
}
