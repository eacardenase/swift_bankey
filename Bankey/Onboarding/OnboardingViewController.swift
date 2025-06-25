//
//  OnboardingViewController.swift
//  Bankey
//
//  Created by Edwin Cardenas on 6/24/25.
//

import UIKit

class OnboardingViewController: UIViewController {

    let onboardingStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20

        return stackView
    }()

    let onboardingImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(resource: .delorean)

        return imageView
    }()

    let onboardingLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0

        return label
    }()

    // MARK: - Initializers

    init(heroImageName resource: ImageResource, titleText: String) {
        onboardingImageView.image = UIImage(resource: resource)
        onboardingLabel.text = titleText

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
}

// MARK: - Helpers

extension OnboardingViewController {

    private func setupViews() {
        onboardingStackView.addArrangedSubview(onboardingImageView)
        onboardingStackView.addArrangedSubview(onboardingLabel)

        view.backgroundColor = .systemBackground
        view.addSubview(onboardingStackView)

        NSLayoutConstraint.activate([
            onboardingStackView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            onboardingStackView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            onboardingStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 8
            ),
            onboardingStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -8
            ),
        ])
    }

}
