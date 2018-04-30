//
//  BookshelfVC.swift
//  BC Libraries (Swift Final)
//
//  Created by Joshua Concepcion on 4/29/18.
//  Copyright © 2018 JoshuaConcepcion. All rights reserved.
//

import UIKit

class BookshelfVC: UIViewController {
    
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var returnButton: UIButton!
    
    var defaultsData = UserDefaults.standard
    var booksArray = [String]()
    var callNumberArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        booksArray = defaultsData.stringArray(forKey: "booksArray") ?? [String]()
        callNumberArray = defaultsData.stringArray(forKey: "callNumberArray") ?? [String]()
    }
    
    func saveDefaultsData() {
        defaultsData.set(booksArray, forKey: "booksArray")
        defaultsData.set(callNumberArray, forKey: "callNumberArray")
    }
    
    @IBAction func returnButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ToHome3", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditBook" {
            let destination = segue.destination as! AddBookVC
            let index = tableView.indexPathForSelectedRow!.row
            destination.bookName = booksArray[index]
            destination.callNumber = callNumberArray[index]
        } else {
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: false)
            }
        }
    }
    
    @IBAction func unwindFromDetailViewController(segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! AddBookVC
        if let indexPath = tableView.indexPathForSelectedRow {
            booksArray[indexPath.row] = sourceViewController.bookName!
            callNumberArray[indexPath.row] = sourceViewController.callNumber!
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: booksArray.count, section: 0)
            booksArray.append(sourceViewController.bookName!)
            callNumberArray.append(sourceViewController.callNumber!)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        saveDefaultsData()
    }
    
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            addBarButton.isEnabled = true
            editBarButton.title = "Edit"
        } else {
            tableView.setEditing(true, animated: true)
            addBarButton.isEnabled = false
            editBarButton.title = "Done"
        }
    }
    
}

extension BookshelfVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = booksArray[indexPath.row]
        cell.detailTextLabel?.text = callNumberArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            booksArray.remove(at: indexPath.row)
            callNumberArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveDefaultsData()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let bookToMove = booksArray[sourceIndexPath.row]
        let callToMove = callNumberArray[sourceIndexPath.row]
        booksArray.remove(at: sourceIndexPath.row)
        callNumberArray.remove(at: sourceIndexPath.row)
        booksArray.insert(bookToMove, at: destinationIndexPath.row)
        callNumberArray.insert(callToMove, at: destinationIndexPath.row)
        saveDefaultsData()
    }
}
