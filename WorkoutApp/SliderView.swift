//
//  SliderView.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2023-11-08.
//

import UIKit

protocol SliderViewProtocol: AnyObject {
    func changeValue(type: SliderType, value: Int)
}

class SliderView: UIView {
    
    weak var delegate: SliderViewProtocol?
    
    private let nameLabel = UILabel(text: "Name", font: .robotoMedium18() , textColor: .specialGray)
    private let numberLabel = UILabel(text: "0", font: .robotoMedium24() , textColor: .specialGray)
    private let slider = GreenSlider()
    
    
    private lazy var labelsStackView = UIStackView(arrangedSubviews: [nameLabel,numberLabel],
                                                   axis: .horizontal,
                                                   spacinng: 10)
    
    private lazy var unitStsckView = UIStackView(arrangedSubviews: [labelsStackView, slider],
                                                 axis: .vertical,
                                                 spacinng: 10)
    
    private var sliderType: SliderType?
    
    var isActive: Bool = true {
        didSet {
            if self.isActive {
                nameLabel.alpha = 1
                numberLabel.alpha = 1
                slider.alpha = 1
            } else {
                nameLabel.alpha = 0.5
                numberLabel.alpha = 0.5
                slider.alpha = 0.5
                slider.value = 0
                numberLabel.text = "0"
            }
        }
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(name: String, maxValue: Float, type: SliderType) {
        self.init()
        self.nameLabel.text = name
        self.slider.minimumValue = 0
        self.slider.maximumValue = maxValue
        self.sliderType = type
        
        setupView()
        setConstraints()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        slider.addTarget(self, action: #selector(sliderCange), for: .valueChanged)
        labelsStackView.distribution = .equalSpacing
        
        addSubview(unitStsckView)
    }
    
    @objc private func sliderCange() {
        let intSliderValue = Int(slider.value)
        numberLabel.text =  sliderType == .timer ? intSliderValue.getTimeFromSecond() :  "\(intSliderValue)"
        guard let sliderType else { return }
        delegate?.changeValue(type: sliderType, value: intSliderValue)
    }
    
    func resetValues() {
        numberLabel.text = "0"
        slider.value = 0
        isActive = true
    }
}

// MARK: - Set Constraints

extension SliderView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            unitStsckView.topAnchor.constraint(equalTo: topAnchor),
            unitStsckView.leadingAnchor.constraint(equalTo: leadingAnchor),
            unitStsckView.trailingAnchor.constraint(equalTo: trailingAnchor),
            unitStsckView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
