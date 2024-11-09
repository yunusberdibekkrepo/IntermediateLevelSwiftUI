//
//  SortFilterMapUseCase.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 23.04.2024.
//

import Combine
import SwiftUI

struct SortFilterMapUseCase: View {
    @State var selectedCity: String? = nil
    @StateObject var viewModel: ViewModel = .init()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.filteredCities, id: \.self) { city in
                    Text(city)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.black.opacity(0.001))
                        .onTapGesture {
                            selectedCity = city
                        }
                }
            }
            .padding(.top)
            .navigationDestination(item: $selectedCity) { city in
                VStack(alignment: .center) {
                    Text(city)
                }
            }
            .searchable(text: $viewModel.searchText)
        }
    }
}

#Preview {
    SortFilterMapUseCase()
}

class ViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var filteredCities: [String] = []
    @Published var cities = [
        "Adana",
        "Adıyaman",
        "Afyonkarahisar",
        "Ağrı",
        "Amasya",
        "Ankara",
        "Antalya",
        "Artvin",
        "Aydın",
        "Balıkesir",
        "Bilecik",
        "Bingöl",
        "Bitlis",
        "Bolu",
        "Burdur",
        "Bursa",
        "Çanakkale",
        "Çankırı",
        "Çorum",
        "Denizli",
        "Diyarbakır",
        "Edirne",
        "Elazığ",
        "Erzincan",
        "Erzurum",
        "Eskişehir",
        "Gaziantep",
        "Giresun",
        "Gümüşhane",
        "Hakkari",
        "Hatay",
        "Isparta",
        "Mersin",
        "İstanbul",
        "İzmir",
        "Kars",
        "Kastamonu",
        "Kayseri",
        "Kırklareli",
        "Kırşehir",
        "Kocaeli",
        "Konya",
        "Kütahya",
        "Malatya",
        "Manisa",
        "Kahramanmaraş",
        "Mardin",
        "Muğla",
        "Muş",
        "Nevşehir",
        "Niğde",
        "Ordu",
        "Rize",
        "Sakarya",
        "Samsun",
        "Siirt",
        "Sinop",
        "Sivas",
        "Tekirdağ",
        "Tokat",
        "Trabzon",
        "Tunceli",
        "Şanlıurfa",
        "Uşak",
        "Van",
        "Yozgat",
        "Zonguldak",
        "Aksaray",
        "Bayburt",
        "Karaman",
        "Kırıkkale",
        "Batman",
        "Şırnak",
        "Bartın",
        "Ardahan",
        "Iğdır",
        "Yalova",
        "Karabük",
        "Kilis",
        "Osmaniye",
        "Düzce"
    ]

    private var cancellables = Set<AnyCancellable>()

    init() {
        addSubscribers()
    }

    private func addSubscribers() {
        $searchText
            .combineLatest($cities)
            .map(filterAndSort)
            .sink { [weak self] returnedCities in
                self?.filteredCities = returnedCities
            }
            .store(in: &cancellables)
    }

    private func filterAndSort(text: String, cities: [String]) -> [String] {
        var filteredCities = filter(text: text, cities: cities)
        sortCities(cities: &filteredCities)

        return filteredCities
    }

    private func filter(text: String, cities: [String]) -> [String] {
        guard !text.isEmpty else { return cities }

        let lowercasedText = searchText.lowercased()

        return cities.filter { city -> Bool in
            city.lowercased().contains(lowercasedText)
        }
    }

    private func sortCities(cities: inout [String]) {
        cities.sort()
    }
}
