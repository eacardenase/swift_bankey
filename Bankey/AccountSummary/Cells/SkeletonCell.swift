//
//  SkeletonCell.swift
//  Bankey
//
//  Created by Edwin Cardenas on 7/9/25.
//

import UIKit

class SkeletonCell: UITableViewCell {

    let typeLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.text = "           "
        label.font = .preferredFont(forTextStyle: .caption1)

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
        label.adjustsFontForContentSizeCategory = true
        label.text = repeatElement(" ", count: 10).joined()
        label.font = .preferredFont(forTextStyle: .body)

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

        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.text = "-Some balance-"
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .right

        return label
    }()
    let balanceAmountLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.text = "-XXX,XXX.XX-"

        return label
    }()

    let chevronImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = appColor
        imageView.image = UIImage(systemName: "chevron.right")

        return imageView
    }()

    // MARK: - Gradients

    let typeLayer = CAGradientLayer()
    let nameLayer = CAGradientLayer()
    let balanceLayer = CAGradientLayer()
    let balanceAmountLayer = CAGradientLayer()

    static let rowHeight: CGFloat = 112

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupLayers()
        setupAnimation()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()

        typeLayer.frame = typeLabel.bounds
        typeLayer.cornerRadius = typeLabel.bounds.height / 2

        nameLayer.frame = nameLabel.bounds
        nameLayer.cornerRadius = nameLabel.bounds.height / 2

        balanceLayer.frame = balanceLabel.bounds
        balanceLayer.cornerRadius = balanceLabel.bounds.height / 2

        balanceAmountLayer.frame = balanceAmountLabel.bounds
        balanceAmountLayer.cornerRadius = balanceAmountLabel.bounds.height / 2
    }

}

// MARK: - SkeletonLoadable

extension SkeletonCell: SkeletonLoadable {
}

// MARK: - Helpers

extension SkeletonCell {

    private func setupViews() {
        contentView.addSubview(typeLabel)
        contentView.addSubview(underlineView)
        contentView.addSubview(nameLabel)

        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)

        contentView.addSubview(balanceStackView)
        contentView.addSubview(chevronImageView)

        // typeLabel
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

        // underlineView
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

        // nameLabel
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(
                equalTo: underlineView.bottomAnchor,
                constant: 16
            ),
            nameLabel.leadingAnchor.constraint(
                equalTo: typeLabel.leadingAnchor
            ),
        ])

        // balanceStackView
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

        // chevronImageView
        NSLayoutConstraint.activate([
            chevronImageView.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            chevronImageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -8
            ),
        ])
    }

    private func setupLayers() {
        typeLayer.startPoint = CGPoint(x: 0, y: 0.5)
        typeLayer.endPoint = CGPoint(x: 1, y: 0.5)
        typeLabel.layer.addSublayer(typeLayer)

        nameLayer.startPoint = CGPoint(x: 0, y: 0.5)
        nameLayer.endPoint = CGPoint(x: 1, y: 0.5)
        nameLabel.layer.addSublayer(nameLayer)

        balanceLayer.startPoint = CGPoint(x: 0, y: 0.5)
        balanceLayer.endPoint = CGPoint(x: 1, y: 0.5)
        balanceLabel.layer.addSublayer(balanceLayer)

        balanceAmountLayer.startPoint = CGPoint(x: 0, y: 0.5)
        balanceAmountLayer.endPoint = CGPoint(x: 1, y: 0.5)
        balanceAmountLabel.layer.addSublayer(balanceAmountLayer)
    }

    private func setupAnimation() {
        let typeGroup = makeAnimationGroup()
        //        typeGroup.beginTime = 0.0
        typeLayer.add(typeGroup, forKey: "backgroundColor")

        let nameGroup = makeAnimationGroup(previousGroup: typeGroup)
        nameLayer.add(nameGroup, forKey: "backgroundColor")

        let balanceGroup = makeAnimationGroup(previousGroup: nameGroup)
        balanceLayer.add(balanceGroup, forKey: "backgroundColor")

        let balanceAmountGroup = makeAnimationGroup(previousGroup: balanceGroup)
        balanceAmountLayer.add(balanceAmountGroup, forKey: "backgroundColor")
    }

}
