//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Edwin Cardenas on 6/28/25.
//

import UIKit

class AccountSummaryViewController: UITableViewController {

    let games = [
        "Pacman",
        "Space Invaders",
        "Space Patrol",
    ]

    lazy var headerView = AccountSummaryHeaderView(
        frame: CGRect(x: 0, y: 0, width: 0, height: 144)
    )

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableHeaderView = headerView
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self)
        )
    }
}

// MARK: - Helpers

extension AccountSummaryViewController {

}

// MARK: - UITableViewDelegate

extension AccountSummaryViewController {

}

// MARK: - UITableViewDataSource

extension AccountSummaryViewController {

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    )
        -> Int
    {
        return games.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    )
        -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: NSStringFromClass(UITableViewCell.self),
            for: indexPath
        )

        cell.textLabel?.text = games[indexPath.row]
        cell.selectionStyle = .none

        return cell
    }
}
