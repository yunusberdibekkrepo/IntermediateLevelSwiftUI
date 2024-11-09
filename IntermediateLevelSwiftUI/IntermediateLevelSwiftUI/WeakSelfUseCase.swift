//
//  WeakSelfUseCase.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 4.05.2024.
//

import SwiftUI

struct WeakSelfUseCase: View {
    @AppStorage("count") var count: Int?

    init() {
        self.count = .zero
    }

    var body: some View {
        NavigationView {
            NavigationLink("Navigate") {
                WeakSelfSecondView()
            }
            .navigationTitle("Screen 1")
        }
        .overlay(alignment: .topTrailing) {
            Text((count ?? .zero).description)
                .font(.largeTitle)
                .padding()
                .background(Color.green.cornerRadius(10))
        }
    }
}

struct WeakSelfSecondView: View {
    @StateObject var viewModel: WeakSelfSecondViewModel = .init()

    var body: some View {
        VStack {
            Text("Screen 2")
                .font(.largeTitle)
                .foregroundStyle(.red)

            if let data = viewModel.data {
                Text(data)
                    .font(.largeTitle)
                    .padding()
            }
        }
    }
}

#Preview {
    WeakSelfUseCase()
}

// Screen 1'den navigate'e basıldığında Screen2 ilk olarak initialize olur. Daha sonra back tuşuna basıp bir daha navigate olursa ise ilk önce ilk initialize edilen yapı deinit olur daha sonradan yeni yapı init olur.

class WeakSelfSecondViewModel: ObservableObject {
    @Published var data: String? = nil

    init() {
        print("Initiliaze now!")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }

    deinit {
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
        print("Deinitiliaze now!")
    }

    func getData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
//            self.data = "New Data!" // Burada strong reference oluşturulmaktadır.Task süresi uzun olduğu için bu sayfa kapatıldığında yeniden navigate'e baısldığında deinit olmadan yeni bir sayfa açılacaktır.
            self?.data = "New Data!" //  Ancak weak reference olursa'da yine de deinit olur. Yani strong reference olmaz.Long tasklar olduğunda kullanmak mantıklıdır.
        }
    }
}
