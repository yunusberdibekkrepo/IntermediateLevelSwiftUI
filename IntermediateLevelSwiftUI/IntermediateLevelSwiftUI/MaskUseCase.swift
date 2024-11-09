//
//  MaskUseCase.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 20.04.2024.
//

import SwiftUI

struct MaskUseCase: View {
    @State var rating: Int = 0

    var body: some View {
        ZStack {
            starsView
                .overlay {
                    overlayView
                        .mask(starsView)
                }
        }
    }

    var overlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
//                    .fill(.yellow)
                    .foregroundStyle(
                        LinearGradient(colors: [.red, .blue], startPoint: .leading, endPoint: .trailing)
                    )
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false) // starsView'de olan onTapGesture'ı overlay üzerinden tıklanılabilir hale getirdik.
    }

    var starsView: some View {
        HStack {
            ForEach(1 ..< 6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
//                    .foregroundStyle(rating >= index ? .yellow : .gray)
                    .foregroundStyle(.gray)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            rating = index
                        }
                    }
            }
        }
    }
}

#Preview {
    MaskUseCase()
}
