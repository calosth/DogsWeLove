//
//  NetworkManager.swift
//  DogsWeLove
//
//  Created by Carlos Linares on 24/01/20.
//  Copyright © 2020 Carlos Linares. All rights reserved.
//

import UIKit

protocol NetworkSession {
    func loadData(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func loadData(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) { data, _, error in
            completionHandler(data, error)
        }
        task.resume()
    }
}

class NetworkManager {
    
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
        
    func fetch<Model>(resource: Resource<Model>, completion: @escaping ((Result<Model, Error>) -> Void)) {
        
        session.loadData(from: resource.url) { data, error in
            if let error = error { completion(.failure(error)) }
            else if let data = data { completion(resource.parse(data)) }

        }
    }
}
