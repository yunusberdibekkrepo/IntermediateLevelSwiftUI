//
//  CoreDataUseCase.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 23.04.2024.
//

import CoreData
import SwiftUI

/*

struct CoreDataUseCase: View {
    @StateObject var viewModel: CoreDataViewModel = .init()
    @State var textfieldText: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Add fruit here...", text: $textfieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(.placeholder.opacity(0.25))
                    .cornerRadius(10)
                    .padding(.horizontal)

                Button(action: {
                    guard !textfieldText.isEmpty else { return }

                    withAnimation {
                        viewModel.addFruit(text: textfieldText)
                    }
                }, label: {
                    Text("Submit")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.blue.gradient)
                        .cornerRadius(10)
                })
                .padding(.horizontal)

                List {
                    ForEach(viewModel.savedEntities) { fruit in
                        Text(fruit.name ?? "Empty")
                            .onTapGesture {
                                viewModel.updateFruit(entity: fruit)
                            }
                    }
                    .onDelete(perform: viewModel.deleteFruit)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Fruits")
        }
    }
}

#Preview {
    CoreDataUseCase()
}

class CoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedEntities: [FruitEntity] = []

    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { _, error in
            if let error {
                print("ERROR LOADING CORE DATA:\(error.localizedDescription)")
            }
        }

        fetchFruits()
    }

    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")

        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch {
            print("ERROR FETCHING: \(error.localizedDescription)")
        }
    }

    func addFruit(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)

        newFruit.name = text
        saveData()
    }

    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let fruit = savedEntities[index]

        container.viewContext.delete(fruit)
        saveData()
    }

    func updateFruit(entity: FruitEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + "!"

        entity.name = newName
        saveData()
    }

    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch {
            print("ERROR SAVING: \(error.localizedDescription)")
        }
    }
}

*/
