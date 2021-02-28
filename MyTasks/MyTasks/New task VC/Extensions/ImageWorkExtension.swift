//
//  ImageWorkExtension.swift
//  MyPlaces
//
//  Created by Анас Бен Мустафа on 2/24/21.
//  Copyright © 2021 Ben Mustafa Anas. All rights reserved.
//

import UIKit

extension NewTaskViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        taskImage.image = info[.editedImage] as? UIImage
        taskImage.contentMode = .scaleAspectFill
        taskImage.clipsToBounds = true
        imageIsChanged = true
        dismiss(animated: true)
    }
}
