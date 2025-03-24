//
//  Persistence.swift
//  Jaskiran_Gill_LabTest02
//
//  Created by Jaskiran Gill on 2025-03-23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Jaskiran_Gill_LabTest02")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    private func addSampleProducts() {
        let context = container.viewContext
        for i in 1...10 {
            let product = Product(context: context)
            product.productID = UUID().uuidString
            product.productName = "Product \(i)"
            product.productDescription = "Description for product \(i)"
            product.productPrice = Double(i) * 10.0
            product.productProvider = "Provider \(i)"
        }

    
    }
}
