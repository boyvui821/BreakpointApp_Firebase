//
//  DataService.swift
//  BreakpointApp_Firebase
//
//  Created by Nguyen Hieu Trung on 5/10/18.
//  Copyright © 2018 NHTSOFT. All rights reserved.
//

import Foundation
import FirebaseDatabase

let DB_BASE = Database.database().reference();
let dbConnectStr = "https://breakpointfirebase.firebaseio.com/";

class DataService{
    static let instant = DataService();
    
    private var _REF_BASE = DB_BASE;
    private var _REF_USERS = DB_BASE.child("users");
    private var _REF_GROUPS = DB_BASE.child("groups");
    private var _REF_FEEDS = DB_BASE.child("feeds");
    
    var REF_BASE: DatabaseReference{
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference{
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference{
        return _REF_GROUPS
    }
    
    var REF_FEEDS: DatabaseReference{
        return _REF_FEEDS
    }
    
    func createDBuser(uid:String, userData: Dictionary<String,Any>){
        REF_USERS.child(uid).updateChildValues(userData);
        //REF_USERS.child(uid).setValue(userData);
    }
    
    func getUserName(forUID uid:String, handle: @escaping (_ userName:String)->()){
        REF_USERS.observeSingleEvent(of: .value) { (datasnapshot) in
            guard let snap = datasnapshot.children.allObjects as? [DataSnapshot] else{ return};
            for user in snap{
                if user.key == uid{
                    var username = user.childSnapshot(forPath: "email").value as! String;
                    handle(username);
                }
            }
        }
    }
    
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupkey: String?, sendComplete: @escaping (_ status: Bool)->()){
        if groupkey != nil{
            
        }else{
            var dataPost = ["content":message, "senderID": uid];
            REF_FEEDS.childByAutoId().updateChildValues(dataPost);
            sendComplete(true);
        }
    }
    
    func getAllFeedMessage(handle: @escaping (_ messages: [Message])->()){
        var messageArray = [Message]();
        self.REF_FEEDS.observeSingleEvent(of: DataEventType.value) { (datasnapshot) in
            guard let snap = datasnapshot.children.allObjects as? [DataSnapshot]  else {return}
            for message in snap{
                var content = message.childSnapshot(forPath: "content").value as? String;
                var senderID = message.childSnapshot(forPath: "senderID").value as? String;
                messageArray.append(Message(content: content!, senderid: senderID!));
            }
            handle(messageArray);
        }
    }
    
    func getEmail(strQuery query: String, completeHandle: @escaping ([Any])->()){
        var arrEmail = [String]();
        REF_USERS.observe(.value) { (datasnapshot) in
            guard let snapshot = datasnapshot.children.allObjects as? [DataSnapshot] else{return}
            for user in snapshot{
                var email = user.childSnapshot(forPath: "email").value as! String;
                print(email)
                if email.contains(query) == true{
                    arrEmail.append(email);
                }
            }
            completeHandle(arrEmail);
        }
    }
    
    func getIds(forUserName usernames:[String], handler: @escaping ([String])->()){
        var arrID = [String]();
        REF_USERS.observe(.value) { (datasnapshot) in
            guard let snapshot = datasnapshot.children.allObjects as? [DataSnapshot] else {return};
            for user in snapshot{
                let email = user.childSnapshot(forPath: "email").value as? String;
                if usernames.contains(email!) == true {
                    arrID.append(user.key)
                }
            }
            handler(arrID);
        }
    }
    
    func createGroup(withTitle title:String,  Description description: String, forUserID ids: [String], handler: (_ groupCreated:Bool)->()){
        var dataGroup = ["title": title, "description": description, "members": ids] as [String : Any];
        REF_GROUPS.childByAutoId().updateChildValues(dataGroup);
        handler(true);
    }
    
    func getAllGroups(completeHandler: @escaping ([Group])->()){
        var arrGroups = [Group]();
        REF_GROUPS.observeSingleEvent(of: .value) { (datasnapshot) in
            guard let snapshot = datasnapshot.children.allObjects as? [DataSnapshot] else{return}
            for group in snapshot{
                var title = group.childSnapshot(forPath: "title").value as! String;
                var desc = group.childSnapshot(forPath: "description").value as! String;
                var key = group.key;
                var members = group.childSnapshot(forPath: "members").value as! [String];
                print(members);
                arrGroups.append(Group(title: title, desc: desc, key: key, members: members, memberCount: members.count));
            }
            completeHandler(arrGroups);
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
