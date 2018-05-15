//
//  AuthService.swift
//  BreakpointApp_Firebase
//
//  Created by Nguyen Hieu Trung on 5/10/18.
//  Copyright © 2018 NHTSOFT. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthService{
    static let instant = AuthService();
    
    func CreateUser(withEmail email: String, password pass: String, completion: @escaping (_ status:Bool, _ error:Error?)->()){
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            guard let user = user else{
                completion(false, error)
                return;
            }
            var userData = ["provider": user.providerID, "email": email, "password": pass];
            DataService.instant.createDBuser(uid: user.uid, userData: userData);
            
            completion(true,nil);
        }
    }
    
   func loginUser(withEmail email: String, password pass: String, completion: @escaping (_ status:Bool, _ error:Error?)->()){
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            guard let user = user else{
                completion(false, error)
                return;
            }
            completion(true,nil);
        }
    }
}
