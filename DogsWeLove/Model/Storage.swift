//
//  Storage.swift
//  DogsWeLove
//
//  Created by Carlos Linares on 25/01/20.
//  Copyright © 2020 Carlos Linares. All rights reserved.
//

import Foundation

protocol Storage {
    func fetchAllDogs() -> [Dog]
    func fetchDataImage(of dog: Dog) -> Data?
    func save(_ dogs: [Dog])
    func save(dataImage: Data, of dog: Dog)
}
