//
//  FetchRandomDogUseCaseMock.swift
//  DogAPI-iOS
//
//  Created by Sévio Basilio Corrêa on 24/09/25.
//

import Foundation
@testable import DogAPI_iOS

final class FetchRandomDogUseCaseMock: FetchDogUseCaseProtocol {
    
    var shouldFail = false
    
    func execute(completion: @escaping (Result<Dog, Error>) -> Void) {
        if shouldFail {
            completion(.failure(NSError(domain: "Test", code: 0)))
        } else {
            let dog = Dog(imageURL: "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg")
            completion(.success(dog))
        }
    }
}
