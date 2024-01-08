//
//  UIViewController + Extencions.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2023-11-27.
//

import UIKit

extension UIViewController {
    
    func presentSimpleAlert(title: String, message: String? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okButton)
        
        present(alertController, animated: true)
    }
    
    func presentAlertWithAction(title: String, message: String? = nil, completionHandler: @escaping () -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(okButton)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}
