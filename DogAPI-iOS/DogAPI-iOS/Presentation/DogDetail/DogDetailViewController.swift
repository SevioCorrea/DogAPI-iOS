//
//  DogDetailViewController.swift
//  DogAPI-iOS
//
//  Created by Sévio Basilio Corrêa on 23/09/25.
//

import UIKit

final class DogDetailViewController: UIViewController {

    private let viewModel: DogDetailViewModel

    private let dogImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    init(viewModel: DogDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Dog Detail"
        setupViews()
        loadImage()
    }

    private func setupViews() {
        view.addSubview(dogImageView)
        NSLayoutConstraint.activate([
            dogImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dogImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dogImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            dogImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)
        ])
    }

    private func loadImage() {
        guard let url = URL(string: viewModel.imageURL) else { return }
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
