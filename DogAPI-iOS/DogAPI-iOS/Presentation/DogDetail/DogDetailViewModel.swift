//
//  DogDetailViewModel.swift
//  DogAPI-iOS
//
//  Created by Sévio Basilio Corrêa on 23/09/25.
//

import Foundation

final class DogDetailViewModel {
    private let dog: Dog

    init(dog: Dog) {
        self.dog = dog
    }

    var imageURL: String {
        dog.imageURL
    }

    var breed: String {
        guard let breedsIndex = dog.imageURL.split(separator: "/").firstIndex(of: "breeds"),
              let breedPart = dog.imageURL.split(separator: "/").dropFirst(breedsIndex + 1).first else {
            return "Unknown breed"
        }
        return breedPart.replacingOccurrences(of: "-", with: " ").capitalized
    }
}
