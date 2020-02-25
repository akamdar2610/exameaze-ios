//
//  FullViewController.swift
//  exameaze
//
//  Created by admin on 27/06/19.
//  Copyright © 2019 ACE. All rights reserved.
//

import UIKit
import Firebase
import AVKit
var catcha = ""
var catchb = ""
var catchc = ""

var catch_usname = ""
class FullViewController: UIViewController {

    var refUserDetails: DatabaseReference!
    var refCourses: DatabaseReference!
    var refFullCourse: DatabaseReference!
    
    
    var player = AVPlayer()
    var playerController = AVPlayerViewController()
    var urlvideo = ""
    
    func playVideo()
    {
        print("!!!!!!!!!!!!!!!!")
        print(urlvideo)
        let videoURL = NSURL(string: urlvideo)
        player = AVPlayer(url: videoURL! as URL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.addChild(playerController)
        
        // Add your view Frame
        self.view.addSubview(playerController.view)
        playerController.view.frame = CGRect(x: 46, y: 260, width: 280, height: 180 )
        player.play()
    }
    func stopVideo()
    {
        player.pause()
    }
    @IBAction func play(_ sender: UIButton)
    {
        playVideo()
    }
    
    
    @IBAction func back(_ sender: UIButton)
    {
        performSegue(withIdentifier: "dashboard", sender: self)
    }
    
    @IBOutlet weak var tittle: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        refUserDetails = Database.database().reference().child("UserDetails")
        refUserDetails.observe(DataEventType.value, with: {(snapshot) in
            for UserDetails in snapshot.children.allObjects as! [DataSnapshot]
            {
                let userobj = UserDetails.value as? [String: AnyObject]
                if((userobj?["username"] as! String) == catch_usname)
                {
                    print("&&&&&&&&&&&&&&&&&")
                    //let name = userobj?["name"] as! String
                    var ce = userobj?["cenroll"] as! integer_t
                    ce = ce + 1
                    
                    //update value to database
                    //Database.database().reference().child(name).child("cenroll").setValue(ce)
                    print(ce)
                    
                    
                }
            }
        })
        
        refCourses = Database.database().reference().child("Courses")
        refCourses.observe(DataEventType.value, with: {(snapshot) in
            for Courses in snapshot.children.allObjects as! [DataSnapshot]
            {
                let userobject = Courses.value as? [String: AnyObject]
                let coname = userobject?["CourseName"] as! String
                print(coname)
                print("^^^^^^^^^^^^^^")
                if(coname == catcha)
                {
                    self.urlvideo = userobject?["CourseVideo"] as! String
                    print(self.urlvideo)
                }
                
            }
        })
        
        super.viewDidLoad()
        
        tittle.text = catcha
        let imgurl = catchc
        let imageurl = imgurl
        
        let imgUrls:URL = URL(string: imageurl)!
        
        // Start background thread so that image loading does not make app unresponsive
        DispatchQueue.global(qos: .userInitiated).async
            {
                
                let imageData:NSData = NSData(contentsOf: imgUrls)!
                let imageView = UIImageView(frame: CGRect(x:18, y:100, width:120, height:100))
                
                // When from background thread, UI needs to be updated on main_queue
                DispatchQueue.main.async
                {
                    let  image = UIImage(data: imageData as Data)
                    imageView.image = image
                    imageView.contentMode = UIView.ContentMode.scaleAspectFit
                    self.view.addSubview(imageView)
                }
                
        }
    }
    
    
    

    @IBAction func pdf(_ sender: UIButton)
    
    {
        performSegue(withIdentifier: "pdfViewController", sender: self)
    }
    

}
