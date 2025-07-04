//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Edwin Cardenas on 6/28/25.
//

import UIKit

class AccountSummaryViewController: UIViewController {

    var accounts = [AccountSummaryCell.ViewModel]()

    let headerView = AccountSummaryHeaderView(frame: .zero)

    let tableView = UITableView()

    lazy var logoutButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(logoutTapped)
        )

        button.tintColor = .label

        return button
    }()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = AccountSummaryCell.rowHeight
        tableView.register(
            AccountSummaryCell.self,
            forCellReuseIdentifier: NSStringFromClass(AccountSummaryCell.self)
        )

        setup()
    }
}

// MARK: - Helpers

extension AccountSummaryViewController {

    private func setup() {
        setupTableView()
        setupTableHeaderView()
        setupNavigationBar()
        fetchData()
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
        tableView.backgroundColor = appColor

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

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = logoutButton
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
        return accounts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        guard !accounts.isEmpty else { return UITableViewCell() }

        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: NSStringFromClass(AccountSummaryCell.self),
                for: indexPath
            ) as? AccountSummaryCell
        else {
            fatalError("Error typecasting AccountSummaryCell")
        }

        let account = accounts[indexPath.row]

        cell.configure(with: account)

        return cell
    }
}

// MARK: - Networking

extension AccountSummaryViewController {
    private func fetchData() {
        let savings = AccountSummaryCell.ViewModel(
            accountType: .Banking,
            accountName: "Basic Savings",
            balance: 929466.23
        )
        let chequing = AccountSummaryCell.ViewModel(
            accountType: .Banking,
            accountName: "No-Fee All-In Chequing",
            balance: 17562.44
        )
        let visa = AccountSummaryCell.ViewModel(
            accountType: .CreditCard,
            accountName: "Visa Avion Card",
            balance: 412.83
        )
        let masterCard = AccountSummaryCell.ViewModel(
            accountType: .CreditCard,
            accountName: "Student Mastercard",
            balance: 50.83
        )
        let investment1 = AccountSummaryCell.ViewModel(
            accountType: .Investment,
            accountName: "Tax-Free Saver",
            balance: 2000.00
        )
        let investment2 = AccountSummaryCell.ViewModel(
            accountType: .Investment,
            accountName: "Growth Fund",
            balance: 15000.00
        )

        accounts.append(savings)
        accounts.append(chequing)
        accounts.append(visa)
        accounts.append(masterCard)
        accounts.append(investment1)
        accounts.append(investment2)
    }
}

// MARK: - Actions

extension AccountSummaryViewController {

    @objc func logoutTapped(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: .logout, object: nil)
    }

}
