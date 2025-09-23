//
//  DogListViewModel.swift
//  DogAPI-iOS
//
//  Created by Sévio Basilio Corrêa on 23/09/25.
//

import Foundation

final class DogListViewModel {

    enum ViewState {
        case idle
        case loading
        case success(Dog)
        case failure(Error)
    }

    private let fetchDogUseCase = FetchRandomDogUseCase()
    var stateChanged: ((ViewState) -> Void)?
    
    private(set) var lastDog: Dog?

    func fetchDog() {
        stateChanged?(.loading)
        fetchDogUseCase.execute { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let dog):
                    self?.lastDog = dog
                    self?.stateChanged?(.success(dog))
                case .failure(let error):
                    self?.stateChanged?(.failure(error))
                }
            }
        }
    }
}
