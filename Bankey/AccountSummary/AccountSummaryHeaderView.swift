//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by Edwin Cardenas on 6/28/25.
//

import UIKit

class AccountSummaryHeaderView: UIView {

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 144))

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Helpers

extension AccountSummaryHeaderView {

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = appColor
    }

}
