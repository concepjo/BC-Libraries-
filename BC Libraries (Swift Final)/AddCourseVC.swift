//
//  AddCourseVC.swift
//  BC Libraries (Swift Final)
//
//  Created by Joshua Concepcion on 4/30/18.
//  Copyright © 2018 JoshuaConcepcion. All rights reserved.
//

import UIKit

class AddCourseVC: UIViewController {

    @IBOutlet weak var courseNameText: UITextField!
    @IBOutlet weak var courseCodeText: UITextField!

    @IBOutlet weak var saveBarButton: UIBarButtonItem!
   
    
    var courseName: String?
    var courseCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let courseName = courseName {
            courseNameText.text = courseName
            self.navigationItem.title = "Edit Course Info"
        } else {
            self.navigationItem.title = "New Course"
        }
        if let courseCode = courseCode {
            courseCodeText.text = courseCode
        }
       
         enableDisableSaveButton()
        courseNameText.becomeFirstResponder()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindFromSave" {
            courseName = courseNameText.text
            courseCode = courseCodeText.text
        }
    }
    
    func enableDisableSaveButton() {
        if let courseNameTextCount = courseNameText.text?.count, courseNameTextCount > 0 {
            saveBarButton.isEnabled = true
        } else {
            saveBarButton.isEnabled = false
        }
    }
    
    @IBAction func courseNameTextChanged(_ sender: UITextField) {
        enableDisableSaveButton()
    }
   
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    

}
