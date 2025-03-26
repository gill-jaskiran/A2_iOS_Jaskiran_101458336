//  A2_iOS_Jaskiran_101458336
//  PersistenceController.swift
//  Jaskiran_Gill_LabTest02
//
//  Created by Jaskiran Gill on 2025-03-23.
//

import CoreData

// Implementing controller to manage the data stack
struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer
    // all default code and error handling when project was created
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
}
