//
//  UserCell.swift
//  BreakpointApp_Firebase
//
//  Created by Nguyen Hieu Trung on 5/14/18.
//  Copyright © 2018 NHTSOFT. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var imgCheck: UIImageView!
    var showing = false;
    
    func configureCell(profileImage image: UIImage, emailName:String, isSelected: Bool){
        self.imgProfile.image = image;
        self.lblEmail.text = emailName;
        if isSelected{
             self.imgCheck.isHidden = false;
        }else{
            self.imgCheck.isHidden = true;
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            if showing == false {
                imgCheck.isHidden = false;
                showing = true;
            }else{
                 imgCheck.isHidden = true;
                 showing = false;
            }
        }
        // Configure the view for the selected state
    }

}
