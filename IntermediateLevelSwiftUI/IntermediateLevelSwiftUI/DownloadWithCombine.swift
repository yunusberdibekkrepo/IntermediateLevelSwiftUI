//
//  DownloadWithCombine.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 7.05.2024.
//

import Combine
import SwiftUI

struct DownloadWithCombine: View {
    @StateObject var viewModel = DownloadWithCombineViewModel()

    var body: some View {
        List {
            ForEach(viewModel.postModels) { post in
                VStack(alignment: .leading, spacing: 8) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .font(.body)
                        .foregroundStyle(.gray)
                }
            }
        }
        .clipped()
    }
}

#Preview {
    DownloadWithCombine()
}

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

final class DownloadWithCombineViewModel: ObservableObject {
    @Published var postModels = [PostModel]()
    var cancellables = Set<AnyCancellable>()

    init() {
        fetch()
    }

    func fetch() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

        /// Combine discussion:
        /// 1: SignUp for monthly subscription for package to delivered.
        /// 2: The company would take the package behind the scene.
        /// 3: Receive the package at your frount door.
        /// 4: Make sure the box isn't damaged.
        /// 5: Open and make sure the item is correct.
        /// 6: Use the item.
        /// 7: Cancellable any time.

        /// 1: Create subscriber
        /// 2: Subscribe publisher on background thread
        /// 3: Receive on main thread
        /// 4: TryMap(Check that data is good)
        /// 5: Decode(decode data into PostModels)
        /// 6: Sink(put the item into our app)
        /// 7: Store(cancel subscription if needed)

        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .sink { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    dump(error)
                }
            } receiveValue: { [weak self] returnedPostModels in
                self?.postModels = returnedPostModels
            }
            .store(in: &cancellables)
    }

    /// Eğer yazılacak kodda oluşacak hata önemsiz ise, .sink içinde result completion'u almak yerine hata olması durumunda dönecek elemanları  .replaceError ile belirtip direkt .sink içinde receive value kısmı yazılabilir.
    func fetch2() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] returnedPostModels in
                self?.postModels = returnedPostModels
            })
            .store(in: &cancellables)
    }

    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
