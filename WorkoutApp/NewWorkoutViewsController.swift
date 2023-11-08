//
//  NewWorkoutViewsController.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2023-11-05.
//

import UIKit

class NewWorkoutViewsController: UIViewController {
    
    private let newWorkoutLabel = UILabel(text: "NEW WORKOUT",
                                          font: .robotoMedium24(),
                                          textColor: .specialGray)
    
    private lazy var closeButton = CloseButton(type: .system)
    private let nameView = NameView()
    private let dateAndRepearView = DataAndRepeatView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        newWorkoutLabel.textAlignment = .center
        view.addSubview(newWorkoutLabel)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        view.addSubview(closeButton)
        view.addSubview(nameView)
        view.addSubview(dateAndRepearView)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: SetConstraints

extension NewWorkoutViewsController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            newWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            newWorkoutLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newWorkoutLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            closeButton.centerYAnchor.constraint(equalTo: newWorkoutLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 33),
            closeButton.heightAnchor.constraint(equalToConstant: 33),
            
            nameView.topAnchor.constraint(equalTo: newWorkoutLabel.bottomAnchor,constant: 10),
            nameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            nameView.heightAnchor.constraint(equalToConstant: 60),
            
            dateAndRepearView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 10),
            dateAndRepearView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dateAndRepearView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            dateAndRepearView.heightAnchor.constraint(equalToConstant: 110),
            
        ])
    }
}
