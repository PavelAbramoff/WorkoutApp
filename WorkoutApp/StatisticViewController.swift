//
//  StatisticViewController.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2023-11-05.
//

import UIKit

class StatisticViewController: UIViewController {
    
    private let statisticLabel: UILabel = {
        let label = UILabel()
        label.text = "STATISTIC"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Week", "Month"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .specialGreen
        segmentedControl.selectedSegmentTintColor = .specialYellow
        let font = UIFont.robotoMedium16()
        segmentedControl.setTitleTextAttributes([.font: font as Any,
                                                 .foregroundColor: UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([.font : font as Any,
                                                 .foregroundColor: UIColor.specialGray], for: .selected)
        segmentedControl.addTarget(self, action: #selector(segmentedChange), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private let nameTextField = BrownTextField()
    private let exercisesLabel = UILabel(text: "Exercises")
    private let tableView = StatisticTableView()
    
    private var differenceArray = [DifferenceWorkout]()
    private var filteredArray = [DifferenceWorkout]()
    
    private var isFilter = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        segmentedChange()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(statisticLabel)
        view.addSubview(segmentedControl)
        nameTextField.brownDelegate = self
        view.addSubview(nameTextField)
        view.addSubview(exercisesLabel)
        view.addSubview(tableView)
    }
    
    @objc private func segmentedChange() {
        let dateToday = Date()
        differenceArray = [DifferenceWorkout]()
        if segmentedControl.selectedSegmentIndex == 0 {
            let dateStart = dateToday.offSetDay(days: 7)
            getDifferenceMmodels(dateStart: dateStart)
        } else {
            let dateStart = dateToday.offSetMonth(month: 1)
            getDifferenceMmodels(dateStart: dateStart)
        }
        tableView.setDifferenceArray(differenceArray)
        tableView.reloadData()
    }
    
    private func getWorkoutsNames() -> [String] {
        var nameArray = [String]()
        
        let allWorkouts = RealmManager.shared.getResultWorkoutModel()
        
        for workoutModel in allWorkouts {
            if !nameArray.contains(workoutModel.workoutName) {
                nameArray.append(workoutModel.workoutName)
            }
        }
        return nameArray
    }
    
    
    
    private func getDifferenceMmodels(dateStart: Date) {
        let dateEnd = Date()
        let nameArray = getWorkoutsNames()
        let allWorkouts = RealmManager.shared.getResultWorkoutModel()
        
        for name in nameArray {
            let predicate = NSPredicate(format: "workoutName = '\(name)' AND workoutDate BETWEEN %@", [dateStart, dateEnd])
            let filterArray = allWorkouts.filter(predicate).sorted(byKeyPath: "workoutDate").map { $0 }
            
            guard let last = filterArray.last?.workoutReps,
                  let first = filterArray.first?.workoutReps else {
                return
            }
            
            let differenceWorkout = DifferenceWorkout(name: name, lastReps: last, firstReps: first)
            differenceArray.append(differenceWorkout)
        }
    }
    
    func filteringWorkouts(text: String) {
        
        for workout in differenceArray {
            if workout.name.lowercased().contains(text.lowercased()) {
                filteredArray.append(workout)
            }
        }
    }
}

// MARK: - BrounTextFieldProtocol

extension StatisticViewController: BrounTextFieldProtocol {
    func typing(range: NSRange, replacementString: String) {
        if let text = nameTextField.text,
           let textRange = Range(range, in: text) {
            let updateText = text.replacingCharacters(in: textRange, with: replacementString)
            
            filteredArray = [DifferenceWorkout]()
            isFilter = updateText.count > 0
            filteringWorkouts(text: updateText)
        }
        
        if isFilter {
            tableView.setDifferenceArray(filteredArray)
        } else {
            tableView.setDifferenceArray(differenceArray)
        }
        tableView.reloadData()
    }
    
    func clear() {
        isFilter = false
        differenceArray = [DifferenceWorkout]()
        if segmentedControl.selectedSegmentIndex == 0 {
            getDifferenceMmodels(dateStart: Date().offSetDay(days: 7))
        } else {
            getDifferenceMmodels(dateStart: Date().offSetDay(days: 30))
        }
        tableView.setDifferenceArray(differenceArray)
        
        tableView.reloadData()
    }
    
    
}

// MARK: - SetConstraints

extension StatisticViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            statisticLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            statisticLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: statisticLabel.bottomAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            nameTextField.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 38),
            
            exercisesLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            exercisesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            exercisesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: exercisesLabel.bottomAnchor, constant:0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
