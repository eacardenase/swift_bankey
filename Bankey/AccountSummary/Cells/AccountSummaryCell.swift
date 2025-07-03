//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by Edwin Cardenas on 7/1/25.
//

import UIKit

class AccountSummaryCell: UITableViewCell {

    enum AccountType: String {
        case Banking
        case CreditCard = "Credit Card"
        case Investment
    }

    struct ViewModel {
        let accountType: AccountType
        let accountName: String
        let balance: Decimal

        var balanceAsAttributedString: NSAttributedString {
            return CurrencyFormatter().makeAttributedCurrency(balance)
        }
    }

    private(set) var viewModel: ViewModel?

    let typeLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true

        return label
    }()

    let underlineView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    let nameLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true

        return label
    }()

    let balanceStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8

        return stackView
    }()

    let balanceLabel: UILabel = {
        let label = UILabel()

        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .right

        return label
    }()

    lazy var balanceAmountLabel: UILabel = {
        let label = UILabel()

        label.textAlignment = .right

        return label
    }()

    let chevronImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = appColor
        imageView.image = UIImage(systemName: "chevron.right")

        return imageView
    }()

    static let rowHeight: CGFloat = 112

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
            balanceStackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -16
            ),
        ])

        NSLayoutConstraint.activate([
            chevronImageView.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor,
            ),
            chevronImageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -8
            ),
        ])
    }

    func configure(with viewModel: ViewModel) {
        typeLabel.text = viewModel.accountType.rawValue
        nameLabel.text = viewModel.accountName
        balanceAmountLabel.attributedText = viewModel.balanceAsAttributedString

        switch viewModel.accountType {
        case .Banking:
            underlineView.backgroundColor = appColor
            balanceLabel.text = "Current balance"
        case .CreditCard:
            underlineView.backgroundColor = .systemOrange
            balanceLabel.text = "Balance"
        case .Investment:
            underlineView.backgroundColor = .systemPurple
            balanceLabel.text = "Value"
        }
    }

}
