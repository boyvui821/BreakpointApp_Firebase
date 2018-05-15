//
//  InsetTextView.swift
//  BreakpointApp_Firebase
//
//  Created by Nguyen Hieu Trung on 5/10/18.
//  Copyright © 2018 NHTSOFT. All rights reserved.
//

import UIKit

class InsetTextView: UITextField {

    private var textRectOffset:CGFloat = 20;
    private var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    
    //CANH CHỈNH LẠI ALIGMENT CỦA PLACEHOLDER CŨNG NHƯ TEXT BÊN TRONG
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding);
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding);
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding);
    }
    ///////////////////////////////////////////////////////////////////
    
    //ĐỒI MÀU CHỮ PLACEHOLDER
    func setupView(){
        var placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor:UIColor.white]);
        
        self.attributedPlaceholder = placeholder;
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib();
        setupView(); 
    }

}
