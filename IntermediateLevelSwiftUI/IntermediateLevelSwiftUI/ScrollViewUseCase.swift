//
//  ScrollViewUseCase.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 30.04.2024.
//

import SwiftUI

struct ScrollViewUseCase: View {
    @State var id: String?
    let images: [String] = ["messi", "ronaldo", "neymar", "ronaldinho"]

    var body: some View {
        VStack(alignment: .leading) {
            Text(id ?? "")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(images, id: \.self) { image in
                        Image(image)
                            .resizable()
                            .cornerRadius(15)
                            .frame(width: 300, height: 200)
                            .shadow(radius: 10, y: 10)
                            .scrollTransition(topLeading: .interactive,
                                              bottomTrailing: .interactive,
                                              axis: .horizontal)
                        { effect, phase in
                            effect
                                .scaleEffect(1 - abs(phase.value))
                                .opacity(1 - abs(phase.value))
                                .rotation3DEffect(.degrees(phase.value * 90),
                                                  axis: (x: 0, y: 1, z: 0))
                        }
                        .onTapGesture {
                            id = image
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .frame(height: 200)
            .safeAreaPadding(.horizontal, 32) // iOS 17 ile scrollView'a padding verme
            .scrollClipDisabled() // Clipped özelliği shadow için kapatılıyor.
            .scrollTargetBehavior(.viewAligned) // Scroll view davranışı. viewAligned olunca scrollTargetLayout eklenmeli.
            .scrollPosition(id: $id) // scroll pozisyonunu ayarlama
            .onAppear {
                id = images.last
            }

            Spacer()
        }
    }
}

#Preview {
    ScrollViewUseCase()
}

/*
 struct ScrollViewUseCase: View {
     let images: [String] = ["messi", "ronaldo", "neymar", "ronaldinho"]

     var body: some View {
         VStack(alignment: .leading) {
             ScrollView(.horizontal, showsIndicators: false) {
                 HStack {
                     ForEach(images, id: \.self) { image in
                         Image(image)
                             .resizable()
                             .cornerRadius(12)
                             .frame(width: 300, height: 200)
                             .shadow(radius: 10, y: 10)
                             .containerRelativeFrame(.horizontal) // İçinde bulunduğu view içinde tüm alanı alıp kendini ortalıyacak.
                     }
                 }
             }
             .frame(height: 200)
             .safeAreaPadding(.horizontal) // iOS 17 ile scrollView'a padding verme
             .scrollClipDisabled() // Clipped özelliği shadow için kapatılıyor.
             .scrollTargetBehavior(.paging) // Scroll view davranışı

             Spacer()
         }
     }
 }
 */

/*
 struct ScrollViewUseCase: View {
     let images: [String] = ["messi", "ronaldo", "neymar", "ronaldinho"]

     var body: some View {
         VStack(alignment: .leading) {
             ScrollView(.horizontal, showsIndicators: false) {
                 HStack {
                     ForEach(images, id: \.self) { image in
                         Image(image)
                             .resizable()
                             .cornerRadius(12)
                             .frame(width: 300, height: 200)
                             .shadow(radius: 10, y: 10)
                     }
                 }
                 .scrollTargetLayout()
             }
             .frame(height: 200)
             .safeAreaPadding(.horizontal) // iOS 17 ile scrollView'a padding verme
             .scrollClipDisabled() // Clipped özelliği shadow için kapatılıyor.
             .scrollTargetBehavior(.viewAligned) // Scroll view davranışı. viewAligned olunca scrollTargetLayout eklenmeli.

             Spacer()
         }
     }
 }
 */
