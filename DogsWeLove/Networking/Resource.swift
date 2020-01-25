//
//  Resource.swift
//  DogsWeLove
//
//  Created by Carlos Linares on 25/01/20.
//  Copyright © 2020 Carlos Linares. All rights reserved.
//

import Foundation

struct Resource<Model: Decodable> {
    let url: URL
    let parse: (Data) -> Result<Model, Error>
}

extension Resource {
    init(url: URL) {
        self.url = url
        self.parse = { data in
            Result { try JSONDecoder().decode(Model.self, from: data) }
        }
    }
}
