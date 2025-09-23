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
            dogView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        dogView.imageView.isUserInteractionEnabled = true
        dogView.imageView.addGestureRecognizer(tapGesture)
    }

    private func setupBindings() {
        viewModel.stateChanged = { [weak self] state in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                switch state {
                case .idle: break
                case .loading: break
                case .success(let dog):
                    self?.dogView.imageView.load(from: dog.imageURL)
                case .failure: break
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
