//
//  DataAndRepeatView.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2023-11-07.
//

import UIKit

class DataAndRepeatView: UIView {
    
    private let dateAndRepeatLabel = UILabel(text: "Date and repeat")
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBrown
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    private let dateLabel = UILabel(text: "Date",
                                    font: .robotoMedium18(),
                                    textColor: .specialGray)
    
    private let repeatLabel = UILabel(text: "Repeat every 7 days",
                                      font: .robotoMedium18(),
                                      textColor: .specialGray)
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.tintColor = .specialGreen
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private let repeatSwitch: UISwitch = {
        let repeatSwitch = UISwitch()
        repeatSwitch.isOn = true
        repeatSwitch.onTintColor = .specialGreen
        repeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        return repeatSwitch
    }()
    
    private lazy var dateStackView = UIStackView(arrangedSubviews: [dateLabel, datePicker],
                                                     axis: .horizontal,
                                                     spacinng: 10)
    private lazy var repeatStackView = UIStackView(arrangedSubviews: [repeatLabel, repeatSwitch],
                                                     axis: .horizontal,
                                                     spacinng: 10)
    
    private lazy var unitStackView = UIStackView(arrangedSubviews: [dateStackView, repeatStackView],
                                                   axis: .vertical,
                                                   spacinng: 10)
    
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
        dateStackView.distribution = .equalSpacing
        repeatStackView.distribution = .equalSpacing
        
        addSubview(dateAndRepeatLabel)
        addSubview(backView)
        addSubview(unitStackView)

    }
}

extension DataAndRepeatView {
    private func setConstraints() {
        //dateandRepearStackView.backgroundColor = .blue
        NSLayoutConstraint.activate([
            dateAndRepeatLabel.topAnchor.constraint(equalTo: topAnchor),
            dateAndRepeatLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            dateAndRepeatLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            backView.topAnchor.constraint(equalTo: dateAndRepeatLabel.bottomAnchor, constant: 3),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            unitStackView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            unitStackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            unitStackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
            
        ])
    }
}
