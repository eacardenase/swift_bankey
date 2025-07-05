//
//  ShakeyBellView.swift
//  Bankey
//
//  Created by Edwin Cardenas on 7/5/25.
//

import UIKit

class ShakeyBellView: UIView {

    let imageView: UIImageView = {
        let _imageView = UIImageView()

        _imageView.translatesAutoresizingMaskIntoConstraints = false
        _imageView.image = UIImage(systemName: "bell.fill")
        _imageView.tintColor = .white

        return _imageView
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()

        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(imageViewTapped)
        )

        addGestureRecognizer(tapGestureRecognizer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 48, height: 48)
    }
}

// MARK: - Helpers

extension ShakeyBellView {

    private func setupViews() {
        addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
        ])
    }

}

// MARK: - Actions

extension ShakeyBellView {

    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        print(#function)
    }
}
