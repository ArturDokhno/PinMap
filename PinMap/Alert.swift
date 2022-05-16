//
//  Alert.swift
//  PinMap
//
//  Created by Артур Дохно on 16.05.2022.
//

import UIKit

extension UIViewController {
    
    func alertAddAddress(title: String, placeholder: String, completionHandler: @escaping (String) -> ()) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let alertOk = UIAlertAction(title: "OK", style: .default) { action in
            let textFieldText = alertController.textFields?.first
            
            guard let text = textFieldText?.text else { return }
            
            completionHandler(text)
        }
        
        let alertCancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        alertController.addTextField { textField in
            textField.placeholder = placeholder
        }
        
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func alertError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertOk = UIAlertAction(title: "OK", style: .cancel)
        
        alertController.addAction(alertOk)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
