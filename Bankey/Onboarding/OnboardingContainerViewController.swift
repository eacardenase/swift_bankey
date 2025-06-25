//
//  OnboardingContainerViewController.swift
//  Bankey
//
//  Created by Edwin Cardenas on 6/24/25.
//

import UIKit

class OnboardingContainerViewController: UIViewController {
    lazy var pageViewController: UIPageViewController = {
        let pageVC = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )

        pageVC.view.translatesAutoresizingMaskIntoConstraints = false

        return pageVC
    }()
    var pages = [UIViewController]()
    var currentViewController: UIViewController {
        didSet {
            //
        }
    }

    // MARK: - Initializers

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        let page1 = ViewController1()
        let page2 = ViewController2()
        let page3 = ViewController3()

        pages.append(contentsOf: [
            page1, page2, page3,
        ])

        currentViewController = pages.first!

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
}

// MARK: - Helpers

extension OnboardingContainerViewController {

    private func setupViews() {
        view.backgroundColor = .systemPurple

        pageViewController.dataSource = self

        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)

        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            pageViewController.view.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            pageViewController.view.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            pageViewController.view.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
        ])

        pageViewController.setViewControllers(
            [pages.first!],
            direction: .forward,
            animated: false
        )
        currentViewController = pages.first!
    }
}

// MARK: - UIPageViewControllerDataSource

extension OnboardingContainerViewController: UIPageViewControllerDataSource {

    func presentationCount(for pageViewController: UIPageViewController) -> Int
    {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int
    {
        return pages.firstIndex(of: currentViewController.self) ?? 0
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    private func getPreviousViewController(
        from viewController: UIViewController
    ) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0
        else { return nil }

        currentViewController = pages[index - 1]

        return currentViewController
    }

    private func getNextViewController(from viewController: UIViewController)
        -> UIViewController?
    {
        guard let index = pages.firstIndex(of: viewController),
            index + 1 < pages.count
        else { return nil }

        currentViewController = pages[index + 1]

        return currentViewController
    }

}

// MARK: - ViewControllers

class ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemRed
    }

}

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGreen
    }

}

class ViewController3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue
    }

}
