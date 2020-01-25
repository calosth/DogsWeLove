//
//  Resource.swift
//  DogsWeLoveTests
//
//  Created by Carlos Linares on 25/01/20.
//  Copyright © 2020 Carlos Linares. All rights reserved.
//

import XCTest
@testable import DogsWeLove

class ResourceTest: XCTestCase {

    func test_defaultInitializerTakeURLPassed() {
        let url1 = URL(fileURLWithPath: "path")
        let resource1 = Resource<Dog>(url: url1)
        
        XCTAssertEqual(url1, resource1.url)
        
        let url2 = URL(fileURLWithPath: "route")
        let resource2 = Resource<Dog>(url: url2)
        
        XCTAssertEqual(url2, resource2.url)
    }
    
    func test_defaultParserDecodeFromJSON() {
        let fakeDog = Dog(name: "Macarena", description: "Lorem Ipsum", age: 2, url: "https://example.com")
        let dogData = try! JSONEncoder().encode(fakeDog)
        
        let resource = Resource<Dog>(url: URL(fileURLWithPath: "path"))
        
        let resultFromParser = resource.parse(dogData)
            
        XCTAssertEqual(try! resultFromParser.get(), fakeDog)
        
    }

}

extension Dog: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DogCodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(age, forKey: .age)
        try container.encode(url, forKey: .url)
    }
}
