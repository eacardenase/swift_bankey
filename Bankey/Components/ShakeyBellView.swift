//
//  ShakeyBellView.swift
//  Bankey
//
//  Created by Edwin Cardenas on 7/5/25.
//

import UIKit

class ShakeyBellView: UIView {

    let imageView: UIImageView = {
        let _imageView = UIImageView()

        _imageView.translatesAutoresizingMaskIntoConstraints = false
        _imageView.image = UIImage(systemName: "bell.fill")
        _imageView.tintColor = .white

        return _imageView
    }()

    lazy var buttomView: UIButton = {
        let buttom = UIButton()

        buttom.translatesAutoresizingMaskIntoConstraints = false
        buttom.setTitle("9", for: .normal)
        buttom.setTitleColor(.white, for: .normal)
        buttom.titleLabel?.font = .systemFont(ofSize: 13)
        buttom.backgroundColor = .systemRed
        buttom.layer.cornerRadius = buttonHeight / 2

        return buttom
    }()

    let buttonHeight: CGFloat = 16

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()

        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(imageViewTapped)
        )

        addGestureRecognizer(tapGestureRecognizer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 48, height: 48)
    }
}

// MARK: - Helpers

extension ShakeyBellView {

    private func setupViews() {
        addSubview(imageView)
        addSubview(buttomView)

        // imageView
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
        ])

        // buttomView
        NSLayoutConstraint.activate([
            buttomView.topAnchor.constraint(equalTo: imageView.topAnchor),
            buttomView.leadingAnchor.constraint(
                equalTo: imageView.trailingAnchor,
                constant: -9
            ),
            buttomView.heightAnchor.constraint(equalToConstant: buttonHeight),
            buttomView.widthAnchor.constraint(equalTo: buttomView.heightAnchor),
        ])
    }

}

// MARK: - Actions

extension ShakeyBellView {

    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        shakeWith(duration: 1, angle: .pi / 8, yOffset: 0)
    }

    private func shakeWith(duration: Double, angle: CGFloat, yOffset: CGFloat) {
        let numberOfFrames: Double = 6
        let frameDuration = 1 / numberOfFrames

        imageView.setAnchor(CGPoint(x: 0.5, y: yOffset))

        UIView.animateKeyframes(withDuration: duration, delay: 0) {
            UIView.addKeyframe(
                withRelativeStartTime: 0.0,
                relativeDuration: frameDuration
            ) {
                self.imageView.transform = CGAffineTransform(
                    rotationAngle: -angle
                )
            }
            UIView.addKeyframe(
                withRelativeStartTime: frameDuration,
                relativeDuration: frameDuration
            ) {
                self.imageView.transform = CGAffineTransform(
                    rotationAngle: +angle
                )
            }
            UIView.addKeyframe(
                withRelativeStartTime: frameDuration * 2,
                relativeDuration: frameDuration
            ) {
                self.imageView.transform = CGAffineTransform(
                    rotationAngle: -angle
                )
            }
            UIView.addKeyframe(
                withRelativeStartTime: frameDuration * 3,
                relativeDuration: frameDuration
            ) {
                self.imageView.transform = CGAffineTransform(
                    rotationAngle: +angle
                )
            }
            UIView.addKeyframe(
                withRelativeStartTime: frameDuration * 4,
                relativeDuration: frameDuration
            ) {
                self.imageView.transform = CGAffineTransform(
                    rotationAngle: -angle
                )
            }
            UIView.addKeyframe(
                withRelativeStartTime: frameDuration * 5,
                relativeDuration: frameDuration
            ) {
                self.imageView.transform = CGAffineTransform.identity
            }
        }
    }
}

// MARK: - UIView

extension UIView {

    func setAnchor(_ point: CGPoint) {
        var newPoint = CGPoint(
            x: bounds.size.width * point.x,
            y: bounds.size.height * point.y
        )
        var oldPoint = CGPoint(
            x: bounds.size.width * layer.anchorPoint.x,
            y: bounds.size.height * layer.anchorPoint.y
        )

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }

}
