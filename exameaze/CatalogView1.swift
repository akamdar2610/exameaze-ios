//
//  CatalogView1.swift
//  exameaze
//
//  Created by admin on 06/06/19.
//  Copyright © 2019 ACE. All rights reserved.
//

import UIKit

var courseData = [String]()
var courseDetailData = [String]()

class CatalogView: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    
    @IBOutlet weak var catalogTable: UITableView!
    let courseData = ["Course 1","Course 2","Course 3","Course 4","Course 5","Course 6","Course 7","Course 8","Course 9","Course 10"]
    let courseDetailData = ["This course is for Computer Graphics","This course is for Computer Oraganization & Architechture","This course is for Analysis of Algoithms","This course is for Applied Mathematics 4","This course is for Operating Systems","This course is for Computer Graphics","This course is for Computer Oraganization & Architechture","This course is for Analysis of Algoithms","This course is for Applied Mathematics 4","This course is for Operating Systems"]
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
        //cell.imageView?.image = UIImage(named: "EduEasy_logo")
        
        return (cellone)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        catalogTable.reloadData()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    
    
    
}

