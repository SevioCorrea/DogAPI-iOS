//
//  DogListViewController.swift
//  DogAPI-iOS
//
//  Created by Sévio Basilio Corrêa on 23/09/25.
//

import UIKit

final class DogListViewController: UIViewController {

    private let viewModel = DogListViewModel()

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private let contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let tapLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap the dog"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "Pull down to fetch a new dog"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let arrowImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.down")
        iv.tintColor = .gray
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let dogImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

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
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(tapLabel)
        contentView.addSubview(dogImageView)
        contentView.addSubview(bottomLabel)
        contentView.addSubview(arrowImageView)

        scrollView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)

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

            tapLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            tapLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            dogImageView.topAnchor.constraint(equalTo: tapLabel.bottomAnchor, constant: 20),
            dogImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dogImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            dogImageView.heightAnchor.constraint(equalToConstant: 250),

            bottomLabel.topAnchor.constraint(equalTo: dogImageView.bottomAnchor, constant: 20),
            bottomLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            arrowImageView.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 8),
            arrowImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 20),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20),
            arrowImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        dogImageView.isUserInteractionEnabled = true
        dogImageView.addGestureRecognizer(tapGesture)
    }

    private func setupBindings() {
        viewModel.stateChanged = { [weak self] state in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
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
    }

    @objc private func didTapImage() {
        guard let dog = viewModel.lastDog else { return }
        let detailVM = DogDetailViewModel(dog: dog)
        let detailVC = DogDetailViewController(viewModel: detailVM)
        navigationController?.pushViewController(detailVC, animated: true)
    }

    @objc private func didPullToRefresh() {
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
