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

    lazy var headerView = AccountSummaryTableHeader(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 144))

    let tableView = UITableView()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.tableHeaderView = headerView
        headerView.layoutIfNeeded()
    }
}

extension AccountSummaryViewController {
    private func style() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func layout() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
    }
    
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
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
        let cell = tableView.dequeueReusableCell(
            withIdentifier: NSStringFromClass(UITableViewCell.self),
            for: indexPath
        )

        cell.textLabel?.text = games[indexPath.row]
        cell.selectionStyle = .none

        return cell
    }
}
