//
//  DogRemoteDataSource.swift
//  DogAPI-iOS
//
//  Created by Sévio Basilio Corrêa on 23/09/25.
//

import Foundation

final class DogRemoteDataSource {
    
    func fetchRandomDog(completion: @escaping (Result<DogDTO, Error>) -> Void) {
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else { return }
        APIService.shared.get(url: url, completion: completion)
    }
}
