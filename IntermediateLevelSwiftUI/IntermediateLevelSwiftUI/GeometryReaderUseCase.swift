//
//  GeometryReaderUseCase.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 20.04.2024.
//

import SwiftUI

// https://medium.com/turkishkit/swiftui-geometryreader-f02a93c4df78

// Kullanılan ekranın boyutunu ve lokasyonunu bize verir. Imkan oldukça kullanmamaya özen gösterelim. Landscape ve portrait mode'a göre aynı büyüklükte ekranlar tasarlamak için iyidir.
// Geometry global koordinatlar içinde view'in nerede olduğunu'da söyler
struct GeometryReaderUseCase: View {
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2 // center of the screen
        let currentX = geo.frame(in: .global).midX // mevcut olunan ekran içinde

        return Double(1 - (currentX / maxDistance))
    }

    var body: some View {
//        GeometryReader { geometry in
//            HStack(spacing: .zero) {
//                Rectangle().fill(.red)
//                    .frame(width: geometry.size.width * 0.666)
//
//                Rectangle().fill(.blue)
//            }
//            .ignoresSafeArea()
//        }

        ScrollView(.horizontal) {
            HStack {
                ForEach(0 ..< 50, id: \.self) { _ in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                .init(degrees: getPercentage(geo: geometry) * 40),
                                axis: (x: 0.0, y: 1.0, z: 0.0))
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    GeometryReaderUseCase()
}

/*
 🚀 Giriş
 GeometryReader içerisine istediğiniz SwiftUI görünümlerini yerleştirebilirsiniz. Bu örnekte daha önce büyük ihtimalle kullandığınız Rectangle() görünümü ile bir dikdörtgen oluşturup onu bir GeometryReader içine atıyoruz. GeometryReader , GeometryProxy tipinde bir parametreye sahip — aşağıdaki, örnekte buna geoReader ismini verdim. Bu parametre okunan değerlere erişmemizi sağlıyor. Aşağıda kısa kenarı okunan enin yarısı ve uzun kenarı okunan boyun yarısı olan bir dikdörtgen oluşturuyoruz.

 GeometryReader { geoReader in
     Rectangle()
         .foregroundStyle(.mint)
         .frame(width: geoReader.size.width * 0.5, height: geoReader.size.height * 0.5)
 }

 💡İpucu: Xcode 13 ve sonrası ile artık önizlemede (preview) kullandığınız cihazın ekran yönünü istediğiniz gibi ayarlayabiliyorsunuz!

 Normal şartlar altında SwiftUI görünümleri ekranın ortasına hizalarken, gördüğünüz gibi GeometryReader kullanırken ekranın sol-üst köşesine hizalanıyor.

 GeometryReader , diğer çoğu SwiftUI görünümden farklı olarak kaplayabileceği kadar çok alan kaplamak istiyor. Ancak bu her zaman istediğiniz bir şey olamayabilir — mesela her daim tam ekran çalışmayan uygulamalarda. Bunun gibi durumlarda bir frame niteleyicisiyle kapladığı alanı sınırlandırmalısınız.

 Ancak GeometryReader , bir overlay ya da background görünümünün içinde kullanıldığında kapsayıcı görünümününden daha fazla yer kaplayamadığından aynı sorun ile karşılaşmıyoruz.

 Ayrıca GeometryReader sık olarak kullandığımız HStack ve benzeri görünümlerin otomatik olarak sağladığı boşluğu ya da içindeki herhangi bir görünümün offset değerine algılamıyor. Bu da mesela iki tane ekranın yarısı kadar ene sahip görünümü yan yana koymaya çalıştığınızda dışarı taşmaya neden olabilir. Üstesinden gelmek için aşağıdaki gibi kullandığınız HStack vb. görününün spacing parametresine nil değerini atamalısınız.

 GeometryReader { geoReader in
     HStack(spacing: nil) {...}
 }
 🔎 Diğer Ayrıntılar
 Güvenli Bölge Payı
 GeometryProxy ‘nin safeAreaInsets parametresiyle görünümüzün; saat, operatör bilgisi, ve ana ekran çizgisi gibi sistem arayüz elemanlarıyla çakışmaması için her bir kenardan bırakılması gereken boşluk miktarına erişebilirsiniz. Aşağıda kullanımını görmektesiniz.

 geoReader.safeAreaInsets.top      // Üst
 geoReader.safeAreaInsets.bottom   // Alt
 geoReader.safeAreaInsets.leading  // Sol
 geoReader.safeAreaInsets.trailing // Sağ
 Koordinat Alanları
 GeometryReader bize ayrıca koordinatlar da sağlayabiliyor. Mesela GeometryReader ‘ın cihaz ekranına göre güvenli alan (safe area) görmezden gelinerek hesaplanan x eksenindeki orta noktasına, global koordinat alanını kullanan aşağıdaki kod ile erişebilirsiniz.

 geoReader.frame(in: .global).midX
 Aynı konumu cihaz ekranının ortasına göre değil de GeometryReader ‘ın içinde bulunduğu, yani kapsayıcı görünümün ortasına göre — mesela bir VStack ya da başka bir GeometryReader — hesaplamak isteseydik de global yerine local koordinat alanını kullanmamız gerekirdi.

 geoReader.frame(in: .local).midX

 */
