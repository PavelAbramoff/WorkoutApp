//
//  WorkoutParametrsView.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2024-01-07.
//

import UIKit

protocol NextSetProtocol: AnyObject {
    func nextSetTapped()
    func editingTapped()
}

class WorkoutParametersView: UIView {
    
    weak var cellNextSetDelegate: NextSetProtocol?

    private let workoutNameLabel = UILabel(text: "Name",
                                          font: .robotoMedium24(),
                                          textColor: .specialGray)

    private let setsLabel = UILabel(text: "Sets",
                                          font: .robotoMedium18(),
                                          textColor: .specialGray)
    
    private let numberOfSetsLabel = UILabel(text: "1/4",
                                          font: .robotoMedium24(),
                                          textColor: .specialGray)
    
    private let setsLineView: UIView = {
       let view = UIView()
        view.backgroundColor = .specialLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let repsLabel = UILabel(text: "Reps",
                                          font: .robotoMedium18(),
                                          textColor: .specialGray)
    
    private let numberOfRepsLabel = UILabel(text: "20",
                                          font: .robotoMedium24(),
                                          textColor: .specialGray)

    private let repsLineView: UIView = {
       let view = UIView()
        view.backgroundColor = .specialLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var  editingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "editing")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitle("Editing", for: .normal)
        button.tintColor = .specialLightBrown
        button.titleLabel?.font = .robotoMedium16()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editingButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var  nextSetsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialYellow
        button.layer.cornerRadius = 10
        button.setTitle("NEXT SET", for: .normal)
        button.tintColor = .specialGray
        button.titleLabel?.font = .robotoBold16()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextSetsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var repsStackView = UIStackView(arrangedSubviews: [repsLabel, numberOfRepsLabel],
                                                 axis: .horizontal,
                                                 spacinng: 10)
    
    private lazy var setsStackView = UIStackView(arrangedSubviews: [setsLabel, numberOfSetsLabel],
                                                 axis: .horizontal,
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
        backgroundColor = .specialBrown
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(workoutNameLabel)
        workoutNameLabel.textAlignment = .center
        setsStackView.distribution = .equalSpacing
        addSubview(setsStackView)
        addSubview(setsLineView)
        repsStackView.distribution = .equalSpacing
        addSubview(repsStackView)
        addSubview(repsLineView)
        addSubview(editingButton)
        addSubview(nextSetsButton)
    }
    
    @objc private func editingButtonTapped() {
        cellNextSetDelegate?.editingTapped()
    }
    
    @objc private func nextSetsButtonTapped() {
        cellNextSetDelegate?.nextSetTapped()
    }
    
    func refreshLabels(model: WorkoutModel, numberOfSet: Int) {
        workoutNameLabel.text = model.workoutName
        numberOfSetsLabel.text = "\(numberOfSet)/\(model.workoutSets)"
        numberOfRepsLabel.text = "\(model.workoutReps)"
    }

    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            workoutNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            workoutNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            workoutNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            setsStackView.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: 10),
            setsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            setsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            setsStackView.heightAnchor.constraint(equalToConstant: 25),

            setsLineView.topAnchor.constraint(equalTo: setsStackView.bottomAnchor, constant: 2),
            setsLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            setsLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            setsLineView.heightAnchor.constraint(equalToConstant: 1),
   
            repsStackView.topAnchor.constraint(equalTo: setsLineView.bottomAnchor, constant: 20),
            repsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            repsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            repsStackView.heightAnchor.constraint(equalToConstant: 25),
 
            repsLineView.topAnchor.constraint(equalTo: repsStackView.bottomAnchor, constant: 2),
            repsLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            repsLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            repsLineView.heightAnchor.constraint(equalToConstant: 1),
   
            editingButton.topAnchor.constraint(equalTo: repsLineView.bottomAnchor, constant: 10),
            editingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            editingButton.heightAnchor.constraint(equalToConstant: 20),
            editingButton.widthAnchor.constraint(equalToConstant: 80),
 
            nextSetsButton.topAnchor.constraint(equalTo: editingButton.bottomAnchor, constant: 10),
            nextSetsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextSetsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nextSetsButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
