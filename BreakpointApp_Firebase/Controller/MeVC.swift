//
//  MeVC.swift
//  BreakpointApp_Firebase
//
//  Created by Nguyen Hieu Trung on 5/11/18.
//  Copyright © 2018 NHTSOFT. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var tableMe: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.lblEmail.text = Auth.auth().currentUser?.email;
    }

    @IBAction func PressLogOut(_ sender: UIButton) {
        let logoutPopup = UIAlertController(title: "LOG OUT", message: "Do you want to log out?", preferredStyle: .alert);
        let action = UIAlertAction(title: "OK", style: .destructive) { (action) in
            do{
                try Auth.auth().signOut()
                guard let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC else {return};
                
                self.present(authVC, animated: true, completion: nil);
                
            }catch{
                print("Log Out thất bại")
                print(error);
            }
        }
        logoutPopup.addAction(action);
        present(logoutPopup, animated: true, completion: nil);
        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
