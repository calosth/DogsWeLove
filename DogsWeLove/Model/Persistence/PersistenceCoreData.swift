//
//  PersistenceCoreData.swift
//  DogsWeLove
//
//  Created by Carlos Linares on 25/01/20.
//  Copyright © 2020 Carlos Linares. All rights reserved.
//

import CoreData

class PersistenceCoreData: Storage {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DogsWeLoveDB")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    func fetchAllDogs() -> [Dog] {

        let localDogs = LocalDog.fetchAll(into: persistentContainer.viewContext)
        
        return localDogs.map {
                Dog(name: $0.name ?? "",
                description: $0.about ?? "",
                age: Int($0.age),
                url: $0.url ?? "")
        }

    }
    
    func fetchDataImage(of dog: Dog) -> Data? {
        guard
            let localDog = LocalDog.fetchWith(name: dog.name, into: persistentContainer.viewContext)
            else { return nil }
        
        return localDog.image
        
    }
    
    func save(_ dogs: [Dog]) {
        for dog in dogs {
            LocalDog.insert(dog, into: persistentContainer.viewContext)
            
            saveInContext()
        }
        
    }
    
    func save(dataImage: Data, of dog: Dog) {
        guard
            let localDog = LocalDog.fetchWith(name: dog.name, into: persistentContainer.viewContext)
            else { return }
        
            localDog.assignDataImage(dataImage)
            saveInContext()
    }
    
    private func saveInContext() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
}
