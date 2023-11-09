//
//  RepsOrTimerView.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2023-11-08.
//

import UIKit

class RepsOrTimerView: UIView {
    
    private let repsOrTimerLabel = UILabel(text: "Reps or tiimer")
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBrown
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let setsView = SliderView(name: "Sets", maxValue: 10)
    private let repsView = SliderView(name: "Reps", maxValue: 50)
    private let timerView = SliderView(name: "Timer", maxValue: 600)
    
    private let repeatOrTimeLabel = UILabel(text: "Choose repeat or timer")
    
    private lazy var stackView = UIStackView(arrangedSubviews: [setsView,
                                                                repeatOrTimeLabel,
                                                                repsView,
                                                                timerView],
                                             axis: .vertical,
                                             spacinng: 20)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        repeatOrTimeLabel.textAlignment = .center
        
        addSubview(repsOrTimerLabel)
        addSubview(backView)
        backView.addSubview(stackView)
    }
}

extension RepsOrTimerView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            repsOrTimerLabel.topAnchor.constraint(equalTo: topAnchor),
            repsOrTimerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            repsOrTimerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            
            backView.topAnchor.constraint(equalTo: repsOrTimerLabel.bottomAnchor, constant: 3),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -15)
        ])
    }
}
