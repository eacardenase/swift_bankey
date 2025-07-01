//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Edwin Cardenas on 6/28/25.
//

import UIKit

class AccountSummaryViewController: UIViewController {

    let games = [
        "Pacman",
        "Space Invaders",
        "Space Patrol",
    ]

    let headerView = AccountSummaryHeaderView(frame: .zero)

    let tableView = UITableView()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.register(
            AccountSummaryCell.self,
            forCellReuseIdentifier: NSStringFromClass(AccountSummaryCell.self)
        )

        setupViews()
    }
}

// MARK: - Helpers

extension AccountSummaryViewController {

    private func setupViews() {
        setupTableView()
        setupTableHeaderView()
    }

    private func setupTableHeaderView() {
        var size = headerView.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize
        )

        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size

        tableView.tableHeaderView = headerView
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            tableView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            tableView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),
            tableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
        ])
    }
}

// MARK: - UITableViewDelegate

extension AccountSummaryViewController: UITableViewDelegate {

}

// MARK: - UITableViewDataSource

extension AccountSummaryViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return games.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NSStringFromClass(AccountSummaryCell.self),
            for: indexPath
        ) as? AccountSummaryCell else {
            fatalError("Error typecasting AccountSummaryCell")
        }

//        cell.textLabel?.text = games[indexPath.row]
//        cell.selectionStyle = .none

        return cell
    }
}
