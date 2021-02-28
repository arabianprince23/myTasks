//
//  TextFieldDelegateExtension.swift
//  MyPlaces
//
//  Created by Анас Бен Мустафа on 2/24/21.
//  Copyright © 2021 Ben Mustafa Anas. All rights reserved.
//

import UIKit

extension NewTaskViewController: UITextFieldDelegate {
    
    // Скрываем клавиатуру по нажатию на Done
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldChanged() {
        
        if taskName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}
