//
//  UITextField+SecureToggle.swift
//  Bankey
//
//  Created by Edwin Cardenas on 7/3/25.
//

import UIKit

let passwordToggleButton = UIButton(type: .custom)

extension UITextField {
    func enablePasswordToggle() {
        passwordToggleButton.setImage(
            UIImage(systemName: "eye.fill"),
            for: .normal
        )

        passwordToggleButton.setImage(
            UIImage(systemName: "eye.slash.fill"),
            for: .selected
        )

        passwordToggleButton.addTarget(
            self,
            action: #selector(togglePasswordView),
            for: .touchUpInside
        )

        rightView = passwordToggleButton
        rightViewMode = .always
    }

    @objc func togglePasswordView(_ sender: UIButton) {
        isSecureTextEntry.toggle()

        passwordToggleButton.isSelected.toggle()
    }
}
