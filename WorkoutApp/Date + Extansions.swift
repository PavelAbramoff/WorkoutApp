//
//  Date + Extansions.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2023-11-10.
//

import Foundation

extension Date {
    
    func getWeekdayNumber() -> Int {
        let calendar =  Calendar.current
        let weekday = calendar.component(.weekday, from: self)
        return weekday
    }
    
    func localDate() -> Date {
        let timeZoneOffset = TimeZone.current.secondsFromGMT(for: self)
        let localDate = Calendar.current.date(byAdding: .second, value: timeZoneOffset, to: self) ?? Date()
        return localDate
    }
    
    func getWeekArray() -> [[String]] {
        let formater = DateFormatter()
        formater.locale = Locale(identifier: "en_GB")
        formater.dateFormat = "EEEEEE"
        let calendar = Calendar.current
        
        var weekArray: [[String]] = [[], []]
        
        for index in -6...0 {
            let date = calendar.date(byAdding: .day, value: index, to: self) ?? Date()
            let day = calendar.component(.day, from: date)
            weekArray[1].append("\(day)")
            let weekDay = formater.string(from: date)
            weekArray[0].append(weekDay)
        }
        return weekArray
    }
    
    func offSetDay(days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: -days, to: self) ?? Date()
    }
}
