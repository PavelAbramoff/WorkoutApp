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
    
    var (sets, reps, timer) = (0, 0, 0)
    
    private let setsView = SliderView(name: "Sets", maxValue: 10, type: .sets)
    private let repsView = SliderView(name: "Reps", maxValue: 50, type: .reps)
    private let timerView = SliderView(name: "Timer", maxValue: 600, type: .timer)
    
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
        setDelegate()
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
    
    private func setDelegate() {
        setsView.delegate = self
        repsView.delegate = self
        timerView.delegate = self
    }
    
    func resetSliderViewValues() {
        setsView.resetValues()
        repsView.resetValues()
        timerView.resetValues()
    }
}

extension RepsOrTimerView: SliderViewProtocol {
    func changeValue(type: SliderType, value: Int) {
        switch type {
            
        case .sets:
            sets = value
        case .reps:
            reps = value
            repsView.isActive = true
            timerView.isActive = false
            timer = 0
        case .timer:
            timer = value
            timerView.isActive = true
            repsView.isActive = false
            reps = 0
        }
    }
}

// MARK: - Set Constraints

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
