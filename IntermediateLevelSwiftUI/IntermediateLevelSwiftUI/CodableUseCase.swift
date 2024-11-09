//
//  CodableUseCase.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 5.05.2024.
//

import SwiftUI

struct CodableUseCase: View {
    @StateObject var viewModel: CodableUseCaseViewModel = .init()

    var body: some View {
        VStack(spacing: 20) {
            if let customer = viewModel.customer {
                Group {
                    Text(customer.id)
                    Text(customer.name)
                    Text(customer.points.description)
                    Text(customer.isPremium.description)
                }
                .font(.largeTitle)
            }
        }
    }
}

class CodableUseCaseViewModel: ObservableObject {
    @Published var customer: CustomerModel? = .init(
        id: "1",
        name: "Yunus",
        points: 1,
        isPremium: false)

    init() {
        self.getData()
    }

    func getData() {
        guard let data = getJSONData() else { return }

        self.customer = try? JSONDecoder().decode(CustomerModel.self,
                                                  from: data)

//        if let localData = try? JSONSerialization.jsonObject(with: data),
//           let dictionary = localData as? [String: Any]
//        {
//            if let id = dictionary["id"] as? String,
//               let name = dictionary["name"] as? String,
//               let points = dictionary["points"] as? Int,
//               let isPremium = dictionary["isPremium"] as? Bool
//            {
//                let newCustomer = CustomerModel(
//                    id: id,
//                    name: name,
//                    points: points,
//                    isPremium: isPremium)
//
//                customer = newCustomer
//            }
//        }
    }

    func getJSONData() -> Data? {
        let customer = CustomerModel(id: "111",
                                     name: "Leo Messi",
                                     points: 10,
                                     isPremium: false)
        let jsonData = try? JSONEncoder().encode(customer)
        return jsonData
//        let dictionary: [String: Any] = [
//            "id": "1",
//            "name": "Tarık",
//            "points": 1,
//            "isPremium": true
//        ]
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary)
//        return jsonData
    }
}

struct CustomerModel: Identifiable, Decodable, Encodable { // OR CODABLE
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case points
        case isPremium
    }

    init(id: String, name: String, points: Int, isPremium: Bool) {
        self.id = id
        self.name = name
        self.points = points
        self.isPremium = isPremium
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.points = try container.decode(Int.self, forKey: .points)
        self.isPremium = try container.decode(Bool.self, forKey: .id)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.points, forKey: .points)
        try container.encode(self.isPremium, forKey: .isPremium)
    }
}

#Preview {
    CodableUseCase()
}
