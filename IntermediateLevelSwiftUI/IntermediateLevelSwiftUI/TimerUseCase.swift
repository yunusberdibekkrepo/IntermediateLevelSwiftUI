//
//  TimerUseCase.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 7.05.2024.
//

import SwiftUI

/// Current Time
struct TimerUseCase: View {
    /// Timer bir publisher'dir.
    /// Auto connect ekran başlayınca otomatik başla anlamına gelmektedir.
    let timer = Timer.publish(
        every: 0.5,
        on: .main,
        in: .common).autoconnect()

    /// Current Time
    /*
         @State var currentDate: Date = .now

         var dateFormatter: DateFormatter {
             let dateFormatter = DateFormatter()

     //        dateFormatter.dateStyle = .full
             dateFormatter.timeStyle = .medium
             return dateFormatter
         }
         */

    /// CountDown
    /*
     @State var count: Int = 10
     @State var finishedText: String? = nil
     */

    /// CountDown to Date
    /*
     @State var timeRemaining: String = ""
     let futureDate: Date = Calendar.current.date(
         byAdding: .hour,
         value: 1,
         to: .now) ?? .now // 24 saat sonra

     func updateTimeRemaining() {
         let remaining = Calendar.current.dateComponents(
             [.minute, .second],
             from: .now,
             to: futureDate)
         let minute = remaining.minute ?? .zero
         let second = remaining.second ?? .zero

         timeRemaining = "\(minute) minutes,\(second) seconds"
     }
     */

    /// Animation Counter
    @State var count: Int = .zero

    var body: some View {
        ZStack {
            RadialGradient(
                colors: [
                    .purple,
                    .blue
                ],
                center: .center,
                startRadius: 5,
                endRadius: 500)
                .ignoresSafeArea()

            TabView(selection: $count) {
                Rectangle()
                    .foregroundStyle(.red)
                    .tag(1)

                Rectangle()
                    .foregroundStyle(.blue)
                    .tag(2)

                Rectangle()
                    .foregroundStyle(.green)
                    .tag(3)
            }
            .frame(height: 200)
            .tabViewStyle(.page)

//            HStack(spacing: 15) {
//                Circle()
//                    .offset(y: count == 1 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 2 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 3 ? -20 : 0)
//            }
//            .frame(width: 150)
//            .foregroundStyle(.white)
        }
        .onReceive(timer, perform: { _ in
//            updateTimeRemaining()
            withAnimation(.easeInOut(duration: 0.5)) {
                count = count == 3 ? 0 : count + 1
            }
        })
    }
}

#Preview {
    TimerUseCase()
}

/*
 SwiftUI'deki .onReceive fonksiyonu, bir view'in belirli bir yayın (publisher) tarafından yayınlanan değerleri dinlemesini sağlar. Bu yayınlar genellikle Combine çerçevesi kullanılarak oluşturulur. .onReceive, yayın tarafından gönderilen değerleri aldığında belirtilen bir işlemi gerçekleştirir. Bu, örneğin, bir kullanıcının bir formu doldurduğunda veya bir veri modeli değiştiğinde bir işlem gerçekleştirmek için kullanılabilir.
 */
