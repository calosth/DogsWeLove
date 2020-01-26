//
//  DogsProviderTest.swift
//  DogsWeLoveTests
//
//  Created by Carlos Linares on 24/01/20.
//  Copyright © 2020 Carlos Linares. All rights reserved.
//

import XCTest
@testable import DogsWeLove

class DogsProviderTest: XCTestCase {
    
    var sut: DogsProvider!
    var mockLocalPersistance: MockLocalPersistance!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        mockNetworkManager = MockNetworkManager()
        mockLocalPersistance = MockLocalPersistance()
        sut = DogsProvider(networkManager: mockNetworkManager, persistance: mockLocalPersistance)
    }
    
    func test_fetchDogsCallLocalPersistanceToFetchLocalData() {
        sut.fetchDogs { _ in }
        
        XCTAssertTrue(mockLocalPersistance.fetchAllDogsCalled)
    }

    func test_fetchDogsUsesPersistanceDataWhenHasDogs() {
        let dogs = [makeDog(), makeDog()]
        mockLocalPersistance.dogs = dogs
                
        var dogsResult: [Dog]?
        sut.fetchDogs { dogsResult = $0 }
        
        XCTAssertEqual(dogsResult, dogs)

    }
    
    func test_fetchDogsUsesNetworkDataWhenPersistanceDoesntHasData() {
        let dogData = makeDataDog()
        
        mockLocalPersistance.dogs = []
        mockNetworkManager.data = dogData
        
        let networkDogsExpectation =  expectation(description: "Network Image expectations")
        
        var dataResult: [Dog]?
        sut.fetchDogs {
            dataResult = $0
            networkDogsExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(self.mockNetworkManager.data,  try! JSONEncoder().encode(dataResult))
        }
    }
    
    func test_fetchDogsCallsSaveInPersistanceWhenNoLocalData() {
        let saveDogsExpectation =  expectation(description: "Save Image expectations")
        
        mockNetworkManager.data = makeDataDog()
        
        sut.fetchDogs { _ in saveDogsExpectation.fulfill() }
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssertTrue(self.mockLocalPersistance.saveDogsCalled)
        }
        
    }
    
    func test_fetchDogImageCallLocalPersistanceToFetchImage() {
        let dog = makeDog()
        mockLocalPersistance.dogs = [makeDog()]
        sut.fetchDataImage(of: dog) { _ in }
        
        XCTAssertTrue(mockLocalPersistance.fetchImageCalled)
    }
    
    func test_fetchDogImageSaveImageInLocalPersistance() {
        let saveImageExpectation =  expectation(description: "Save Image expectations")
            
        mockNetworkManager.data = UIImage(named: "dog-test")!.pngData()!

        sut.fetchDataImage(of: makeDog()) { _ in saveImageExpectation.fulfill() }
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssertTrue(self.mockLocalPersistance.saveImageCalled)
        }
    }
    
    
    
    // MARK: - Helpers
    
    func makeDog() -> Dog {
        return Dog(name: "", description: "", age: 0, url: "https://example.com/dog.jpg")
    }
    
    func makeDataDog() -> Data {
        try! JSONEncoder().encode( [makeDog(), makeDog()] )
    }
}

class MockLocalPersistance: Storage {
    
    var fetchAllDogsCalled = false
    var saveDogsCalled = false
    var fetchImageCalled = false
    var saveImageCalled = false
    var dogs: [Dog] = []
    
    func fetchAllDogs() -> [Dog] {
        fetchAllDogsCalled = true
        return dogs
    }
    
    func fetchDataImage(of dog: Dog) -> Data? {
        fetchImageCalled = true
        return nil
    }
    
    func save(_ dogs: [Dog]) {
        saveDogsCalled = true
    }
    
    func save(dataImage: Data, of dog: Dog) {
        saveImageCalled = true
    }
    
}

class MockNetworkManager: Network {
        
    var data: Data?
    var error: Error?
    
    func fetch<Model>(resource: Resource<Model>, completion: @escaping ((Result<Model, Error>) -> Void)) where Model : Decodable {
        if let error = self.error { completion(.failure(error)) }
        else if let data = self.data { completion(resource.parse(data)) }
    }
    
}

