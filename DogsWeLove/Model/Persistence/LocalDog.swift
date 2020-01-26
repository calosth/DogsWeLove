//
//  LocalDogs.swift
//  DogsWeLove
//
//  Created by Carlos Linares on 25/01/20.
//  Copyright © 2020 Carlos Linares. All rights reserved.
//

import CoreData

extension LocalDog {
    
    private static var entityName = "LocalDog"
    
    static func insert(_ dog: Dog, into context: NSManagedObjectContext) {
        let localDog = NSEntityDescription.insertNewObject(forEntityName: "LocalDog", into: context)
        localDog.setValue(dog.name, forKey: #keyPath(LocalDog.name))
        localDog.setValue(dog.description, forKey: #keyPath(LocalDog.about))
        localDog.setValue(dog.age, forKey: #keyPath(LocalDog.age))
        localDog.setValue(dog.url, forKey: #keyPath(LocalDog.url))
    }
    
    private static func byName(_ name: String) -> NSPredicate { NSPredicate(format: "%K == %@", #keyPath(LocalDog.name), name) }
    
    static func fetchAll(into context: NSManagedObjectContext) -> [LocalDog] {
        let fetchRequest: NSFetchRequest<LocalDog>  = NSFetchRequest<LocalDog>(entityName: entityName)
        
        let localDogs = try? context.fetch(fetchRequest)
        return localDogs ?? []
    }
    
    static func fetchWith(name: String, into context: NSManagedObjectContext) -> LocalDog? {
        let fetchRequest: NSFetchRequest<LocalDog>  = NSFetchRequest<LocalDog>(entityName: entityName)
        fetchRequest.predicate = LocalDog.byName(name)
        
        let localDog = try? context.fetch(fetchRequest)
        return localDog?.first
    }
    
    func assignImage(_ data: Data) {
        self.setValue(data, forKey: #keyPath(LocalDog.image))
    }
    
   
}
