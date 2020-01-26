//
//  DogsProvider.swift
//  DogsWeLove
//
//  Created by Carlos Linares on 24/01/20.
//  Copyright © 2020 Carlos Linares. All rights reserved.
//

import UIKit

protocol DogData {
    func fetchDogs(_ callback: @escaping ([Dog]) -> Void)
    func fetchImage(of dog: Dog, callback: @escaping (UIImage?) -> Void)
}

class DogsProvider: DogData {
    
    var storage: Storage
    var network: Network
    
    init(networkManager: Network, persistance: Storage) {
        self.storage = persistance
        self.network = networkManager
    }

    func fetchDogs(_ callback: @escaping ([Dog]) -> Void) {
        let localDogs = storage.fetchAllDogs()
        
        if !localDogs.isEmpty {
            callback(localDogs)
        } else {
            network.fetch(resource: Dog.allDogs) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let dogs):
                        self.storage.save(dogs)
                        callback(dogs)
                        
                    case .failure(_): break
                    }
                }
            }
            
        }
        
    }
    
    func fetchImage(of dog: Dog, callback: @escaping (UIImage?) -> Void) {
        
        if let image = storage.fetchImage(of: dog) {
            callback(image)
        } else {
            
            guard let url = URL(string: dog.url) else { return }
            
            network.fetch(resource: Dog.dataImage(from: url)) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let imageData):
                    
                        guard let image = UIImage(data: imageData) else { return }
                        self.storage.save(image, of: dog)
                        callback(image)
                    
                    case .failure(_): break
                    }
                }
                
            }
            
        }
        
    }
}
