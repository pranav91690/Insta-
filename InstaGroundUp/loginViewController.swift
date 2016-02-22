//
//  loginViewController.swift
//  InstaGroundUp
//
//  Created by Pranav Achanta on 2/21/16.
//  Copyright © 2016 pranav. All rights reserved.
//

import UIKit
import Parse

class loginViewController: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    
    // Actions
    
    @IBAction func onScreenTap(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func onSignIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameLabel.text!, password: passwordLabel.text!) { (user : PFUser?, error : NSError?) -> Void in
            if(user != nil){
                // transition to the next screen
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
        }
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        // Handle empty fields here-->
        let newUser = PFUser()
        newUser.username = usernameLabel.text!
        newUser.password = passwordLabel.text!
        
        // Completion block for signup!
        newUser.signUpInBackgroundWithBlock { (success : Bool, error : NSError?) -> Void in
            if success{
                // transition to the next screen
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }else{
                print(error?.localizedDescription)
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
