//
//  LoginView.swift
//  Bankey
//
//  Created by Edwin Cardenas on 6/20/25.
//

import UIKit

class LoginView: UIView {

    lazy var usernameTextField: UITextField = {
        let textField = UITextField()

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "username"
        textField.keyboardType = .asciiCapable
        textField.delegate = self

        return textField
    }()

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
        addSubview(usernameTextField)

        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 8
            ),
            usernameTextField.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 8
            ),
            usernameTextField.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -8
            ),
        ])
    }
}

// MARK: - UITextFieldDelegate

extension LoginView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.endEditing(true)

        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            return false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

    }
}
