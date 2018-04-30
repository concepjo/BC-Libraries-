//
//  SearchVC.swift
//  BC Libraries (Swift Final)
//
//  Created by Joshua Concepcion on 4/30/18.
//  Copyright © 2018 JoshuaConcepcion. All rights reserved.
//

import UIKit
import WebKit

class SearchVC: UIViewController {

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var webView: WKWebView!
    var search:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemToSearch = search
        let url = URL(string: "https://library.bc.edu/search/?any=" + itemToSearch!)
        let request = URLRequest(url: url!)
            
       webView.load(request)
        
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        
        self.performSegue(withIdentifier: "ToHome2", sender: self)
        
    }
    
    
    }

  
    

    


