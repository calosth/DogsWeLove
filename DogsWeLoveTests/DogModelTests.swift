//
//  DogModelTests.swift
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
        XCTAssertEqual(dog.url, "https://example.com/macarena.jpg")
    }
    
    func test_allDogsCreateTheResourceWithUrl() {
        let url = URL(string: "https://api.myjson.com/bins/kp2e8")!
        
        let resource = Resource<[Dog]>(url: url)
        
        XCTAssertEqual(Dog.allDogs.url, resource.url)
    }
    
    func test_dateImageCreateResourceWithUrl() {
        let url = URL(string: "https://example.com/dog.jpg")!
        
        let resource = Resource<[Data]>(url: url)
        
        XCTAssertEqual(Dog.dataImage(from: url).url, resource.url)
    }
    
    // MARK: - Helpers
    
    func dataFromJson() -> Data {
        let jsonDog =
        """
            {
                "dogName": "Macarena",
                "description": "Lorem Ipsum",
                "age": 1,
                "url": "https://example.com/macarena.jpg"
            }
        """
        return jsonDog.data(using: .utf8)!
    }
    
    
}
