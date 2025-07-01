//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by Edwin Cardenas on 6/28/25.
//

import UIKit

class AccountSummaryTableHeader: UIView {
    let horizontalStack = UIStackView()
    let verticalUIView = UIView()
    let verticalStack = UIStackView()
    let appNameLabel = UILabel()
    let welcomeLabel = UILabel()
    let nameLabel = UILabel()
    let dateLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Date"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        
        return label
    }()

    let imageView: UIImageView = {
        let _imageView = UIImageView()

        let sfConfig = UIImage.SymbolConfiguration(pointSize: 100)
        let image = UIImage(systemName: "sun.max.fill", withConfiguration: sfConfig)
        _imageView.contentMode = .scaleAspectFit
        _imageView.tintColor = .systemYellow
        _imageView.image = image
        
        return _imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not benn implemented")
    }
}

extension AccountSummaryTableHeader {
    private func style() {
        backgroundColor = .systemCyan
        
        appNameLabel.text = "Bankey"
        appNameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        
        welcomeLabel.text = "Good morning,"
        
        nameLabel.text = "Jonathan"
        
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .top
        horizontalStack.distribution = .fill
        
        verticalStack.axis = .vertical
        verticalStack.spacing = 4
        verticalStack.alignment = .fill
        verticalStack.distribution = .fill
        
        
        
    }
    
    private func layout() {
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalUIView.translatesAutoresizingMaskIntoConstraints = false
        
        verticalStack.addArrangedSubview(appNameLabel)
        verticalStack.addArrangedSubview(welcomeLabel)
        verticalStack.addArrangedSubview(nameLabel)
        verticalStack.addArrangedSubview(dateLabel)
        verticalUIView.addSubview(verticalStack)
        
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: verticalUIView.topAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: verticalUIView.leadingAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: verticalUIView.bottomAnchor),
            
        ])
        
        horizontalStack.addArrangedSubview(verticalUIView)
        horizontalStack.addArrangedSubview(imageView)
        addSubview(horizontalStack)
        
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
