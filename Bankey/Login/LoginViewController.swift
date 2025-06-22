//
//  LoginViewController.swift
//  Bankey
//
//  Created by Edwin Cardenas on 6/20/25.
//

import UIKit

class LoginViewController: UIViewController {

    let loginView = LoginView()
    lazy var signInButton: UIButton = {
        let button = UIButton(configuration: .filled())

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign In", for: .normal)
        button.configuration?.imagePadding = 8
        button.addTarget(
            self,
            action: #selector(signInTapped),
            for: .touchUpInside
        )

        return button
    }()
    let errorMessageLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemRed
        label.numberOfLines = 0
        label.isHidden = true

        return label
    }()

    var username: String? {
        return loginView.usernameTextField.text
    }

    var password: String? {
        return loginView.passwordTextField.text
    }

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        layout()
    }

}

// MARK: - Helpers

extension LoginViewController {

    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }

    private func login() {
        guard let username = username, let password = password else {
            fatalError("Username / password should never be nil.")
        }

        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be blank")
        }
    }

    private func layout() {
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)

        // loginView
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(
                equalToSystemSpacingAfter: view.leadingAnchor,
                multiplier: 1
            ),
            view.trailingAnchor.constraint(
                equalToSystemSpacingAfter: loginView.trailingAnchor,
                multiplier: 1
            ),
        ])

        // loginButton
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(
                equalTo: loginView.bottomAnchor,
                constant: 16
            ),
            signInButton.leadingAnchor.constraint(
                equalTo: loginView.leadingAnchor
            ),
            signInButton.trailingAnchor.constraint(
                equalTo: loginView.trailingAnchor
            ),
        ])

        // errorMessageLabel
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(
                equalTo: signInButton.bottomAnchor,
                constant: 16
            ),
            errorMessageLabel.leadingAnchor.constraint(
                equalTo: loginView.leadingAnchor
            ),
            errorMessageLabel.trailingAnchor.constraint(
                equalTo: loginView.trailingAnchor
            ),
        ])
    }
}

// MARK: - Actions

extension LoginViewController {

    @objc func signInTapped(_ sender: UIButton) {
        errorMessageLabel.isHidden = true

        login()
    }
}
