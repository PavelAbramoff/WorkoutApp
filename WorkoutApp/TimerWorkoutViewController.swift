//
//  TimerWorkoutViewController.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2024-01-07.
//

import UIKit

class TimerWorkoutViewController: UIViewController {
    
    private let newWorkoutLabel = UILabel(text: "START WORKOUT",
                                          font: .robotoMedium24(),
                                          textColor: .specialGray)
    
    private lazy var closeButton = CloseButton(type: .system)
    
    private let ellipseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ellipse")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "1:35"
        label.textColor = .specialGray
        label.font = .robotoBold48()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var finishButton = GreenButton(text: "FINISH")
    private let detailsLabel = UILabel(text: "Details")
    private let timerWorkoutParametersView = TimerWorkoutParametersView()
    
    private var workoutModel = WorkoutModel()
    private var customAlert = CustomAlert()
    private var shapeLayer = CAShapeLayer()
    private var timer = Timer()
    
    private var durationTimer = 10
    private var numberOfSet = 0
    
    override func viewDidLayoutSubviews() {
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
        animationCircular()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        addGesture()
        setWorkoutParameters()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(newWorkoutLabel)
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        view.addSubview(ellipseImageView)
        view.addSubview(timerLabel)
        view.addSubview(detailsLabel)
        timerWorkoutParametersView.cellNextTimerDelegate = self
        timerWorkoutParametersView.refreshLabels(model: workoutModel, numberOfSet: numberOfSet )
        view.addSubview(timerWorkoutParametersView)
        view.addSubview(finishButton)
        finishButton.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
    }
    
    @objc private func closeButtonTapped() {
        //timer.invalidate()
        dismiss(animated: true, completion: nil)
        timer.invalidate()
    }
    
    @objc private func finishButtonTapped() {
        if numberOfSet == workoutModel.workoutSets {
            RealmManager.shared.updateStatusWorkoutModel(workoutModel)
            dismiss(animated: true)
        } else {
            presentAlertWithAction(title: "Warning", message: "You haven't finished your workout") {
                self.dismiss(animated: true)
            }
        }
    }
    
    func setWorkoutModel(_ model: WorkoutModel) {
        workoutModel = model
    }
    
    private func addGesture() {
        let tapLabel = UITapGestureRecognizer(target: self, action: #selector(startTimer))
        timerLabel.isUserInteractionEnabled = true
        timerLabel.addGestureRecognizer(tapLabel)
    }
    
    @objc private func startTimer() {
        timerWorkoutParametersView.buttonIsEnable(false)
        
        if numberOfSet == workoutModel.workoutSets {
            presentSimpleAlert(title: "Error", message: "Finish you workout")
        } else {
            bacicAnimation()
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(timerAction),
                                         userInfo: nil,
                                         repeats: true)
           
        }
        // bacicAnimation()
    }
    
    @objc private func timerAction() {
        durationTimer -= 1
        print(durationTimer)
        
        if durationTimer == 0 {
            timer.invalidate()
            durationTimer = workoutModel.workoutTimer
            
            numberOfSet += 1
            timerWorkoutParametersView.refreshLabels(model: workoutModel, numberOfSet: numberOfSet)
            timerWorkoutParametersView.buttonIsEnable(true)
        }
        
        let (min, sec) = durationTimer.convertSecond()
        timerLabel.text = "\(min):\(sec.setZeroForSeconnd())"
    }
    
    private func setWorkoutParameters() {
        let (min, sec) = workoutModel.workoutTimer.convertSecond()
        timerLabel.text = "\(min):\(sec.setZeroForSeconnd())"
        durationTimer = workoutModel.workoutTimer
    }
}

// MARK: - NextSetTimerProtocol

extension TimerWorkoutViewController: NextSetTimerProtocol {
    func nextSetTimerTapped() {
        if numberOfSet < workoutModel.workoutSets {
            numberOfSet += 1
            timerWorkoutParametersView.refreshLabels(model: workoutModel, numberOfSet: numberOfSet)
        } else {
            presentSimpleAlert(title: "Error", message: "Finish your workout")
        }
    }
    
    func editingTimerTapped() {
        customAlert.presentCustomAlert(viewController: self,
                                       repsOrTimer: "Timer of set") { [weak self] sets, timerOfSet in
            guard let self else { return }
            
            if sets != "" && timerOfSet != "" {
                guard let numberOfSets = Int(sets),
                      let numberOfTimer = Int(timerOfSet) else { return }
                RealmManager.shared.updateSetsRepsWorkoutModel(model: self.workoutModel,
                                                               sets: numberOfSets,
                                                               reps: numberOfTimer)
                let (min, sec) = numberOfTimer.convertSecond()
                self.timerLabel.text = "\(min):\(sec.setZeroForSeconnd())"
                self.durationTimer = numberOfTimer
                self.timerWorkoutParametersView.refreshLabels(model: self.workoutModel,
                                                              numberOfSet: self.numberOfSet)
                
            }
        }
    }
}

// MARK: - Animation

extension TimerWorkoutViewController {
    
    private func animationCircular() {
        
        let center = CGPoint(x: ellipseImageView.frame.width / 2,
                             y: ellipseImageView.frame.width / 2)
        
        let endAngle = 3 * CGFloat.pi / 2
        let startAngle = CGFloat.pi * 2 + endAngle
        
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: 127,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: false)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 21
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.specialGreen.cgColor
        shapeLayer.lineCap = .round
        ellipseImageView.layer.addSublayer(shapeLayer)
    }
    
    private func bacicAnimation() {
        let bacicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        bacicAnimation.toValue = 0
        bacicAnimation.duration = CFTimeInterval(durationTimer)
        shapeLayer.add(bacicAnimation, forKey: "bacicAnimation")
    }
}

//MARK: - Set Constraints

extension TimerWorkoutViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            newWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            newWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.centerYAnchor.constraint(equalTo: newWorkoutLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            
            ellipseImageView.topAnchor.constraint(equalTo: newWorkoutLabel.bottomAnchor, constant: 30),
            ellipseImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ellipseImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            ellipseImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            timerLabel.leadingAnchor.constraint(equalTo: ellipseImageView.leadingAnchor, constant: 40),
            timerLabel.trailingAnchor.constraint(equalTo: ellipseImageView.trailingAnchor, constant: -40),
            timerLabel.centerYAnchor.constraint(equalTo: ellipseImageView.centerYAnchor),
            
            detailsLabel.topAnchor.constraint(equalTo: ellipseImageView.bottomAnchor, constant: 20),
            detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            detailsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            timerWorkoutParametersView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 5),
            timerWorkoutParametersView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timerWorkoutParametersView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timerWorkoutParametersView.heightAnchor.constraint(equalToConstant: 230),
            
            finishButton.topAnchor.constraint(equalTo: timerWorkoutParametersView.bottomAnchor, constant: 20),
            finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}



