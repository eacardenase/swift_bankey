//
//  LoginViewController.swift
//  Bankey
//
//  Created by Edwin Cardenas on 6/20/25.
//

import UIKit

class LoginViewController: UIViewController {

    let loginView = LoginView()

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        style()
        layout()
    }

}

// MARK: - Helpers

extension LoginViewController {

    private func style() {

    }

    private func layout() {
        view.addSubview(loginView)

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
    }
}
