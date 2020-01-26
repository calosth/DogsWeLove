//
//  DogListBuilder.swift
//  DogsWeLove
//
//  Created by Carlos Linares on 25/01/20.
//  Copyright © 2020 Carlos Linares. All rights reserved.
//

import UIKit

struct DogListBuilder {
    static func makeDogListViewController() -> UIViewController {
        
        let dogsProvider = DogsProvider(
            networkManager: NetworkManager(),
            persistance: PersistenceCoreData())

        return UINavigationController(rootViewController: DogListViewController(dogProvider: dogsProvider))
    }
}
