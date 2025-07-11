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
        label.alpha = 0

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
        label.alpha = 0

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

    // MARK: - Animation Variables

    var leadingEdgeOnScreen: CGFloat = 16
    var leadingEdgeOffScreen: CGFloat = -1000

    var titleLeadingAnchor: NSLayoutConstraint?
    var subtitleLeadingAnchor: NSLayoutConstraint?

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        layout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        animate()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        signInButton.configuration?.showsActivityIndicator = false
        loginView.usernameTextField.text = ""
        loginView.passwordTextField.text = ""
    }

}

// MARK: - Helpers

extension LoginViewController {

    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message

        shakeButton()
    }

    private func login() {
        guard let username = username, let password = password else {
            fatalError("Username / password should never be nil.")
        }

//        if username.isEmpty || password.isEmpty {
//            configureView(withMessage: "Username / password cannot be blank")
//
//            return
//        }

        if username == "" && password == "" {
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
            titleLabel.trailingAnchor.constraint(
                equalTo: loginView.trailingAnchor
            ),
            titleLabel.bottomAnchor.constraint(
                equalTo: subtitleLabel.topAnchor,
                constant: -24
            ),
        ])

        titleLeadingAnchor = titleLabel.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: leadingEdgeOffScreen
        )

        titleLeadingAnchor?.isActive = true

        // subtitleLabel
        NSLayoutConstraint.activate([
            subtitleLabel.trailingAnchor.constraint(
                equalTo: loginView.trailingAnchor
            ),
            subtitleLabel.bottomAnchor.constraint(
                equalTo: loginView.topAnchor,
                constant: -24
            ),
        ])

        subtitleLeadingAnchor = subtitleLabel.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: leadingEdgeOffScreen
        )

        subtitleLeadingAnchor?.isActive = true

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

// MARK: - Animations

extension LoginViewController {

    private func animate() {
        let duration = 0.75

        let animator1 = UIViewPropertyAnimator(
            duration: duration,
            curve: .easeInOut
        ) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen

            self.view.layoutIfNeeded()
        }

        let animator2 = UIViewPropertyAnimator(
            duration: duration,
            curve: .easeInOut
        ) {
            self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen

            self.view.layoutIfNeeded()
        }

        let animator3 = UIViewPropertyAnimator(
            duration: duration * 2,
            curve: .easeInOut
        ) {
            self.titleLabel.alpha = 1
            self.subtitleLabel.alpha = 1

            self.view.layoutIfNeeded()
        }

        animator1.startAnimation()
        animator2.startAnimation(afterDelay: 0.5)
        animator3.startAnimation(afterDelay: 0.5)
    }

    private func shakeButton() {
        let animation = CAKeyframeAnimation(keyPath: "position.x")

        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4
        animation.isAdditive = true

        signInButton.layer.add(animation, forKey: "shake")
    }

}
