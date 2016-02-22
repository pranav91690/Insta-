//
//  homeViewController.swift
//  InstaGroundUp
//
//  Created by Pranav Achanta on 2/21/16.
//  Copyright © 2016 pranav. All rights reserved.
//

import UIKit
import Parse

class homeViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    var posts : [PFObject]?
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    let HeaderViewIdentifier = "TableViewHeaderView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)
        
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData(){
        // query the Initial posts and relaod the tableview
        let query = PFQuery(className: "UserMedia")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media {
                // do something with the data fetched
                self.posts = media
                self.tableView.reloadData()
            } else {
                // handle error
                print(error?.localizedDescription)
            }
        }
    }
    
    // TableViewDelegates
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! postCell
        
        let post = posts![indexPath.row]
        
        cell.postCaption.text = post["caption"] as? String
        let userImageFile = post["media"] as! PFFile
        userImageFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell.postPhoto.image = image!
                }
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = self.posts{
            return posts.count
        }else{
            return 0
        }
    }
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        if let posts = self.posts{
//            return posts.count
//        }else{
//            return 0
//        }
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier("TableViewHeaderView")! as UITableViewHeaderFooterView
//         header.textLabel!.text = PFUser.currentUser()?.username!
//        return header
//    }
//    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 30
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
