//
//  StatisticTableView.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2023-11-05.
//

import UIKit

class StatisticTableView: UITableView {

    private let idStatisticTableViewCell = "idStatisticTableViewCell"

    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        configure()
        setDelegate()
        register(StatisticTableViewCell.self, forCellReuseIdentifier: idStatisticTableViewCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .none
        separatorStyle = .none
        bounces = false
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDelegate() {
        dataSource = self
        delegate = self
    }
}

extension StatisticTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idStatisticTableViewCell, for: indexPath) as? StatisticTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}

extension StatisticTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        55
    }
}
