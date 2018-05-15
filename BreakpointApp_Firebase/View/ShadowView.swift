//
//  ShadowView.swift
//  BreakpointApp_Firebase
//
//  Created by Nguyen Hieu Trung on 5/10/18.
//  Copyright © 2018 NHTSOFT. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    func setupView(){
        self.layer.shadowOpacity = 0.75;
        self.layer.shadowRadius = 5;
        self.layer.shadowColor = UIColor.black.cgColor;
    }
    
    override func awakeFromNib() {
        setupView();
        super.awakeFromNib();
    }

}
