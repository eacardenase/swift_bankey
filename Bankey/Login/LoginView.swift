//
//  LoginView.swift
//  Bankey
//
//  Created by Edwin Cardenas on 6/20/25.
//

import UIKit

class LoginView: UIView {

    let stackView: UIStackView = {
        let stackView = UIStackView()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8

        return stackView
    }()

    lazy var usernameTextField: UITextField = {
        let textField = UITextField()

        textField.placeholder = "Username"
        textField.keyboardType = .asciiCapable
        textField.delegate = self

        return textField
    }()

    let dividerView: UIView = {
        let view = UIView()

        view.backgroundColor = .secondarySystemFill
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true

        return view
    }()

    lazy var passwordTextField: UITextField = {
        let textField = UITextField()

        textField.placeholder = "Password"
        textField.keyboardType = .asciiCapable
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.enablePasswordToggle()

        return textField
    }()

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
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 8
    }

    private func layout() {
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(passwordTextField)

        addSubview(stackView)

        // stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 8
            ),
            stackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 8
            ),
            stackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -8
            ),
            stackView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -8
            ),
        ])
    }
}

// MARK: - UITextFieldDelegate

extension LoginView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)

        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

    }
}
