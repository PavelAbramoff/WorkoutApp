//
//  WorkoutTableViewCell.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2023-11-05.
//

import UIKit

protocol WorkoutCellProtocol: AnyObject {
    
    func startButtonTapped(model: WorkouteModel)
}

class WorkoutTableViewCell: UITableViewCell {
    
    weak var workoutCellDelegate: WorkoutCellProtocol?
    
    static let idTableViewCell = "idTableViewCell"
    
    private let backgroundCell: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBrown
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let workoutBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBackground
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let workoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "testWorkout")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let workoutNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Pull Ups"
        label.textColor = .specialBlack
        label.font = .robotoMedium22()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let workoutRapsLabel: UILabel = {
        let label = UILabel()
        label.text = "Reps: 10"
        label.textColor = .specialGray
        label.font = .robotoMedium16()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let workoutSetsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sets: 2"
        label.textColor = .specialGray
        label.font = .robotoMedium16()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.addShadowOnView()
        button.backgroundColor = .specialYellow
        button.titleLabel?.font = .robotoBold16()
        button.setTitle("START", for: .normal)
        button.tintColor = .specialDarkGreen
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var labelStackView = UIStackView()
    
    private var workoutModel = WorkouteModel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(backgroundCell)
        addSubview(workoutBackgroundView)
        workoutBackgroundView.addSubview(workoutImageView)
        addSubview(workoutNameLabel)
        labelStackView = UIStackView(arrangedSubviews: [workoutRapsLabel, workoutSetsLabel], axis: .horizontal,
            spacinng: 10)
        addSubview(labelStackView)
        contentView.addSubview(startButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func startButtonTapped() {
        workoutCellDelegate?.startButtonTapped(model: workoutModel)
    }
    
    func configure(model: WorkouteModel) {
        workoutModel = model
        
        workoutNameLabel.text = model.workoutName
        
        if model
            .workoutTimer == 0 {
            workoutRapsLabel.text = "Reps: \(model.workoutReps)"
        } else {
            workoutRapsLabel.text = "Time: \(model.workoutTimer.getTimeFromSecond())"
            workoutSetsLabel.text = "Sets: \(model.workoutSets)"
        }
        if model.workoutStatus {
            startButton.setTitle("COMPLETE", for: .normal)
            startButton.tintColor = .white
            startButton.backgroundColor = .specialDarkGreen
            startButton.isEnabled = false
        } else {
            startButton.setTitle("START", for: .normal)
            startButton.tintColor = .specialDarkGreen
            startButton.backgroundColor = .specialYellow
            startButton.isEnabled = true
        }
        guard let imageData = model.workoutImage,
              let image = UIImage(data: imageData) else {
            return
        }
        workoutImageView.image = image.withRenderingMode(.alwaysTemplate)
    }
}

extension WorkoutTableViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            workoutBackgroundView.centerYAnchor.constraint(equalTo: backgroundCell.centerYAnchor),
            workoutBackgroundView.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 10),
            workoutBackgroundView.widthAnchor.constraint(equalToConstant: 70),
            workoutBackgroundView.heightAnchor.constraint(equalToConstant: 70),
            
            workoutImageView.topAnchor.constraint(equalTo: workoutBackgroundView.topAnchor, constant: 10),
            workoutImageView.leadingAnchor.constraint(equalTo: workoutBackgroundView.leadingAnchor, constant: 10),
            workoutImageView.trailingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: -10),
            workoutImageView.bottomAnchor.constraint(equalTo: workoutBackgroundView.bottomAnchor,constant: -10),
            
            workoutNameLabel.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 5),
            workoutNameLabel.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
            workoutNameLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor,constant: -10),
            
            labelStackView.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor,constant: 10),
            labelStackView.heightAnchor.constraint(equalToConstant: 20),
            
            startButton.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 5),
            startButton.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
            startButton.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            startButton.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
}
