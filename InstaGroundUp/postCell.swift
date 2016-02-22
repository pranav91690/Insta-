//
//  postCell.swift
//  InstaGroundUp
//
//  Created by Pranav Achanta on 2/21/16.
//  Copyright © 2016 pranav. All rights reserved.
//

import UIKit

class postCell: UITableViewCell {
    
    
    // Outlets
    @IBOutlet weak var postPhoto: UIImageView!
    @IBOutlet weak var postCaption: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
