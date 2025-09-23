//
//  DogListViewController.swift
//  DogAPI-iOS
//
//  Created by Sévio Basilio Corrêa on 23/09/25.
//

import UIKit

final class DogListViewController: UIViewController {

    private let viewModel = DogListViewModel()

    private let dogImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let fetchButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Fetch Dog", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Random Dog"

        setupViews()
        setupBindings()

        viewModel.fetchDog()
    }

    private func setupViews() {
        view.addSubview(dogImageView)
        view.addSubview(fetchButton)

        NSLayoutConstraint.activate([
            dogImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dogImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            dogImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            dogImageView.heightAnchor.constraint(equalToConstant: 300),

            fetchButton.topAnchor.constraint(equalTo: dogImageView.bottomAnchor, constant: 20),
            fetchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        fetchButton.addTarget(self, action: #selector(fetchButtonTapped), for: .touchUpInside)
    }

    private func setupBindings() {
        viewModel.stateChanged = { [weak self] state in
            switch state {
            case .idle:
                break
            case .loading:
                break
            case .success(let dog):
                self?.loadImage(from: dog.imageURL)
            case .failure:
                break
            }
        }
    }

    @objc private func fetchButtonTapped() {
        viewModel.fetchDog()
    }

    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.dogImageView.image = image
                }
            }
        }
    }
}
