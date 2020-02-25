//
//  DashboardView.swift
//  exameaze
//
//  Created by admin on 31/05/19.
//  Copyright © 2019 ACE. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

var catcher = ""

class DashboardView: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    
    var refUserDetails: DatabaseReference!
    var refCatalog: DatabaseReference!
    
    //variable for storing current row of table
    var myIndex = 0
    var cname = ""
    var cdes = ""
    var imgurl = ""
    var i = 0
    var tableData = [String]()
    var tableDetailData = [String]()
    var imgArray = [String]()
    var catchname = ""

    @IBOutlet weak var course_enroll: UILabel!
    @IBOutlet weak var courseTable: UITableView!
    
    func addtoArray()
    {
        var i = 0
        refCatalog.observe(DataEventType.value, with: {(snapshot) in
            for Catalog in snapshot.children.allObjects as! [DataSnapshot]
            {
                if (i != 11)
                {
                    let userobject = Catalog.value as? [String: AnyObject]
                    
                    self.tableData.append(userobject?["CourseName"] as! String)
                    self.tableDetailData.append(userobject?["CourseDescription"] as! String)
                    self.imgArray.append(userobject?["CourseImg"] as! String)
                    //print(self.tableData)
                    //print(self.tableDetailData)
                    //print(self.imgArray)
                    i=i+1
                }
                else
                {
                    break
                }
            }
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       /* if tableDetailData.count < tableData.count
        {
            return tableDetailData.count
        }
        else
        {
            return tableData.count
        }*/
        return tableData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
           // let cell = UITableViewCell(style: .value1, reuseIdentifier: "tableCell")
            let cell = UITableViewCell(style: .default, reuseIdentifier: "tableCell")
            cell.textLabel?.text = tableData[indexPath.row]
        
            //cell.textLabel?.text = "Hello!"
            //cell.detailTextLabel?.text = tableDetailData[indexPath.row]
        
            cell.imageView?.image = UIImage(named: imgArray[indexPath.row])
        
            return (cell)
    }
    
    
    
    //reloading table cells
    override func viewDidAppear(_ animated: Bool)
    {
        courseTable.reloadData()
    }
    
    
    
    //action for table cells
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        myIndex = indexPath.row
        //performSegue(withIdentifier: "cellsegue", sender: self)
        cname = tableData[myIndex]
        cdes = tableDetailData[myIndex]
        imgurl = imgArray[myIndex]
        //print("done")
        performSegue(withIdentifier: "cellsegue", sender: self)
    }
    
    
    @IBOutlet weak var hello: UILabel!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        catchname = catcher
        hello.text = catchname
    
        refCatalog = Database.database().reference().child("Catalog")
        refUserDetails = Database.database().reference().child("UserDetails")
        
        addtoArray()
        
        refUserDetails.observe(DataEventType.value, with: {(snapshot) in
            for UserDetails in snapshot.children.allObjects as! [DataSnapshot]
            {
                let userobject = UserDetails.value as? [String: AnyObject]
                if ((userobject?["username"] as! String) == self.hello.text)
                {
                    let ce = userobject?["cenroll"] as! integer_t
                    
                    self.course_enroll.text = String(ce)
                }
            }
        })
        
    }
    
    @IBAction func signout(_ sender: UIButton)
    {
        do
        {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "LoginView", sender: self)
        }
        catch
        {
            displayAlertMsg(message: "Logout unsuccessful !!!")
        }
    }
    
    func displayAlertMsg(message: String)
    {
        let alert = UIAlertController(title: "ALERT", message: message, preferredStyle: UIAlertController.Style.alert)
        let okaction = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okaction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
       
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        print("*********")
        
        if segue.identifier == "cellsegue"
        {
            let dest = segue.destination as! newViewController
            dest.catch1 = cname
            dest.catch2 = cdes
            dest.catch3 = imgurl
            dest.catch_username = catcher
           
        }
    
        
    }

}
