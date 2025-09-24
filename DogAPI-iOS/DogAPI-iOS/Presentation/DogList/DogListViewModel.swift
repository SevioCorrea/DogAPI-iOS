//
//  DogListViewModel.swift
//  DogAPI-iOS
//
//  Created by Sévio Basilio Corrêa on 23/09/25.
//

import Foundation

final class DogListViewModel {

    enum ViewState: Equatable {
        case idle
        case loading
        case success(Dog)
        case failure(Error)
        
        // Implementa Equatable manualmente para os casos com valores associados
        static func == (lhs: ViewState, rhs: ViewState) -> Bool {
            switch (lhs, rhs) {
            case (.idle, .idle): return true
            case (.loading, .loading): return true
            case (.success(let dog1), .success(let dog2)):
                return dog1.imageURL == dog2.imageURL
            case (.failure, .failure):
                return true // Você pode detalhar comparando códigos de erro se quiser
            default:
                return false
            }
        }
    }

    private let fetchDogUseCase: FetchDogUseCaseProtocol
    var stateChanged: ((ViewState) -> Void)?

    private(set) var lastDog: Dog?

    init(fetchDogUseCase: FetchDogUseCaseProtocol = FetchRandomDogUseCase()) {
        self.fetchDogUseCase = fetchDogUseCase
    }

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
