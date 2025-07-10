//
//  SkeletonLoadable.swift
//  Bankey
//
//  Created by Edwin Cardenas on 7/9/25.
//

import UIKit

protocol SkeletonLoadable {
}

extension SkeletonLoadable {

    func makeAnimationGroup(previousGroup: CAAnimationGroup? = nil)
        -> CAAnimationGroup
    {
        let animationDuration: CFTimeInterval = 1.5

        let animation1 = CABasicAnimation(
            keyPath: #keyPath(CAGradientLayer.backgroundColor)
        )
        animation1.fromValue = UIColor.systemGray4.cgColor
        animation1.toValue = UIColor.systemGray.cgColor
        animation1.duration = animationDuration
        animation1.beginTime = 0.0

        let animation2 = CABasicAnimation(
            keyPath: #keyPath(CAGradientLayer.backgroundColor)
        )
        animation2.fromValue = UIColor.systemGray.cgColor
        animation2.toValue = UIColor.systemGray4.cgColor
        animation2.duration = animationDuration
        animation2.beginTime = animation1.beginTime + animation1.duration

        let group = CAAnimationGroup()
        group.animations = [animation1, animation2]
        group.repeatCount = .greatestFiniteMagnitude
        group.duration = animation2.beginTime + animation2.duration
        group.isRemovedOnCompletion = false

        if let previousGroup = previousGroup {
            group.beginTime = previousGroup.beginTime + 0.33
        }

        return group
    }

}
