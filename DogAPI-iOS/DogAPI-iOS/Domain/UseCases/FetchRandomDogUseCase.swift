//
//  FetchRandomDogUseCase.swift
//  DogAPI-iOS
//
//  Created by Sévio Basilio Corrêa on 23/09/25.
//

import Foundation

final class FetchRandomDogUseCase: FetchDogUseCaseProtocol {
    func execute(completion: @escaping (Result<Dog, Error>) -> Void) {
        API.fetchRandomDog { result in
            completion(result)
        }
    }
}
