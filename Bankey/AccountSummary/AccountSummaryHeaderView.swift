//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by Edwin Cardenas on 6/28/25.
//

import UIKit

class AccountSummaryHeaderView: UIView {

    let horizontalStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fill
        stackView.spacing = 4

        return stackView
    }()

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

        _imageView.image = UIImage(systemName: "sun.max.fill")
        _imageView.tintColor = .systemYellow

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

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false

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

        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(imageView)

        contentView.addSubview(horizontalStackView)

        addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 16
            ),
            contentView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            contentView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            contentView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -16
            ),
        ])

        //        contentView.setContentHuggingPriority(.defaultLow, for: .horizontal)

        verticalStackView.setContentHuggingPriority(
            UILayoutPriority(240),
            for: .horizontal
        )
        
        imageView.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        imageView.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
    }

}
