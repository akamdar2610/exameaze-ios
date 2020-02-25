//
//  ViewController2.swift
//  exam_prep
//
//  Created by admin on 09/04/19.
//  Copyright © 2019 ACE. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

class SignupView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate
{
    var refUserDetails: DatabaseReference!
    
    var pickerData1: [String] = []
    var pickerData2: [String] = []
    var pickerData3: [String] = []
    var pickerData4: [String] = []
    
    var currentField = UITextField()
    var picker = UIPickerView()
    
    var subscription = "demo"
    var ce = 0
    
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var mobno: UITextField!
    @IBOutlet weak var emailid: UITextField!
    @IBOutlet weak var dob: UITextField!
    @IBOutlet weak var conpass: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var stream: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var branch: UITextField!
    @IBOutlet weak var university: UITextField!
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if(currentField == stream)
        {
            return pickerData1.count
        }
        else if(currentField == year)
        {
            return pickerData2.count
        }
        else if(currentField == branch)
        {
            return pickerData3.count
        }
        else if(currentField == university)
        {
            return pickerData4.count
        }
        else
        {
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if(currentField == stream)
        {
            return pickerData1[row]
        }
        else if(currentField == year)
        {
            return pickerData2[row]
        }
        else if(currentField == branch)
        {
            return pickerData3[row]
        }
        else if(currentField == university)
        {
            return pickerData4[row]
        }
        else
        {
            return nil
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(currentField == stream)
        {
            stream.text = pickerData1[row]
            self.view.endEditing(true)
        }
        else if(currentField == year)
        {
            year.text = pickerData2[row]
            self.view.endEditing(true)
        }
        else if(currentField == branch)
        {
            branch.text = pickerData3[row]
            self.view.endEditing(true)
        }
        else if(currentField == university)
        {
            university.text = pickerData4[row]
            self.view.endEditing(true)
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        self.picker.delegate = self
        self.picker.dataSource = self
        currentField = textField
        if(currentField == stream)
        {
            currentField.inputView = picker
        }
        else if(currentField == year)
        {
            currentField.inputView = picker
        }
        else if(currentField == branch)
        {
            currentField.inputView = picker
        }
        else if(currentField == university)
        {
            currentField.inputView = picker
        }
    }
    
    
    
    @IBAction func reg(_ sender: UIButton)
    {
        let pass = password.text
        let confirm = conpass.text
        let name = fullname.text
        let date = dob.text
        let contact = mobno.text
        let streams = stream.text
        let years = year.text
        let branchs = branch.text
        let uni = university.text
        let mail = emailid.text
        
        if((pass?.isEmpty)! || (confirm?.isEmpty)! || (name?.isEmpty)! || (date?.isEmpty)! || (contact?.isEmpty)! || (streams?.isEmpty)! || (years?.isEmpty)! || (branchs?.isEmpty)! || (uni?.isEmpty)! || (mail?.isEmpty)!)
        {
            displayAlertMsg(message: "All Fields are required !!!")
            
        }
        else if(pass != confirm)
        {
            displayAlertMsg(message: "Passwords are not matching.")
        }
        else
        {
            Auth.auth().createUser(withEmail: emailid.text!, password: password.text!){ (user, error) in
                
                if error == nil
                {
                    print("User created....")
                    self.performSegue(withIdentifier: "LoginView", sender: self)
                }
                else{
                    self.displayAlertMsg(message: "Authentication Error")
                }
            }
            addUser()
        }
    }
    
    func displayAlertMsg(message: String)
    {
        let alert = UIAlertController(title: "ALERT", message: message, preferredStyle: UIAlertController.Style.alert)
        let okaction = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okaction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func addUser()
    {
        let key = refUserDetails.childByAutoId().key
        let user = ["name": fullname.text! as String,
                    "username": emailid.text! as String,
                    "email": emailid.text! as String,
                    "password":password.text! as String,
                    "contact": mobno.text! as String,
                    "dateofbirth": dob.text! as String,
                    "stream": stream.text! as String,
                    "year": year.text! as String,
                    "branch": branch.text! as String,
                    "university": university.text! as String,
                    "subscription": subscription as String,
                    "cenroll": ce as Int
            ] as [String : Any]
        
        refUserDetails.child(key!).setValue(user)
    }
    
    
    @IBAction func gotoLogin(_ sender: UIButton)
    {
        performSegue(withIdentifier: "LoginView", sender: self)
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        pickerData1 = ["Engineering"]
        pickerData2 = ["First Year","Second Year", "Third Year", "Fourth Year"]
        pickerData3 = ["Computers", "IT", "Mechanical", "Civil", "EXTC", "Electrical"]
        pickerData4 = ["Mumbai University"]
        
        refUserDetails = Database.database().reference().child("UserDetails")
    }
    
    
}
