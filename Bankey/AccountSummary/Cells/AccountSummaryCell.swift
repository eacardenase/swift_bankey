//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by Edwin Cardenas on 7/1/25.
//

import UIKit

class AccountSummaryCell: UITableViewCell {

    let typeLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        label.text = "Account type"

        return label
    }()

    let underlineView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = appColor

        return view
    }()

    let nameLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.text = "Account name"

        return label
    }()

    let balanceStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0

        return stackView
    }()

    let balanceLabel: UILabel = {
        let label = UILabel()

        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .right
        label.text = "Some balance"

        return label
    }()

    let balanceAmountLabel: UILabel = {
        let label = UILabel()

        label.textAlignment = .right
        label.text = "$929,466.63"

        return label
    }()

    let chevronImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = appColor
        imageView.image = UIImage(systemName: "chevron.right")

        return imageView
    }()

    static let rowHeight: CGFloat = 100

    // MARK: View Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Helpers

extension AccountSummaryCell {

    private func setupViews() {
        contentView.addSubview(typeLabel)
        contentView.addSubview(underlineView)
        contentView.addSubview(nameLabel)

        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)

        contentView.addSubview(balanceStackView)
        contentView.addSubview(chevronImageView)

        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 16
            ),
            typeLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),

        ])

        NSLayoutConstraint.activate([
            underlineView.topAnchor.constraint(
                equalTo: typeLabel.bottomAnchor,
                constant: 8
            ),
            underlineView.leadingAnchor.constraint(
                equalTo: typeLabel.leadingAnchor
            ),
            underlineView.widthAnchor.constraint(equalToConstant: 60),
            underlineView.heightAnchor.constraint(equalToConstant: 4),
        ])

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(
                equalTo: underlineView.bottomAnchor,
                constant: 16
            ),
            nameLabel.leadingAnchor.constraint(
                equalTo: typeLabel.leadingAnchor
            ),
        ])

        NSLayoutConstraint.activate([
            balanceStackView.topAnchor.constraint(
                equalTo: underlineView.bottomAnchor
            ),
            balanceStackView.leadingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor,
                constant: 4
            ),
            balanceStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -32
            ),
        ])

        NSLayoutConstraint.activate([
            chevronImageView.topAnchor.constraint(
                equalTo: underlineView.bottomAnchor,
                constant: 8
            ),
            chevronImageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -8
            ),
        ])
    }

}
