//
//  LoginViewController.swift
//  Bankey
//
//  Created by Edwin Cardenas on 6/20/25.
//

import UIKit

protocol LoginViewControllerDelegate: NSObjectProtocol {
    func didLogin()
}

protocol LogoutDelegate: NSObjectProtocol {
    func didLogout()
}

class LoginViewController: UIViewController {

    let titleLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        label.text = "Bankey"

        return label
    }()
    let subtitleLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.text = "Your premium source for all things banking!"

        return label
    }()
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

    weak var delegate: LoginViewControllerDelegate?

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

            return
        }

        if username == "Edwin" && password == "Welcome" {
            signInButton.configuration?.showsActivityIndicator = true

            delegate?.didLogin()
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
    }

    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)

        // titleLabel
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(
                equalTo: subtitleLabel.topAnchor,
                constant: -24
            ),
        ])

        // subtitleLabel
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(
                equalTo: loginView.leadingAnchor
            ),
            subtitleLabel.trailingAnchor.constraint(
                equalTo: loginView.trailingAnchor
            ),
            subtitleLabel.bottomAnchor.constraint(
                equalTo: loginView.topAnchor,
                constant: -24
            ),
        ])

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
