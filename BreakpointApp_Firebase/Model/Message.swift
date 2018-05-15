//
//  Message.swift
//  BreakpointApp_Firebase
//
//  Created by Nguyen Hieu Trung on 5/11/18.
//  Copyright © 2018 NHTSOFT. All rights reserved.
//

import Foundation

class Message{
    private var _content:String
    private var _senderID: String
    
    var content:String{
        return _content;
    }
    
    var senderID:String{
        return _senderID;
    }
    
    init(content:String, senderid: String){
        self._content = content;
        self._senderID = senderid;
    }
}
