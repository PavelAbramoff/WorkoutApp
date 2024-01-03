//
//  UIStackView + Extancsons.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2023-11-05.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacinng: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacinng
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
