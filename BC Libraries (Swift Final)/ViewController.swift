//
//  ViewController.swift
//  BC Libraries (Swift Final)
//
//  Created by Joshua Concepcion on 4/28/18.
//  Copyright © 2018 JoshuaConcepcion. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI

class ViewController: UIViewController {
    
    @IBOutlet weak var myCoursesButton: UIButton!
    @IBOutlet weak var myBookshelfButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var authUI: FUIAuth!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        signIn()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? SearchVC {
            destination.search = searchTextField.text
        }
    }
    
    // Brings you to My Bookshelf Page when button is pressed.
    @IBAction func myBookshelfButtonPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "ToBookshelf", sender: self)
    }
    // Brings you to My Courses Page when button is pressed.
    @IBAction func myCoursesButtonPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "ToCourses", sender: self)
    }
    
    // Search Button Stuff
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
       
        self.performSegue(withIdentifier: "ToSearch", sender: self)
    }
    
    
    // Signs you out when Sign Out button is pressed.
    @IBAction func signOutButtonPressed(_ sender: UIButton) {
            do {
                try authUI!.signOut()
                print("^^^ Successfully signed out!")
                //tableView.isHidden = true
                signIn()
            } catch {
                //tableView.isHidden = true
                print("*** ERROR: Couldn't sign out")
        }
    }
    
    
    
}

extension ViewController: FUIAuthDelegate {
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication:
            sourceApplication) ?? false {
            return true
        }
        return false
    }
    
    func signIn() {
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(),
            ]
        if authUI.auth?.currentUser == nil {
            self.authUI?.providers = providers
            present(authUI.authViewController(), animated: true, completion: nil)
        } else {
            
        }
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if let user = user {
            
            print("^^^ We signed in with the user \(user.email ?? "unknown e-mail")")
        }
    }
    
    func authPickerViewController(forAuthUI authUI: FUIAuth) -> FUIAuthPickerViewController {
        
        // Create an instance of the FirebaseAuth login view controller
        let loginViewController = FUIAuthPickerViewController(authUI: authUI)
        
        // Set background color to white
        loginViewController.view.backgroundColor = UIColor.lightGray
        
        // Create a frame for an ImageView to hold our logo
        let marginInsets: CGFloat = 16 // logo will be 16 points from L and R margins
        let imageHeight: CGFloat = 225 // the height of our logo
        let imageY = self.view.center.y - imageHeight // place bottom of UIImageView at center of screen
        // Use values above to build a CGRect for the ImageView’s frame
        let logoFrame = CGRect(x: self.view.frame.origin.x + marginInsets, y: imageY, width:
            self.view.frame.width - (marginInsets*2), height: imageHeight)
        
        // Create the UIImageView using the frame created above & add the "logo" image
        let logoImageView = UIImageView(frame: logoFrame)
        logoImageView.image = UIImage(named: "LibraryBCSeal")
        logoImageView.contentMode = .scaleAspectFit // Set imageView to Aspect Fit
        loginViewController.view.addSubview(logoImageView) // Add ImageView to the login controller's main view
        return loginViewController
    }
}

