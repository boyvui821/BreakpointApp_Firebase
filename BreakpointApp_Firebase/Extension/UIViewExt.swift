//
//  UIViewExt.swift
//  BreakpointApp_Firebase
//
//  Created by Nguyen Hieu Trung on 5/11/18.
//  Copyright © 2018 NHTSOFT. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func bindToKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil);
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification){
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double;
        var curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt;
        var beginFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue;
        var endFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue;
        let deltaY = endFrame.origin.y - beginFrame.origin.y;
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY;
        }, completion: nil)
    }
}
