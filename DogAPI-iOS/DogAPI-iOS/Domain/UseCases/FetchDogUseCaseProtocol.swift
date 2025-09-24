//
//  FetchDogUseCaseProtocol.swift
//  DogAPI-iOS
//
//  Created by Sévio Basilio Corrêa on 24/09/25.
//

import Foundation

protocol FetchDogUseCaseProtocol {
    func execute(completion: @escaping (Result<Dog, Error>) -> Void)
}
