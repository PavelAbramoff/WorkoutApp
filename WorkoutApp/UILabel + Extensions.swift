//
//  UILabel + Extensions.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2023-11-05.
//

import UIKit

extension UILabel {
    convenience init(text: String) {
        self.init()
        self.text = text
        self.font = .robotoMedium14()
        self.textColor = .specialLightBrown
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.8
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
