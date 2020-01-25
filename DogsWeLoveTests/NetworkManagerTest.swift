//
//  NetworkManagerTest.swift
//  DogsWeLoveTests
//
//  Created by Carlos Linares on 24/01/20.
//  Copyright © 2020 Carlos Linares. All rights reserved.
//

import XCTest
@testable import DogsWeLove

class NetworkManagerTest: XCTestCase {
    
    var sut: NetworkManager!
    var session: MockNetworkSession!
    
    override func setUp() {
        session = MockNetworkSession()
        sut = NetworkManager(session: session)
    }
    
    func test_fetchCallsLoadDataWithSuccess() {

        let dataTest = Data([0, 1, 0, 1])
        session.data = dataTest
        let resource = Resource<Data>(url: dummyURL) { _ in .success(dataTest) }
         
        var result: Result<Data, Error>?
        sut.fetch(resource: resource) { result = $0 }
    
        XCTAssertEqual(try result?.get(), dataTest)
    }

    func test_fetchCallLoadDataWithFailure() {

        let testError = TestError()
        let resource = Resource<Data>(url: dummyURL)
        session.error = testError
         
        var result: Result<Data, Error>?
        sut.fetch(resource: resource) { result = $0 }
        
        switch result {
        case .failure(let error):
            XCTAssertEqual((error as! TestError), testError)
        
        default: XCTFail("No error thrown")
        }
        
    }
    
    // MARK: - Helpers

    let dummyURL = URL(fileURLWithPath: "path")
    
    class TestError: Error, Equatable {
        var localizedDescription: String = "TestError"
        
        static func == (lhs: NetworkManagerTest.TestError, rhs: NetworkManagerTest.TestError) -> Bool {
            return lhs.localizedDescription == rhs.localizedDescription
        }
        
    }
}

extension NetworkManagerTest {
    class MockNetworkSession: NetworkSession {
        var data: Data?
        var error: Error?
        
        func loadData(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
            completionHandler(data, error)
        }
    }
}
