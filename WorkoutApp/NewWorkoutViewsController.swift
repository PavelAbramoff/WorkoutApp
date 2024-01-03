//
//  NewWorkoutViewsController.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2023-11-05.
//

import UIKit
import RealmSwift

class NewWorkoutViewsController: UIViewController {
    
    private let newWorkoutLabel = UILabel(text: "NEW WORKOUT",
                                          font: .robotoMedium24(),
                                          textColor: .specialGray)
    
    private lazy var closeButton = CloseButton(type: .system)
    
    private let nameView = NameView()
    private let dateAndRepearView = DataAndRepeatView()
    private let repsOrTimerView = RepsOrTimerView()
    private let saveButton = GreenButton(text: "SAVE")
    
    private var workoutModel = WorkouteModel()
    private var testImage = UIImage(named: "testWorkout")
    
    private lazy var stackView = UIStackView(arrangedSubviews: [nameView,
                                                               dateAndRepearView,
                                                               repsOrTimerView],
                                             axis: .vertical,
                                             spacinng: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        addGesture()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        newWorkoutLabel.textAlignment = .center
        
        view.addSubview(newWorkoutLabel)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        view.addSubview(closeButton)
        view.addSubview(stackView)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        view.addSubview(saveButton)

    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
        print(RealmManager.shared.getResultWorkoutModel())
    }
    
    @objc private func saveButtonTapped() {
        setModel()
        saveModel()
//        RealmManager.shared.saveWorkoutModel(workoutModel)
//        workoutModel = WorkouteModel()
    }
    
    private func setModel() {
        workoutModel.workoutName = nameView.getNAmeTextFieldText()
        
        let dateWorkout = dateAndRepearView.getDateAndRepeat().date.localDate()
        workoutModel.workoutDate =  dateWorkout
        workoutModel.workoutRepeat =  dateAndRepearView.getDateAndRepeat().isRepeat
        workoutModel.workoutNumberOfDay = dateWorkout.getWeekdayNumber()
        
        workoutModel.workoutSets = repsOrTimerView.sets
        workoutModel.workoutReps = repsOrTimerView.reps
        workoutModel.workoutTimer = repsOrTimerView.timer
        
        guard let imageData = testImage?.pngData() else { return }
        workoutModel.workoutImage = imageData
    }
    
    private func saveModel() {
        let text = nameView.getNAmeTextFieldText()
        let count = text.filter { $0.isNumber || $0.isLetter }.count
        
        if count != 0 &&
            workoutModel.workoutSets != 0 &&
            (workoutModel.workoutReps != 0 || workoutModel.workoutTimer != 0) {
            RealmManager.shared.saveWorkoutModel(workoutModel)
            workoutModel = WorkouteModel()
            presentSimpleAlert(title: "Success")
            resetValues()
        } else {
            presentSimpleAlert(title: "Error", message: "Enter all parameters")
        }
    }
    
    private func resetValues() {
        nameView.deleteTextTextfield()
        dateAndRepearView.resetDataAndReapeat()
        repsOrTimerView.resetSliderViewValues()
    }
    
    private func addGesture() {
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(higeKeyboard))
        view.addGestureRecognizer(tapScreen)
        
        let swipeScreen = UISwipeGestureRecognizer(target: self, action: #selector(higeKeyboard))
        swipeScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(swipeScreen)
    }
    
    @objc private func higeKeyboard() {
        view.endEditing(true)
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
            
            nameView.heightAnchor.constraint(equalToConstant: 60),
            dateAndRepearView.heightAnchor.constraint(equalToConstant: 115),
            repsOrTimerView.heightAnchor.constraint(equalToConstant: 340),
            
            stackView.topAnchor.constraint(equalTo: newWorkoutLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            saveButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 55)
            
        ])
    }
}
