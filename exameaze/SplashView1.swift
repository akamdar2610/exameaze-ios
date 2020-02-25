//
//  SplashView1.swift
//  exameaze
//
//  Created by admin on 04/06/19.
//  Copyright © 2019 ACE. All rights reserved.
//

import UIKit

class SplashView1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
            self.performSegue(withIdentifier: "viewSplash", sender: nil)
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
