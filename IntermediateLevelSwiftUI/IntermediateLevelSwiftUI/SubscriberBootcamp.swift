//
//  SubscriberBootcamp.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 8.05.2024.
//

import Combine
import SwiftUI

class SubscriberViewModel: ObservableObject {
    @Published var count: Int = .zero
    @Published var showButton: Bool = false
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false

    var cancellables = Set<AnyCancellable>()
    var timer: AnyCancellable?

    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }

    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { $0.count > 3 ? true : false }
            .sink(receiveValue: { [weak self] isValid in
                self?.textIsValid = isValid
            })
//            .assign(to: \.textIsValid, on: self)
            .store(in: &cancellables)
    }

    func setUpTimer() {
        timer = Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                self.count += 1

                if self.count >= 15 {
                    self.timer?.cancel()
                }
            }
    }

    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] isValid, count in
                guard let self else { return }

                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
}

struct SubscriberBootcamp: View {
    @StateObject var vm: SubscriberViewModel = .init()

    var body: some View {
        VStack {
            Text(vm.count.description)
                .font(.largeTitle)

            TextField("type something here...", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .overlay(alignment: .trailing) {
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundStyle(.red)
                            .opacity(vm.textIsValid ? 0.0 : 1.0)

                        Image(systemName: "checkmark")
                            .foregroundStyle(.green)
                            .opacity(vm.textIsValid ? 1.0 : 0.0)
                    }
                    .font(.title)
                    .padding(.trailing)
                }

            Button(action: {}, label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(10)
                    .opacity(vm.showButton ? 1.0 : 0.5)
            })
            .disabled(!vm.showButton)
            .padding(.top)
        }
        .padding()
    }
}

#Preview {
    SubscriberBootcamp()
}

/*
 //.assign(to: \.textIsValid, on: self)
 assign işlevi, Combine çerçevesinde yayıncıları ve yayıncılardan gelen değerleri bir nesnenin belirli bir anahtar yoluyla birleştirmek için kullanılır. Yukarıdaki kodda, $textFieldText bir yayıncıdır. Bu yayıncı, textFieldText özelliğindeki değişiklikleri izler.

 map operatörü, yayıncıdan gelen değerleri dönüştürür. Bu durumda, textFieldText özelliğindeki metni alır ve uzunluğunun 3'ten büyük olup olmadığını kontrol eder. Daha sonra, bu koşula göre bir Bool değer üretir.

 Sonrasında assign operatörü, bu dönüştürülmüş değeri belirtilen anahtar yoluyla birleştirir. assign operatörü, yayıncıdan gelen değeri, belirtilen nesnenin belirtilen anahtar yoluyla atar. Yani $textFieldText yayıncısından gelen değer, textIsValid özelliğine atanır.

 Böylece, her textFieldText özelliği değiştiğinde, uzunluğunun 3'ten büyük olup olmadığına bağlı olarak textIsValid özelliği de güncellenir. Bu, genellikle kullanıcı girişinin geçerliliğini kontrol etmek için yaygın bir yaklaşımdır.

 .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) ifadesi, metin alanındaki herhangi bir değişiklikten sonra minimum 0.5 saniye beklenmesini sağlar. Bu, kullanıcının metni yazarken arka arkaya hızlı değişiklikler yapması durumunda, son yazılan değeri almadan önce biraz beklenmesini sağlar. Örneğin, kullanıcı hızlı bir şekilde yazarken, her karakter girdisinden sonra doğrudan işlem yapmak yerine, kullanıcının bir an için durması ve gerçekten ne yazmak istediğini tamamlaması beklenir. Bu, performansı artırır ve gereksiz işlem maliyetini azaltır.

 .combineLatest fonksiyonu, bir veya daha fazla yayıncıdan gelen değerlerin en son değerlerini kullanarak yeni bir değer oluşturur. Bu fonksiyon, herhangi bir yayıncıdan yeni bir değer geldiğinde, diğer tüm yayıncılardan en son değerlerini alır ve bu değerlerle birlikte bir sonuç üretir.
 */
