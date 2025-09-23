//
//  FetchRandomDogUseCase.swift
//  DogAPI-iOS
//
//  Created by Sévio Basilio Corrêa on 23/09/25.
//

import Foundation

final class FetchRandomDogUseCase {
    
    private let remoteDataSource: DogRemoteDataSource
    
    init(remoteDataSource: DogRemoteDataSource = DogRemoteDataSource()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func execute(completion: @escaping (Result<Dog, Error>) -> Void) {
        remoteDataSource.fetchRandomDog { result in
            switch result {
            case .success(let dto):
                let dog = Dog(imageURL: dto.message)
                completion(.success(dog))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
