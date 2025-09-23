//
//  DogDetailViewModel.swift
//  DogAPI-iOS
//
//  Created by Sévio Basilio Corrêa on 23/09/25.
//

import Foundation

final class DogDetailViewModel {

    private let dog: Dog

    var imageURL: String {
        return dog.imageURL
    }

    init(dog: Dog) {
        self.dog = dog
    }
}
