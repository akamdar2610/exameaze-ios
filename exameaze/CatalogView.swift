//
//  CatalogView.swift
//  exameaze
//
//  Created by admin on 03/06/19.
//  Copyright © 2019 ACE. All rights reserved.
//

import UIKit

var courseData = [String]()
var courseDetailData = [String]()

class CatalogView: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    //variable for storing current row of table
    var myIndex = 0
    var i = 0
    @IBOutlet weak var catalogTable: UITableView!
    var courseData = ["Course 1","Course 2","Course 3","Course 4","Course 5","Course 6","Course 7","Course 8","Course 9","Course 10"]
    var courseDetailData = ["This Course is for Computer Graphics","This Course is for Computer Oraganization & Architechture","This Course is for Analysis of Algoithms","This Course is for Applied Mathematics 4","This Course is for Operating Systems","This Course is for Open Source Tech Lab","This Course is for Applied Mathematics 3","This Course is for Electrical Circuits & Communication Fundamentals","This Course is for Digital Logic & Design Analysis","This Course is for Discrete Maths"]
    var imgArray = ["CG","COA","AOA","AM4","OS","OSTL","AM3","ECCF","DLDA","DM"]
    var updateData = ["Course 11","Course 12"]
    var updateDetailData = ["This Course is for Object Oriented Programming Methodology","This Course is for Data Structures"]
    var UimgArray = ["OOPM","DS"]
    @IBAction func append(_ sender: UIButton) {

        courseData.append(updateData[i])
        courseDetailData.append(updateDetailData[i])
        imgArray.append(UimgArray[i])
        catalogTable.reloadData()
        i = i + 1

        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       /* if courseDetailData.count < courseData.count
        {
            return courseDetailData.count
        }
        else
        {
            return courseData.count
        }*/
        
        return courseData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellone = UITableViewCell(style: .subtitle, reuseIdentifier: "catalogcell")
        
        cellone.textLabel?.text = courseData[indexPath.row]
        //cell.textLabel?.text = "Hello!"
        cellone.detailTextLabel?.text = courseDetailData[indexPath.row]
        cellone.imageView?.image = UIImage(named: imgArray[indexPath.row])
        
        //cell.imageView?.image = UIImage(named: "EduEasy_logo")
        
        return (cellone)
    }
    //reloading table cells
    override func viewDidAppear(_ animated: Bool) {
        catalogTable.reloadData()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        

        
    }
    //action for table cells
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "cell2segue", sender: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
    }

    

   
}
