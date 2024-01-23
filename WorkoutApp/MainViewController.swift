//
//  MainViewController.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2023-10-24.
//

import UIKit

class MainViewController: UIViewController {
    
    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.7607843137, blue: 0.7607843137, alpha: 1)
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Your name"
        label.textColor = .specialGray
        label.font = .robotoMedium24()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addWorkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialYellow
        button.layer.cornerRadius = 10
        button.setTitle("Add workout", for: .normal)
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.tintColor = .specialDarkGreen
        button.titleLabel?.font = .robotoMedium12()
        button.imageEdgeInsets = .init(top: 0, left: 20, bottom: 15, right: 0)
        button.titleEdgeInsets = .init(top: 50, left: -40, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(addWorkoutButtonTapped), for: .touchUpInside)
        button.addShadowOnView()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let noWorkoutImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "noWorkout")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let calendarView = CalendarView()
    private let weatherView = WeatherView()
    private let workoutTodayLabel = UILabel(text: "Workout today")
    private let tableView = MainTableView()
    
    private var workoutArray = [WorkoutModel]()
    
    override func viewDidLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectItem(date: Date())
        setupUserParameters()
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        getWeather()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        calendarView.setDelegate(self)
        view.addSubview(calendarView)
        view.addSubview(userPhotoImageView)
        view.addSubview(userNameLabel)
        view.addSubview(addWorkoutButton)
        view.addSubview(weatherView)
        view.addSubview(workoutTodayLabel)
        tableView.mainDelegate = self
        view.addSubview(tableView)
        view.addSubview(noWorkoutImageView)
    }
    
    @objc private func addWorkoutButtonTapped() {
        let newWorkoutViewController = NewWorkoutViewsController()
        newWorkoutViewController.modalPresentationStyle = .fullScreen
        present(newWorkoutViewController, animated: true)
    }
    
    private func getWorkouts(date: Date) {
        let weekday = date.getWeekdayNumber() //2
        let startDate = date.startEndDate().start //25.09.2023 00:00
        let endDate = date.startEndDate().end //26.09.2023 00:00
        
        let predicateRepeat = NSPredicate(format: "workoutNumberOfDay = \(weekday) AND workoutRepeat = true")
        let predicateUnrepeat = NSPredicate(format: "workoutRepeat = false AND workoutDate BETWEEN %@", [startDate, endDate])
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateUnrepeat])
        
        let resultArray = RealmManager.shared.getResultWorkoutModel()
        let filtredArray = resultArray.filter(compound).sorted(byKeyPath: "workoutName")
        workoutArray = filtredArray.map { $0 }
    }
    
    private func checkWorkoutToday() {
        noWorkoutImageView.isHidden = !workoutArray.isEmpty
        tableView.isHidden = workoutArray.isEmpty
    }
    
    private func setupUserParameters() {
        let userArray = RealmManager.shared.getResultUserModel()
        
        if !userArray.isEmpty {
            userNameLabel.text = userArray[0].userFirstName + " " + userArray[0].userSecondName
  
            guard let data = userArray[0].userImage,
                  let image = UIImage(data: data) else {
                return
            }
            userPhotoImageView.image = image
        }
    }
    
    func getWeather() {
        NetworkDataFetch.shared.fetchWeather { [weak self] result, error in
            guard let self else { return }
            if let model = result {
                print(model)
                self.weatherView.updateLabels(model: model)
                NetworkImageRequest.shsred.recuestData(id: model.weather[0].icon) { result in
                    switch result {
                    case .success(let data):
                        self.weatherView.updateImage(data: data)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            
            if let error {
                self.presentSimpleAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
}

//MARK: - CalendarViewProtocol
 
extension MainViewController: CalendarViewProtocol {
    func selectItem(date: Date) {
        getWorkouts(date: date)
        tableView.setWorkoutsArray(workoutArray)
        tableView.reloadData()
        checkWorkoutToday()
    }
}

//MARK: - MainTableViewProtocol

extension MainViewController: MainTableViewProtocol {
    func deleteWorkout(model: WorkoutModel, index: Int) {
        RealmManager.shared.deleteWorkoutModel(model)
        workoutArray.remove(at: index)
        tableView.setWorkoutsArray(workoutArray)
        tableView.reloadData()
        checkWorkoutToday()
    }
}

extension MainViewController: WorkoutCellProtocol {
    func startButtonTapped(model: WorkoutModel) {
        if model.workoutTimer == 0 {
            let repsWorkoutViewController = RepsWorkoutViewController()
            repsWorkoutViewController.modalPresentationStyle = .fullScreen
            repsWorkoutViewController.setWorkoutModel(model)
            present(repsWorkoutViewController, animated: true)
        } else {
            let timerWorkoutViewController = TimerWorkoutViewController()
            timerWorkoutViewController.modalPresentationStyle = .fullScreen
            timerWorkoutViewController.setWorkoutModel(model)
            present(timerWorkoutViewController, animated: true)
        }
    }
}

//MARK: - Set Constraints

extension MainViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userPhotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            calendarView.topAnchor.constraint(equalTo: userPhotoImageView.centerYAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 70),
            
            userNameLabel.bottomAnchor.constraint(equalTo: calendarView.topAnchor, constant: -10),
            userNameLabel.leadingAnchor.constraint(equalTo: userPhotoImageView.trailingAnchor, constant: 5),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            addWorkoutButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            addWorkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addWorkoutButton.heightAnchor.constraint(equalToConstant: 80),
            addWorkoutButton.widthAnchor.constraint(equalToConstant: 80),
            
            weatherView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            weatherView.leadingAnchor.constraint(equalTo: addWorkoutButton.trailingAnchor, constant: 10),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            weatherView.heightAnchor.constraint(equalToConstant: 80),
            
            workoutTodayLabel.topAnchor.constraint(equalTo: addWorkoutButton.bottomAnchor, constant: 10),
            workoutTodayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            workoutTodayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            tableView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            noWorkoutImageView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor),
            noWorkoutImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noWorkoutImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noWorkoutImageView.heightAnchor.constraint(equalTo: noWorkoutImageView.widthAnchor)
        ])
    }
}
