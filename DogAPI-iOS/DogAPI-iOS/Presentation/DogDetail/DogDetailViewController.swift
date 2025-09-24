//
//  DogDetailViewController.swift
//  DogAPI-iOS
//
//  Created by Sévio Basilio Corrêa on 23/09/25.
//

import UIKit

final class DogDetailViewController: UIViewController {

    private let viewModel: DogDetailViewModel
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let dogView = DogImageView(mode: .detail)

    private let breedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "breedLabel"
        return label
    }()

    init(viewModel: DogDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Dog Detail"

        setupViews()
        configure()
    }

    private func setupViews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        dogView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(dogView)
        contentView.addSubview(breedLabel)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            dogView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            dogView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dogView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dogView.heightAnchor.constraint(equalTo: dogView.widthAnchor),

            breedLabel.topAnchor.constraint(equalTo: dogView.bottomAnchor, constant: 16),
            breedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            breedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            breedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    private func configure() {
        dogView.imageView.load(from: viewModel.imageURL)
        breedLabel.text = viewModel.breed
    }
}
