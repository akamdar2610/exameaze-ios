//
//  newViewController.swift
//  exameaze
//
//  Created by admin on 04/06/19.
//  Copyright © 2019 ACE. All rights reserved.
//

import UIKit
import Firebase
import AVKit

class newViewController: UIViewController
{
    var refUserDetails: DatabaseReference!
    var refCourses: DatabaseReference!
    
    var catch1 = ""
    var catch2 = ""
    var catch3 = ""

    
    var catch_username = ""
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
        playerController.view.frame = CGRect(x: 46, y: 424, width: 280, height: 180 )
        
        player.play()
    }
    
    func stopVideo()
    {
        player.pause()
    }
    
    @IBAction func playurlvideo(_ sender: UIButton)
    {
        playVideo()
    }
    
    
    
    
    @IBAction func back(_ sender: UIButton)
    {
        performSegue(withIdentifier: "back", sender: self)
    }
    
    @IBAction func fullcourse(_ sender: UIButton)
    {
        
        
        performSegue(withIdentifier: "FullViewController", sender: sender)
    }
    
    
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var courseDesc: UILabel!
    @IBOutlet weak var coursePic: UIImageView!
    
    override func viewDidLoad()
    {
        refUserDetails = Database.database().reference().child("UserDetails")
        
        refUserDetails.observe(DataEventType.value, with: {(snapshot) in
            for UserDetails in snapshot.children.allObjects as! [DataSnapshot]
            {
                let userobj = UserDetails.value as? [String: AnyObject]
                if((userobj?["username"] as! String) == self.catch_username)
                {
                    print("&&&&&&&&&&&&&&&&&")
                    //let name = userobj?["name"] as! String
                    var ce = userobj?["cenroll"] as! integer_t
                    ce = ce + 1
                    
                    //update value to database
                    
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
                if(coname == self.catch1)
                {
                    self.urlvideo = userobject?["CourseVideo"] as! String
                    print(self.urlvideo)
                }
                
            }
        })
        
        super.viewDidLoad()
        
        courseName.text = catch1
        courseDesc.text = catch2
        let imgurl = catch3
        
        let imgUrls:URL = URL(string: imgurl)!
        
        // Start background thread so that image loading does not make app unresponsive
        DispatchQueue.global(qos: .userInitiated).async
        {
            
            let imageData:NSData = NSData(contentsOf: imgUrls)!
            let imageView = UIImageView(frame: CGRect(x:18, y:100, width:120, height:100))
            //imageView.center = self.view.center
            
            // When from background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async
            {
                let  image = UIImage(data: imageData as Data)
                imageView.image = image
                imageView.contentMode = UIView.ContentMode.scaleAspectFit
                self.view.addSubview(imageView)
            }
        /* let picurl:URL = URL(fileURLWithPath: imgurl)
        let data = try? Data(contentsOf: picurl)
        if let imgdata = data {
            coursePic.image = UIImage(data: imgdata)
        }
        DispatchQueue.global(qos: .userInitiated).async {
            let imgdata:NSData = NSData(contentsOf: picurl)!
            
        } */
        
        // Do any additional setup after loading the view.
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FullViewController"
        {
            
            catcha = catch1
            catchb = catch2
            catchc = catch3
            catch_usname = catch_username
            
            
        }
    }

}
