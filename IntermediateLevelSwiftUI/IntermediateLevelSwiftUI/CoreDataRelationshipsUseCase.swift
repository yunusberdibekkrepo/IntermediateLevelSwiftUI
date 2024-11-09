//
//  CoreDataRelationshipsUseCase.swift
//  IntermediateLevelSwiftUI
//
//  Created by Yunus Emre Berdibek on 24.04.2024.
//

import CoreData
import SwiftUI

/*

 struct CoreDataRelationshipsUseCase: View {
     @StateObject var viewModel: RelationshipsViewModel = .init()

     var body: some View {
         NavigationView {
             ScrollView {
                 VStack(spacing: 20) {
                     Button(action: viewModel.addBusiness, label: {
                         Text("Perform Action")
                             .foregroundStyle(.white)
                             .frame(height: 55)
                             .frame(maxWidth: .infinity)
                             .background(.blue)
                             .cornerRadius(10)
                     })

                     ScrollView(.horizontal) {
                         HStack(alignment: .top) {
                             ForEach(viewModel.businesses) { business in
                                 BusinessView(entity: business)
                             }
                         }
                     }
                     .scrollIndicators(.hidden)

                     ScrollView(.horizontal) {
                         HStack(alignment: .top) {
                             ForEach(viewModel.departments) { department in
                                 DepartmentView(entity: department)
                             }
                         }
                     }
                     .scrollIndicators(.hidden)

                     ScrollView(.horizontal) {
                         HStack(alignment: .top) {
                             ForEach(viewModel.employees) { employee in
                                 EmployeeView(entity: employee)
                             }
                         }
                     }
                     .scrollIndicators(.hidden)
                 }
                 .padding()
             }
             .navigationTitle("Relationships")
         }
     }
 }

 struct BusinessView: View {
     let entity: BusinessEntity

     var body: some View {
         VStack(alignment: .leading, spacing: 20) {
             Text("Name: \(entity.name ?? "")")
                 .bold()

             if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                 Text("Departments: ")
                     .bold()

                 ForEach(departments) { department in
                     Text(department.name ?? "")
                 }
             }

             if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                 Text("Employees")
                     .bold()

                 ForEach(employees) { employee in
                     Text(employee.name ?? "")
                 }
             }
         }
         .padding()
         .frame(maxWidth: 300, alignment: .leading)
         .background(.gray.opacity(0.5))
         .cornerRadius(10)
         .shadow(radius: 10)
     }
 }

 struct DepartmentView: View {
     let entity: DepartmentEntity

     var body: some View {
         VStack(alignment: .leading, spacing: 20) {
             Text("Name: \(entity.name ?? "")")
                 .bold()

             if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                 Text("Businesses: ")
                     .bold()

                 ForEach(businesses) { business in
                     Text(business.name ?? "")
                 }
             }

             if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                 Text("Employees")
                     .bold()

                 ForEach(employees) { employee in
                     Text(employee.name ?? "")
                 }
             }
         }
         .padding()
         .frame(maxWidth: 300, alignment: .leading)
         .background(.green.opacity(0.5))
         .cornerRadius(10)
         .shadow(radius: 10)
     }
 }

 struct EmployeeView: View {
     let entity: EmployeeEntity

     var body: some View {
         VStack(alignment: .leading, spacing: 20) {
             Text("Name: \(entity.name ?? "")")
                 .bold()

             Text("Age: \(entity.age.description)")
                 .bold()

             Text("Joined Date: \(entity.dataJoined?.formatted(date: .abbreviated, time: .shortened) ?? "")")
                 .bold()

             Text("Business: \(entity.business?.name ?? "")")
                 .bold()

             Text("Department: \(entity.department?.name ?? "")")
                 .bold()
         }
         .padding()
         .frame(maxWidth: 300, alignment: .leading)
         .background(.blue.opacity(0.5))
         .cornerRadius(10)
         .shadow(radius: 10)
     }
 }

 #Preview {
     CoreDataRelationshipsUseCase()
 }

 class RelationshipsViewModel: ObservableObject {
     let manager = CoreDataManager.shared
     @Published var businesses: [BusinessEntity] = []
     @Published var departments: [DepartmentEntity] = []
     @Published var employees: [EmployeeEntity] = []

     init() {
         fetchBusineses()
         fetchDepartments()
         fetchEmployees()
     }

     /*
      - @ = String, i = Integer'i temsil eder.
      - NSPredicate(format: "name CONTAINS %@", "messi")

      */
     public func fetchBusineses() {
         let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
         let sort = NSSortDescriptor(keyPath: \BusinessEntity.name,
                                     ascending: true)
         let filter = NSPredicate(format: "name == %@",
                                  "Barcelona")

         request.sortDescriptors = [sort]
         request.predicate = filter
         do {
             businesses = try manager.context.fetch(request)
         } catch {
             print("ERROR FETCHING:\(error.localizedDescription)")
         }
     }

     public func fetchDepartments() {
         let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")

         do {
             departments = try manager.context.fetch(request)
         } catch {
             print("ERROR FETCHING:\(error.localizedDescription)")
         }
     }

     /*
      CoreDataContainer üzerinden departmententity'de employees'i seçip  delete rule' u ayarlarsak; Mesela nullify ise bu departmanı silersek bu departmanda yer alan employee'ler silinmez ancak department değeri null'a dönüşür.Bunu cascade yaparsak ilgili department silinirse tüm employee'ler de silinir. Deny yapılır ise İçinde bir employee var ise hata verir. O içindeki eleman silinir ise kendini silmeye izin verir.
      */
     public func deleteDepartment() {
         let department = departments[0]

         manager.context.delete(department)
         save()
     }

     public func fetchEmployees() {
         let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")

         do {
             employees = try manager.context.fetch(request)
         } catch {
             print("ERROR FETCHING:\(error.localizedDescription)")
         }
     }

     public func addBusiness() {
         let newBusiness = BusinessEntity(context: manager.context)

         newBusiness.name = "Barcelona"
         newBusiness.addToDepartments(departments[0])
         newBusiness.addToDepartments(departments[2])

         // add existing departments to business
 //        newBusiness.departments = []

         // add existing employees to business
 //        newBusiness.employees = []

         // add new business to existing department
 //        newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)

         // add new business to existing employee
 //        newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)

         save()
     }

     public func addDepartment() {
         let newDepartment = DepartmentEntity(context: manager.context)

         newDepartment.name = "Football"
 //        newDepartment.businesses = [businesses[0]]
         newDepartment.addToEmployees(employees[1])
         save()
     }

     public func addEmployee() {
         let newEmployee = EmployeeEntity(context: manager.context)

         newEmployee.name = "Lionel Messi"
         newEmployee.age = 37
         newEmployee.dataJoined = Date()
 //        newEmployee.business = businesses.first
 //        newEmployee.department = departments.first
         save()
     }

     public func save() {
         businesses.removeAll()
         departments.removeAll()
         employees.removeAll()

         DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
             self.manager.save()
             self.fetchBusineses()
             self.fetchDepartments()
             self.fetchEmployees()
         }
     }
 }

 class CoreDataManager {
     static let shared = CoreDataManager()
     let container: NSPersistentContainer
     let context: NSManagedObjectContext

     init() {
         container = NSPersistentContainer(name: "CoreDataContainer")
         container.loadPersistentStores { _, error in
             if let error {
                 print("ERROR LOADING CORE DATA: \(error.localizedDescription)")
             }
         }
         context = container.viewContext
     }

     func save() {
         do {
             try context.save()
             print("Saved succesfully!")
         } catch {
             print("ERROR SAVING CORE DATA: \(error.localizedDescription)")
         }
     }
 }

 */
