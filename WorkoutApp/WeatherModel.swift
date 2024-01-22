//
//  WeatherModel.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2024-01-21.
//

import Foundation

struct WeatherModel: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Weather: Codable {
    let description: String
    let icon: String
}
