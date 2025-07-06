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

    let welcomeLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    let nameLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()

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

    let shakeyBellView: ShakeyBellView = {
        let view = ShakeyBellView()

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    struct ViewModel {
        let welcomeMessage: String
        let name: String
        let date: Date

        var dateFormatted: String {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium

            return formatter.string(from: date)
        }
    }

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
        backgroundColor = appColor

        let verticalStackView = UIStackView(arrangedSubviews: [
            bankeyLabel,
            welcomeLabel,
            nameLabel,
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
        addSubview(shakeyBellView)

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

        // shakeyBellView
        NSLayoutConstraint.activate([
            shakeyBellView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shakeyBellView.bottomAnchor.constraint(equalTo: bottomAnchor),
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

    private func configure(with viewModel: ViewModel) {
        welcomeLabel.text = viewModel.welcomeMessage
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.dateFormatted
    }

}
