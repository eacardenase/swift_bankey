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
        label.text =
            "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in 1989."

        return label
    }()

    // MARK: - Initializers

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
