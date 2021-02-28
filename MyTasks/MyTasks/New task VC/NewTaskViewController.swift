//
//  NewPlaceViewController.swift
//  MyTasks
//
//  Created by Ben Mustafa Anas on 24/02/2021.
//  Copyright © 2021 Ben Mustafa Anas. All rights reserved.
//

import UIKit

class NewTaskViewController: UITableViewController {
    
    var currentTask: Task?
    var imageIsChanged = false
    
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var taskImage: UIImageView!
    @IBOutlet var taskName: UITextField!
    @IBOutlet var taskStatus: UITextField!
    @IBOutlet var taskNote: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        saveButton.isEnabled = false
        taskName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setupEditScreen()
    }
    
    func saveTask() {
        
        var image: UIImage?
        
        if imageIsChanged {
            image = taskImage.image
        } else {
            image = #imageLiteral(resourceName: "imagePlaceholder")
        }
        
        let imageData = image?.pngData()
        
        let newTask = Task(name: taskName.text!,
                           status: taskStatus.text,
                           imageData: imageData,
                           date: Date(),
                           note: taskNote.text)
        
        if currentTask != nil {
            try! realm.write {
                currentTask?.name = newTask.name
                currentTask?.status = newTask.status
                currentTask?.imageData = newTask.imageData
                currentTask?.date = newTask.date
            }
        } else {
            StorageManager.saveObject(newTask)
        }
    }
    
    private func setupEditScreen() {
        
        if currentTask != nil {
            setupNavigationBar()
            imageIsChanged = true
            
            guard let data = currentTask?.imageData, let image = UIImage(data: data) else { return }
            
            taskImage.image = image
            taskImage.contentMode = .scaleAspectFill
            taskName.text = currentTask?.name
            taskStatus.text = currentTask?.status
            taskNote.text = currentTask?.note
        }
    }
    
    private func setupNavigationBar() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = currentTask?.name
        saveButton.isEnabled = true
    }

    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
