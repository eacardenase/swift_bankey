//
//  LoginView.swift
//  Bankey
//
//  Created by Edwin Cardenas on 6/20/25.
//

import UIKit

class LoginView: UIView {

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        style()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers

extension LoginView {

    private func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemMint
    }

    private func layout() {

    }
}
