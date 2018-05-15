//
//  GroupCell.swift
//  BreakpointApp_Firebase
//
//  Created by Nguyen Hieu Trung on 5/15/18.
//  Copyright © 2018 NHTSOFT. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblMember: UILabel!
    
    func configureCell(withTitle title:String, andDescription description:String, memberCount count: Int){
        self.lblTitle.text = title;
        self.lblDescription.text = description;
        self.lblMember.text = "\(count) Members";
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
