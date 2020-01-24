//
//  DogsWeLoveTests.swift
//  DogsWeLoveTests
//
//  Created by Carlos Linares on 24/01/20.
//  Copyright © 2020 Carlos Linares. All rights reserved.
//

import XCTest
@testable import DogsWeLove

class DogModelTests: XCTestCase {

    func test_DecodeDogWithJson() {
        let data = dataFromJson()
        let dog = try! JSONDecoder().decode(Dog.self, from: data)
        
        XCTAssertEqual(dog.name, "Macarena")
        XCTAssertEqual(dog.description, "Lorem Ipsum")
        XCTAssertEqual(dog.age, 1)
        XCTAssertEqual(dog.url, "https://examplle.com/macarena.jpg")
    }
    
    // MARK: - Helpers
    
    func dataFromJson() -> Data {
        let jsonDog =
        """
            {
                "dogName": "Macarena",
                "description": "Lorem Ipsum",
                "age": 1,
                "url": "https://examplle.com/macarena.jpg"
            }
        """
        return jsonDog.data(using: .utf8)!
    }
    
}
