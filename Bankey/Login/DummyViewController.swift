//
//  DummyViewController.swift
//  Bankey
//
//  Created by Edwin Cardenas on 6/26/25.
//

import UIKit

class DummyViewController: UIViewController {

    lazy var logoutButton: UIButton = {
        let button = UIButton(configuration: .filled())

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Logout", for: .normal)
        button.addTarget(
            self,
            action: #selector(logoutButtonTapped),
            for: .touchUpInside
        )

        return button
    }()
    
    weak var delegate: LogoutDelegate?

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
}

extension DummyViewController {

    private func setupViews() {
        view.backgroundColor = .systemBackground

        view.addSubview(logoutButton)

        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

}

extension DummyViewController {

    @objc func logoutButtonTapped(_ sender: UIButton) {
        delegate?.didLogout()
    }

}
