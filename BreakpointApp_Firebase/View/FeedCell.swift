//
//  FeedCell.swift
//  BreakpointApp_Firebase
//
//  Created by Nguyen Hieu Trung on 5/11/18.
//  Copyright © 2018 NHTSOFT. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var lblMessage: UILabel!
    
    func configCell(image:UIImage, email:String, message:String){
        self.imgProfile.image = image;
        self.lblEmail.text = email;
        self.lblMessage.text = message;
    }
}
