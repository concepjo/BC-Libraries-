//
//  CoursesVC.swift
//  BC Libraries (Swift Final)
//
//  Created by Joshua Concepcion on 4/29/18.
//  Copyright © 2018 JoshuaConcepcion. All rights reserved.
//

import UIKit

class CoursesVC: UIViewController {
    
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var returnButton: UIButton!
    
    var defaultsData = UserDefaults.standard
    var coursesArray = [String]()
    var courseCodeArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        coursesArray = defaultsData.stringArray(forKey: "coursesArray") ?? [String]()
        courseCodeArray = defaultsData.stringArray(forKey: "courseCodeArray") ?? [String]()
    }
    
    func saveDefaultsData() {
        defaultsData.set(coursesArray, forKey: "coursesArray")
        defaultsData.set(courseCodeArray, forKey: "courseCodeArray")
    }

    @IBAction func returnButtonPressed(_ sender: UIButton) {
       self.performSegue(withIdentifier: "ToHome", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditItem" {
            let destination = segue.destination as! AddCourseVC
            let index = tableView.indexPathForSelectedRow!.row
            destination.courseName = coursesArray[index]
            destination.courseCode = courseCodeArray[index]
        } else {
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: false)
            }
        }
    }

    @IBAction func unwindFromDetailViewController(segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! AddCourseVC
        if let indexPath = tableView.indexPathForSelectedRow {
            coursesArray[indexPath.row] = sourceViewController.courseName!
            courseCodeArray[indexPath.row] = sourceViewController.courseCode!
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: coursesArray.count, section: 0)
            coursesArray.append(sourceViewController.courseName!)
            courseCodeArray.append(sourceViewController.courseCode!)
            print("TEST: \(sourceViewController.courseName!) AND \(sourceViewController.courseCode!)")
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

extension CoursesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coursesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = coursesArray[indexPath.row]
       cell.detailTextLabel?.text = courseCodeArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print(coursesArray)
            print(courseCodeArray)
            print(indexPath.row)
            coursesArray.remove(at: indexPath.row)
            courseCodeArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveDefaultsData()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = coursesArray[sourceIndexPath.row]
        let noteToMove = courseCodeArray[sourceIndexPath.row]
        coursesArray.remove(at: sourceIndexPath.row)
        courseCodeArray.remove(at: sourceIndexPath.row)
        coursesArray.insert(itemToMove, at: destinationIndexPath.row)
        courseCodeArray.insert(noteToMove, at: destinationIndexPath.row)
        saveDefaultsData()
    }
}
