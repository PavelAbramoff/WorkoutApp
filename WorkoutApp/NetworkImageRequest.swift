//
//  NetworkImageRequest.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2024-01-22.
//

import Foundation

class NetworkImageRequest {
    
    static let shsred = NetworkImageRequest()
    private init() {}
    
    func recuestData(id: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let key = "20f68a094769ae9a4d5060e74c856696"
        let latitude = 49.3301420
        let longitude = -123.1583647
        
        let urlString = "https://openweathermap.org/img/wn/\(id)@2x.png"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            DispatchQueue.main.async {
                if let error {
                    completion(.failure(error))
                } else {
                    guard let data else { return }
                    completion(.success(data))
                }
            }
        }
        .resume()
    }
}
