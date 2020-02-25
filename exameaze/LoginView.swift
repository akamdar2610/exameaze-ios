//
//  ViewController1.swift
//  exam_prep
//
//  Created by admin on 09/04/19.
//  Copyright © 2019 ACE. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginView: UIViewController
{
    
    var refUserDetails: DatabaseReference!
    
    
    @IBOutlet weak var usname: UITextField!
    @IBOutlet weak var passw: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        refUserDetails = Database.database().reference().child("UserDetails")
        
    }
    
    @IBAction func login(_ sender: UIButton)
    {
        if (((usname.text?.isEmpty)!) || ((passw.text?.isEmpty)!))
        {
            displayAlertMsg(message: "All fields are required.")
            
        }
        else
        {
            /*refUserDetails.observe(DataEventType.value, with: {(snapshot) in
                for UserDetails in snapshot.children.allObjects as! [DataSnapshot]
                {
                    let userobject = UserDetails.value as? [String: AnyObject]
                    let uname = userobject?["username"] as! String
                    let pass = userobject?["password"] as! String
                    
                    if(uname == self.usname.text && pass == self.passw.text)
                    {
                        print(uname)
                        //print(pass)
                        self.performSegue(withIdentifier: "DashboardView", sender: self)
                    }
                    else
                    {
                        print("erorrrrr")
                        self.displayAlertMsg(message: "Login Unsuccessful !!!")
                    }
                }
            })*/
            Auth.auth().signIn(withEmail: self.usname.text!, password: self.passw.text!) { (user, error) in
                if error == nil
                {
                    print("????Successful????")
                    self.performSegue(withIdentifier: "DashboardView", sender: self)
                }
                else
                {
                    print("erorrrrr")
                    self.displayAlertMsg(message: "Login Unsuccessful !!!")
                }
            }
        }
    }
    

    func displayAlertMsg(message: String)
    {
        let alert = UIAlertController(title: "ALERT", message: message, preferredStyle: UIAlertController.Style.alert)
        let okaction = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okaction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func newuser(_ sender: UIButton)
    {
        performSegue(withIdentifier: "SignupView", sender: sender)
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "DashboardView"
        {
            catcher = usname.text!
        }
        
    }
    
}
