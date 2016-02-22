//
//  uploadViewController.swift
//  InstaGroundUp
//
//  Created by Pranav Achanta on 2/21/16.
//  Copyright © 2016 pranav. All rights reserved.
//

import UIKit

class uploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let userMedia = UserMedia()
    
    // Outlets
    @IBOutlet weak var captionLabel: UITextField!
    @IBOutlet weak var uploadedImageView: UIImageView!
    @IBOutlet weak var directionLabel: UILabel!
    
    
    // Actions
    @IBAction func onSubmit(sender: AnyObject) {
        //Show the Activity HUD here-->
        
        // Upload the Image to Parse Backend
        UserMedia.postUserImage(uploadedImageView.image!, withCaption: captionLabel.text!) { (success, error) -> Void in
            if success{
                print("Success!!")
                self.tabBarController?.selectedIndex = 1
                let vc = self.tabBarController?.selectedViewController as! homeViewController
                vc.getData()
            }else{
                print(error?.localizedDescription)
            }
        }
        
        // Go the Home timeline --> How to navigate to that view??
    }
    
    @IBAction func onTap(sender: AnyObject) {
        //Instantiate the Image Picker Controller
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func onScreenTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadedImageView.hidden = true
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Delegate Methods
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            self.directionLabel.hidden = true
            self.uploadedImageView.hidden = false
            self.dismissViewControllerAnimated(true, completion: nil)
            
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            let editedImage = resize(originalImage, newSize: CGSize(width: 500, height: 500))
            
            // Set the Original Image
            uploadedImageView.image = originalImage
    }
    

    // Resize the Image to below 10mb
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
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
