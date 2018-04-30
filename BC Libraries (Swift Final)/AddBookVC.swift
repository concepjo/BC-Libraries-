//
//  AddBookVC.swift
//  BC Libraries (Swift Final)
//
//  Created by Joshua Concepcion on 4/30/18.
//  Copyright © 2018 JoshuaConcepcion. All rights reserved.
//

import UIKit

class AddBookVC: UIViewController {

    @IBOutlet weak var bookNameText: UITextField!
    @IBOutlet weak var callNumberText: UITextField!
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    
    var bookName: String?
    var callNumber: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let bookName = bookName {
            bookNameText.text = bookName
            self.navigationItem.title = "Edit Book Info"
        } else {
            self.navigationItem.title = "New Book"
        }
        if let callNumber = callNumber {
            callNumberText.text = callNumber
        }
        
        enableDisableSaveButton()
        bookNameText.becomeFirstResponder()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindFromSaveBook" {
            bookName = bookNameText.text
            callNumber = callNumberText.text
        }
    }
    
    func enableDisableSaveButton() {
        if let bookNameTextCount = bookNameText.text?.count, bookNameTextCount > 0 {
            saveBarButton.isEnabled = true
        } else {
            saveBarButton.isEnabled = false
        }
    }
    
    @IBAction func bookNameTextChanged(_ sender: UITextField) {
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
