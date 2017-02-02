//
//  CustomTableViewCell.swift
//  HelloUITableview
//
//  Created by Sushant Sahu on 02/02/17.
//  Copyright © 2017 Sushant Sahu. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelAddress: UILabel!
    
    @IBOutlet weak var imageProfile: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    
    

}
