//
//  Int + Extencion.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2023-11-09.
//

import Foundation

extension Int {
    
    func getTimeFromSeconds() -> String {
        
        if self / 60 == 0 {
            return "\(self % 60) sec"
        }
        
        if self % 60 == 0 {
            return "\(self / 60) min"
        }
 
        return "\(self / 60) min \(self % 60) sec"
    }
    
    func convertSecond() -> (Int, Int) {
        let min = self / 60
        let sec = self % 60
        return (min, sec)
    }
    
    func setZeroForSeconnd() -> String {
        Double(self) / 0 < 1 ? "0\(self)" : "\(self )"
    }
}
