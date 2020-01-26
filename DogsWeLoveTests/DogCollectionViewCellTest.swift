//
//  DogCollectionViewCellTest.swift
//  DogsWeLoveTests
//
//  Created by Carlos Linares on 24/01/20.
//  Copyright © 2020 Carlos Linares. All rights reserved.
//

import XCTest
@testable import DogsWeLove

class DogCollectionViewCellTests: XCTestCase {
    
    var sut: DogCollectionViewCell!
    
    override func setUp() {
        sut = DogCollectionViewCell(frame: .zero)
    }
    
    func test_configureText() {
        sut.configure(name: "Macarena", description: "Lorem Ipsum", age: 2)
        
        XCTAssertEqual(sut.nameLabel.text, "Macarena")
        XCTAssertEqual(sut.descriptionLabel.text, "Lorem Ipsum")
        XCTAssertEqual(sut.ageLabel.text, "Almost 2 years")
    }
    
    func test_configureImageSetsTheImageView() {
        let imageData = UIImage(named: "dog-test")!.pngData()!
        
        sut.configure(imageData)
        
        XCTAssertEqual(sut.imageView.image?.pngData()!, imageData)
    }
    
    func func_configureImage() {
        sut.configure(UIImage().pngData()!)
        
        XCTAssertEqual(sut.imageView, UIImageView(image: UIImage()))
    }
}
