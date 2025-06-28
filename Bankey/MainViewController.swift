//
//  MainViewController.swift
//  Bankey
//
//  Created by Edwin Cardenas on 6/26/25.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupTabBar()
    }
}

// MARK: - Helpers

extension MainViewController {

    private func setupViews() {
        let summaryVC = AccountSummaryViewController()
        let moneyCV = MoveMoneyViewController()
        let moreVC = MoreViewController()

        summaryVC.setTabBarImage(
            imageName: "list.dash.header.rectangle",
            title: "Summary"
        )
        moneyCV.setTabBarImage(
            imageName: "arrow.left.arrow.right",
            title: "Move Money"
        )
        moreVC.setTabBarImage(
            imageName: "ellipsis.circle",
            title: "More"
        )

        let summaryNC = UINavigationController(rootViewController: summaryVC)
        let moneyNC = UINavigationController(rootViewController: moneyCV)
        let moreNC = UINavigationController(rootViewController: moreVC)

        summaryNC.navigationBar.tintColor = appColor

        viewControllers = [summaryNC, moneyNC, moreNC]
    }

    private func setupTabBar() {
        tabBar.tintColor = appColor
        tabBar.isTranslucent = false
    }

}

// MARK: - Dummy View Controllers


class MoveMoneyViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemOrange
    }
}

class MoreViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemPurple
    }
}
