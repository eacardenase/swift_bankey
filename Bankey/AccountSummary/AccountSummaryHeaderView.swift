//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by Edwin Cardenas on 6/28/25.
//

import UIKit

class AccountSummaryHeaderView: UIView {

    let bankeyLabel: UILabel = {
        let label = UILabel()

        label.text = "Bankey"
        label.font = .preferredFont(forTextStyle: .title1)

        return label
    }()

    let greetingLabel: UILabel = {
        let label = UILabel()

        label.text = "Good morning,"

        return label
    }()

    let usernameLabel: UILabel = {
        let label = UILabel()

        label.text = "Jonathan"

        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()

        label.text = "Bankey"
        label.font = .preferredFont(forTextStyle: .body)

        return label
    }()

    let imageView: UIImageView = {
        let _imageView = UIImageView()

        _imageView.image = UIImage(systemName: "sun.max.fill")
        _imageView.tintColor = .systemYellow

        _imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        _imageView.heightAnchor.constraint(equalTo: _imageView.widthAnchor)
            .isActive = true

        return _imageView
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 144))

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Helpers

extension AccountSummaryHeaderView {

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = appColor

        let verticalStackView = UIStackView(arrangedSubviews: [
            bankeyLabel,
            greetingLabel,
            usernameLabel,
            dateLabel,
        ])

        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fill
        verticalStackView.spacing = 8

        let horizontalStackView = UIStackView(arrangedSubviews: [
            verticalStackView,
            imageView,
        ])

        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .top
        horizontalStackView.distribution = .fill
        horizontalStackView.spacing = 4

        addSubview(horizontalStackView)

        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 16
            ),
            horizontalStackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            horizontalStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            horizontalStackView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -16
            ),
        ])
    }

}
