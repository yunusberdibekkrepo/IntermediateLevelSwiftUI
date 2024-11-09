//
//  TypeAliasUseCase.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 4.05.2024.
//

import SwiftUI

struct User: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let surname: String
    let age: Int
}

typealias Users = [User]

struct TypeAliasUseCase: View {
    @State var users: Users = .init()

    var body: some View {
        VStack {
            List {
                Section("Users") {
                    ForEach(users, id: \.id) { user in
                        Text(user.name)
                    }
                }
            }
        }
        .onAppear {
            addUser(.init(name: "Yunus ",
                          surname: "Berdibek",
                          age: 22))
        }
    }

    func addUser(_ user: User) {
        users.append(user)
    }
}

#Preview {
    TypeAliasUseCase()
}
