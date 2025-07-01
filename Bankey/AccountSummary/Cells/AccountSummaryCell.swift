//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by Edwin Cardenas on 7/1/25.
//

import UIKit

class AccountSummaryCell: UITableViewCell {
    
    let typeLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        label.text = "Account type"
        
        return label
    }()
    
    static let rowHeight: CGFloat = 100

    // MARK: View Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Helpers

extension AccountSummaryCell {

    private func setupViews() {
        contentView.addSubview(typeLabel)
        
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
        ])
    }

}
