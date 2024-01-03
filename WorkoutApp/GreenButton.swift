//
//  GreenButton.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2023-11-08.
//

import UIKit

class GreenButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String) {
        self.init(type: .system)
        setTitle(text, for: .normal)
        
        configuure()
    }
    
    private func configuure() {
        backgroundColor = .specialGreen
        layer.cornerRadius = 10
        titleLabel?.font = .robotoBold16()
        tintColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
}
