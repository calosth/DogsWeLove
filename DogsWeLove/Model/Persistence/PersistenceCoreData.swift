//
//  PersistenceCoreData.swift
//  DogsWeLove
//
//  Created by Carlos Linares on 25/01/20.
//  Copyright © 2020 Carlos Linares. All rights reserved.
//

import CoreData
import UIKit

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
    
    func fetchImage(of dog: Dog) -> UIImage? {
        guard
            let localDog = LocalDog.fetchWith(name: dog.name, into: persistentContainer.viewContext),
            let imageData = localDog.image
            else { return nil }
        
        return UIImage(data: imageData)
        
    }
    
    func save(_ dogs: [Dog]) {
        for dog in dogs {
            LocalDog.insert(dog, into: persistentContainer.viewContext)
            
            saveInContext()
        }
        
    }
    
    func save(_ image: UIImage, of dog: Dog) {
        guard
            let localDog = LocalDog.fetchWith(name: dog.name, into: persistentContainer.viewContext),
            let image = image.pngData() else { return }
        
            localDog.assignImage(image)
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
