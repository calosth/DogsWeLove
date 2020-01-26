//
//  DogListViewControllerTest.swift
//  DogsWeLoveTests
//
//  Created by Carlos Linares on 24/01/20.
//  Copyright © 2020 Carlos Linares. All rights reserved.
//

import XCTest
@testable import DogsWeLove

class DogListViewControllerTest: XCTestCase {
    
    var sut: DogListViewController!
    var mockDataProvider: MockDogsProvider!
    
    override func setUp() {
        mockDataProvider = MockDogsProvider()
        sut = DogListViewController(dogProvider: mockDataProvider)
    }
    
    func test_viewDidLoadSetCollectionViewDataSource() {
        
        sut.viewDidLoad()
        
        XCTAssertTrue(sut.collectionView.dataSource === sut)
    }
    
    func test_viewDidLoadSetCollectionViewDelegate() {
        
        sut.viewDidLoad()
        
        XCTAssertTrue(sut.collectionView.delegate === sut)
    }
    
    func test_fetchDogsIsCalledWhenViewDidLoad() {
        
        sut.viewDidLoad()
        
        XCTAssertTrue(mockDataProvider.fetchDogCalled)
    }
    
    func test_collectionViewHasZeroCellsWhenThereAreNoDogs() {
    
        mockDataProvider.dogs = []
        let numberOfCell = sut.collectionView(sut.collectionView, numberOfItemsInSection: 0)
        
        XCTAssertEqual(numberOfCell, 0)
    }
    
    func test_collectionViewHasThreeCellsWhenThereAreThreeDogs() {
        
        sut.viewDidLoad()
        
        let numberOfCell = sut.collectionView(sut.collectionView, numberOfItemsInSection: 0)
        
        XCTAssertEqual(numberOfCell, 3)
    }
    
    func test_fetchImageOfDogsCalledAfterShowingACell() {

        sut.viewDidLoad()
        
        _ = sut.collectionView(sut.collectionView, willDisplay: DogCollectionViewCell(), forItemAt: IndexPath(item: 0, section: 0))
        
        XCTAssertTrue(mockDataProvider.fetchImageCalled)
    }

}

extension DogListViewControllerTest {
    class MockDogsProvider: DogData {
        
        var fetchDogCalled = false
        var fetchImageCalled = false
        
        var dogs = [Dog(name: "Lorem ipsum", description: "Loremp Ipsum", age: 2, url: "Loremp Ipsum"),
                    Dog(name: "Lorem ipsum", description: "Loremp Ipsum", age: 2, url: "Loremp Ipsum"),
                    Dog(name: "Lorem ipsum", description: "Loremp Ipsum", age: 2, url: "Loremp Ipsum")]
        
        func fetchDogs(_ callback: @escaping ([Dog]) -> Void) {
            fetchDogCalled = true
            
            
            callback(dogs)
        }
        
        func fetchDataImage(of dog: Dog, callback: @escaping (Data) -> Void) {
            fetchImageCalled = true
        }
    }
}
