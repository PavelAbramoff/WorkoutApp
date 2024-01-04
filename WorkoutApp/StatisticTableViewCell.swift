//
//  StatisticTableViewCell.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2023-11-05.
//

import UIKit

class StatisticTableViewCell: UITableViewCell {
    
    let differenceLabel: UILabel = {
        let label = UILabel()
        label.text = "+2"
        label.font = .robotoMedium24()
        label.textColor = .specialGreen
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Biceps"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let beforeLabel = UILabel(text: "Before: 18")
    private let nowLabel = UILabel(text: "Now: 20")
    
    private lazy var repsSeteStackView = UIStackView(arrangedSubviews: [beforeLabel, nowLabel],
                                                     axis: .horizontal,
                                                     spacinng: 10)
    
    private lazy var labelsStackView = UIStackView(arrangedSubviews: [nameLabel, repsSeteStackView],
                                                   axis: .vertical,
                                                   spacinng: 2)
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConsstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        repsSeteStackView.distribution = .fillEqually
        addSubview(differenceLabel)
        addSubview(nameLabel)
        addSubview(labelsStackView)
        addSubview(lineView)
    }
    
    func configure(differencrModel: DifferenceWorkout) {
        nameLabel.text = differencrModel.name
        beforeLabel.text = "Before: \(differencrModel.firstReps)"
        nowLabel.text = "Now: \(differencrModel.lastReps)"
        
        let difference = differencrModel.lastReps - differencrModel.firstReps
        differenceLabel.text = "\(difference)"
        
        switch difference {
        case ..<0: differenceLabel.textColor = .specialGreen
        case 1...: differenceLabel.textColor = .specialDarkYellow
        default:
            differenceLabel.textColor = .specialGray
        }
    }
}

extension StatisticTableViewCell {
    private func setConsstraints() {
        NSLayoutConstraint.activate([
            differenceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            differenceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            differenceLabel.widthAnchor.constraint(equalToConstant: 60),
            
            labelsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            labelsStackView.trailingAnchor.constraint(lessThanOrEqualTo: differenceLabel.leadingAnchor, constant: -10),
            
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: 0),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
