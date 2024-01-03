//
//  NameView.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2023-11-06.
//

import UIKit

class NameView: UIView {
    
    private let nameLabel = UILabel(text: "Name")
    private let nameTextField = BrownTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(nameLabel)
        addSubview(nameTextField)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func getNAmeTextFieldText() -> String {
        guard let text = nameTextField.text else { return "" }
        return text
    }
    
    func deleteTextTextfield() {
        nameTextField.text = ""
    }
}

extension NameView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            nameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
