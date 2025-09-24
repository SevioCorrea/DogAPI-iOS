//
//  DogImageView.swift
//  DogAPI-iOS
//
//  Created by Sévio Basilio Corrêa on 23/09/25.
//

import UIKit

final class DogImageView: UIView {

    enum Mode {
        case list
        case detail
    }

    private let mode: Mode

    let tapLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap the dog"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "Pull down to fetch a new dog"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let arrowImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.down")
        iv.tintColor = .gray
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    init(mode: Mode) {
        self.mode = mode
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) { nil }

    private func setupViews() {
        addSubview(imageView)

        if mode == .list {
            addSubview(tapLabel)
            addSubview(bottomLabel)
            addSubview(arrowImageView)
        }

        var constraints: [NSLayoutConstraint] = []

        if mode == .list {
            constraints += [
                tapLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
                tapLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

                imageView.topAnchor.constraint(equalTo: tapLabel.bottomAnchor, constant: 20),
                imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
                imageView.heightAnchor.constraint(equalToConstant: 250),

                bottomLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
                bottomLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

                arrowImageView.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 8),
                arrowImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                arrowImageView.widthAnchor.constraint(equalToConstant: 20),
                arrowImageView.heightAnchor.constraint(equalToConstant: 20),
                arrowImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
            ]
        } else {
            constraints += [
                imageView.topAnchor.constraint(equalTo: topAnchor),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        }

        NSLayoutConstraint.activate(constraints)
    }
}
