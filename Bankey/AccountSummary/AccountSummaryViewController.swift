//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Edwin Cardenas on 6/28/25.
//

import UIKit

class AccountSummaryViewController: UIViewController {

    // MARK: - Request Models

    var profile: Profile?
    var accounts = [Account]()

    // MARK: - View Models

    var headerViewModel = AccountSummaryHeaderView.ViewModel(
        welcomeMessage: "Welcome,",
        name: "Edwin",
        date: .now
    )
    var accountCellViewModels = [AccountSummaryCell.ViewModel]()

    // MARK: - Components

    let headerView = AccountSummaryHeaderView(frame: .zero)
    let refreshControl = UIRefreshControl()
    let tableView = UITableView()

    // MARK: - Networking

    var profileManager: ProfileManageable = ProfileManager()
    var accountManager: AccountManageable = AccountManager()

    // MARK: - Alert Controller

    let alertController: UIAlertController = {
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        return alert
    }()

    var isLoaded = false

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
        tableView.register(
            SkeletonCell.self,
            forCellReuseIdentifier: NSStringFromClass(SkeletonCell.self)
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
        setupRefreshControl()
        setupSkeletons()
        fetchData()
    }

    private func setupTableHeaderView() {
        var size = headerView.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize
        )

        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        headerView.configure(with: headerViewModel)

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

    private func configureTableHeaderView(with profile: Profile) {
        let viewModel = AccountSummaryHeaderView.ViewModel(
            welcomeMessage: "Good Morning,",
            name: profile.firstName,
            date: .now
        )

        headerView.configure(with: viewModel)
    }

    private func configureTableCells(with accounts: [Account]) {
        accountCellViewModels = accounts.map {
            AccountSummaryCell.ViewModel(
                accountType: $0.type,
                accountName: $0.name,
                balance: $0.amount
            )
        }
    }

    private func setupRefreshControl() {
        refreshControl.tintColor = appColor
        refreshControl.addTarget(
            self,
            action: #selector(refreshContent),
            for: .valueChanged
        )
        tableView.refreshControl = refreshControl
    }

    private func setupSkeletons() {
        let skeletonAccount = Account.makeSkeleton()

        accounts = Array(repeating: skeletonAccount, count: 10)

        configureTableCells(with: accounts)
    }

    private func reset() {
        profile = nil
        accounts = []
        isLoaded = false
    }

    private func titleAndMessage(for error: NetworkError) -> (
        title: String, message: String
    ) {
        let title: String
        let message: String

        switch error {
        case .serverError:
            title = "Server Error"
            message =
                "Ensure you are connected to the Internet. Please try again."
        case .decodingError:
            title = "Decoding Error"
            message =
                "We could not process your request. Please try again."
        }

        return (title, message)
    }

    private func displayError(_ error: NetworkError) {
        let titleAndMessage = titleAndMessage(for: error)

        self.showErrorAlert(
            withTitle: titleAndMessage.title,
            message: titleAndMessage.message
        )
    }

    private func showErrorAlert(withTitle title: String, message: String) {
        alertController.title = title
        alertController.message = message

        present(alertController, animated: true)
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
        return accountCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        guard !accountCellViewModels.isEmpty else { return UITableViewCell() }
        let account = accountCellViewModels[indexPath.row]

        if !isLoaded {
            let skeletonCell = tableView.dequeueReusableCell(
                withIdentifier: NSStringFromClass(SkeletonCell.self),
                for: indexPath
            )

            return skeletonCell
        }

        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: NSStringFromClass(AccountSummaryCell.self),
                for: indexPath
            ) as? AccountSummaryCell
        else {
            fatalError("Error typecasting AccountSummaryCell")
        }

        cell.configure(with: account)

        return cell
    }
}

// MARK: - Networking

extension AccountSummaryViewController {

    private func fetchData() {
        let userId = String(Int.random(in: 1...3))
        let group = DispatchGroup()

        fetchProfile(group: group, userId: userId)
        fetchAccounts(group: group, userId: userId)

        group.notify(queue: .main) {
            self.reloadView()
        }
    }

    private func fetchProfile(group: DispatchGroup, userId: String) {
        group.enter()

        profileManager.fetchProfile(forUserId: String(userId)) { result in
            switch result {
            case let .success(profile):
                self.profile = profile
            case let .failure(error):
                self.displayError(error)
            }

            group.leave()
        }
    }

    private func fetchAccounts(group: DispatchGroup, userId: String) {
        group.enter()

        accountManager.fetchAccounts(forUserId: String(userId)) { result in
            switch result {
            case let .success(accounts):
                self.accounts = accounts
            case let .failure(error):
                self.displayError(error)
            }

            group.leave()
        }
    }

    private func reloadView() {
        tableView.refreshControl?.endRefreshing()

        guard let profile = self.profile else { return }

        isLoaded = true
        configureTableHeaderView(with: profile)
        configureTableCells(with: self.accounts)
        tableView.reloadData()
    }
}

// MARK: - Actions

extension AccountSummaryViewController {

    @objc func logoutTapped(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: .logout, object: nil)
    }

    @objc func refreshContent(_ sender: UIRefreshControl) {
        reset()
        setupSkeletons()
        tableView.reloadData()
        fetchData()
    }

}

// MARK: - Unit Testing

extension AccountSummaryViewController {

    func titleAndMessageForTesting(for error: NetworkError) -> (
        title: String, message: String
    ) {
        return titleAndMessage(for: error)
    }

    func fetchProfileForTesting() {
        fetchProfile(group: DispatchGroup(), userId: "1")
    }

}
