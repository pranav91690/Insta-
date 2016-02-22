//
//  profileViewController.swift
//  InstaGroundUp
//
//  Created by Pranav Achanta on 2/21/16.
//  Copyright © 2016 pranav. All rights reserved.
//

import UIKit
import Parse

class profileViewController: UIViewController {

    //Actions
    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock { (error) -> Void in
            if(error != nil){
                print(error!.localizedDescription)
            }else{
                self.performSegueWithIdentifier("logoutSegue", sender: nil)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
