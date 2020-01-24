//
//  DogsObject.swift
//  DogsWeLove
//
//  Created by Carlos Linares on 24/01/20.
//  Copyright © 2020 Carlos Linares. All rights reserved.
//

import Foundation

struct Dog {
    let name: String
    let description: String
    let age: Int
    let url: String
}

extension Dog: Codable {
    enum DogCodingKeys: String, CodingKey {
        case name = "dogName"
        case description
        case age
        case url
    }
    
    init(from decoder: Decoder) throws {
        let dogContainer = try decoder.container(keyedBy: DogCodingKeys.self)
        
        name = try dogContainer.decode(String.self, forKey: .name)
        description = try dogContainer.decode(String.self, forKey: .description)
        age = try dogContainer.decode(Int.self, forKey: .age)
        url = try dogContainer.decode(String.self, forKey: .url)
    }
}
