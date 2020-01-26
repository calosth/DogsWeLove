//
//  Storage.swift
//  DogsWeLove
//
//  Created by Carlos Linares on 25/01/20.
//  Copyright © 2020 Carlos Linares. All rights reserved.
//

import UIKit

protocol Storage {
    func fetchAllDogs() -> [Dog]
    func fetchImage(of dog: Dog) -> UIImage?
    func save(_ dogs: [Dog])
    func save(_ image: UIImage, of dog: Dog)
}
