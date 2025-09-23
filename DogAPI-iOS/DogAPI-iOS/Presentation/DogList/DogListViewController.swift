//
//  DogListViewController.swift
//  DogAPI-iOS
//
//  Created by Sévio Basilio Corrêa on 23/09/25.
//

import UIKit

final class DogListViewController: UIViewController {

    private let viewModel = DogListViewModel()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let dogView = DogImageView()
    private let refreshControl = UIRefreshControl()

    private let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .large)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.hidesWhenStopped = true
        return ai
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Failed to fetch dog. Pull down to retry."
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .red
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(dogView)
        contentView.addSubview(activityIndicator)
        contentView.addSubview(errorLabel)

        scrollView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)

        dogView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            dogView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dogView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dogView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dogView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: dogView.imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: dogView.imageView.centerYAnchor),

            errorLabel.topAnchor.constraint(equalTo: dogView.arrowImageView.bottomAnchor, constant: 12),
            errorLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        dogView.imageView.isUserInteractionEnabled = true
        dogView.imageView.addGestureRecognizer(tapGesture)
    }

    private func setupBindings() {
        viewModel.stateChanged = { [weak self] state in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.errorLabel.isHidden = true
                switch state {
                case .idle:
                    self?.activityIndicator.stopAnimating()
                case .loading:
                    self?.activityIndicator.startAnimating()
                case .success(let dog):
                    self?.activityIndicator.stopAnimating()
                    self?.dogView.imageView.load(from: dog.imageURL)
                case .failure:
                    self?.activityIndicator.stopAnimating()
                    self?.errorLabel.isHidden = false
                }
            }
        }
    }

    @objc private func didTapImage() {
        guard let dog = viewModel.lastDog else { return }
        let detailVC = DogDetailViewController(viewModel: DogDetailViewModel(dog: dog))
        navigationController?.pushViewController(detailVC, animated: true)
    }

    @objc private func didPullToRefresh() {
        viewModel.fetchDog()
    }
}
