//
//  API.swift
//  DogAPI-iOS
//
//  Created by Sévio Basilio Corrêa on 24/09/25.
//

import Foundation

struct API {
    static func fetchRandomDog(completion: @escaping (Result<Dog, Error>) -> Void) {
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "API", code: 0)))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(DogResponse.self, from: data)
                let dog = Dog(imageURL: decoded.message)
                completion(.success(dog))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

struct DogResponse: Decodable {
    let message: String
}
