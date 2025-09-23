//
//  DogListViewController.swift
//  DogAPI-iOS
//
//  Created by Sévio Basilio Corrêa on 23/09/25.
//

import UIKit

final class DogListViewController: UIViewController {

    private let viewModel = DogListViewModel()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap the dog"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

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
        view.addSubview(infoLabel)
        view.addSubview(dogImageView)
        view.addSubview(fetchButton)

        NSLayoutConstraint.activate([
            infoLabel.bottomAnchor.constraint(equalTo: dogImageView.topAnchor, constant: -10),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            dogImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dogImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            dogImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            dogImageView.heightAnchor.constraint(equalToConstant: 300),

            fetchButton.topAnchor.constraint(equalTo: dogImageView.bottomAnchor, constant: 20),
            fetchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        fetchButton.addTarget(self, action: #selector(fetchButtonTapped), for: .touchUpInside)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        dogImageView.isUserInteractionEnabled = true
        dogImageView.addGestureRecognizer(tapGesture)
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

    @objc private func didTapImage() {
        guard let dog = viewModel.lastDog else { return }
        let detailVM = DogDetailViewModel(dog: dog)
        let detailVC = DogDetailViewController(viewModel: detailVM)
        navigationController?.pushViewController(detailVC, animated: true)
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
