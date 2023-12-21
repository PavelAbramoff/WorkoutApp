//
//  UIViewController + Extencions.swift
//  WorkoutApp
//
//  Created by Pavel Абрамов on 2023-11-27.
//

import UIKit

extension UIViewController {
    
    func presentSimpleAlert(title: String, message: String? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert )
        let okButton = UIAlertAction(title: "OK", style: .destructive)
        alertController.addAction(okButton)
        
        present(alertController, animated: true)
    }
}
