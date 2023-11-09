//
//  SliderView.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2023-11-08.
//

import UIKit

class SliderView: UIView {
    
    private let nameLabel = UILabel(text: "Name", font: .robotoMedium18() , textColor: .specialGray)
    private let numberLabel = UILabel(text: "0", font: .robotoMedium24() , textColor: .specialGray)
    private let slider = GreenSlider()
    
    private lazy var labelsStackView = UIStackView(arrangedSubviews: [nameLabel,numberLabel],
                                                   axis: .horizontal,
                                                   spacinng: 10)
    
    private lazy var unitStsckView = UIStackView(arrangedSubviews: [labelsStackView, slider],
                                                 axis: .vertical,
                                                 spacinng: 10)
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(name: String, maxValue: Float) {
        self.init()
        self.nameLabel.text = name
        self.slider.minimumValue = 0
        self.slider.maximumValue = maxValue
        
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
        print(slider.value)
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
