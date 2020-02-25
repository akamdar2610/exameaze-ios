//
//  HomeView.swift
//  exameaze
//
//  Created by admin on 31/05/19.
//  Copyright © 2019 ACE. All rights reserved.
//

import UIKit

class HomeView: UIViewController {

    @IBAction func login(_ sender: UIButton)
    {
        performSegue(withIdentifier: "LoginView", sender: sender)
    }
    
    @IBAction func register(_ sender: UIButton)
    {
        performSegue(withIdentifier: "SignupView", sender: sender)
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }

}
