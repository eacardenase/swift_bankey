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

        label.text = "Date"
        label.font = .preferredFont(forTextStyle: .body)

        return label
    }()

    let imageView: UIImageView = {
        let _imageView = UIImageView()

        _imageView.translatesAutoresizingMaskIntoConstraints = false
        _imageView.image = UIImage(systemName: "sun.max.fill")
        _imageView.tintColor = .systemYellow
        _imageView.contentMode = .scaleAspectFit

        _imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        _imageView.heightAnchor.constraint(equalTo: _imageView.widthAnchor)
            .isActive = true

        return _imageView
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 144)
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

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(horizontalStackView)

        addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 16
            ),
            horizontalStackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
        ])

        let trailingConstraint = horizontalStackView.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -16
        )
        trailingConstraint.priority = UILayoutPriority(900)
        trailingConstraint.isActive = true

        let bottomConstraint = horizontalStackView.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -16
        )
        bottomConstraint.priority = UILayoutPriority(900)
        bottomConstraint.isActive = true
    }

}
