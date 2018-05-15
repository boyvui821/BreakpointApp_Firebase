//
//  CreateGroupVC.swift
//  BreakpointApp_Firebase
//
//  Created by Nguyen Hieu Trung on 5/14/18.
//  Copyright © 2018 NHTSOFT. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupVC: UIViewController {

    @IBOutlet weak var txtTitle: InsetTextView!
    @IBOutlet weak var txtDescription: InsetTextView!
    @IBOutlet weak var txtEmailSearch: InsetTextView!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var tableGroup: UITableView!
    @IBOutlet weak var lblGroupMember: UILabel!
    
    var arrEmail = [String]();
    var arrChoose = [String]();
    override func viewDidLoad() {
        super.viewDidLoad()
        tableGroup.dataSource = self;
        tableGroup.delegate = self;
        txtEmailSearch.delegate = self;
        txtEmailSearch.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged);
        // Do any additional setup after loading the view.
    }
    
    //Sự kiện live change textview
    @objc func textFieldDidChange(){
        if txtEmailSearch.text == ""{
            arrEmail = [];
            tableGroup.reloadData();
        }else{
            DataService.instant.getEmail(strQuery: txtEmailSearch.text!, completeHandle: { (arremail) in
                self.arrEmail = arremail as! [String];
                self.tableGroup.reloadData();
            })
        }
    }

    @IBAction func PressClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil);
    }
    
    @IBAction func PressDone(_ sender: UIButton) {
        if txtTitle.text != "" && txtDescription.text != ""{
            DataService.instant.getIds(forUserName: self.arrChoose) { (arrIDs) in
                var userIDs = arrIDs;
                userIDs.append((Auth.auth().currentUser?.uid)!);
                print(userIDs);
                
                DataService.instant.createGroup(withTitle: self.txtTitle.text!, Description: self.txtDescription.text!, forUserID: arrIDs, handler: { (success) in
                    if success{
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        print("Lỗi không thể tạo group");
                    }
                })
            }
        }
        
        
        
    }
}

//MARK: -TABLE VIEW GROUP MEMBER
extension CreateGroupVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEmail.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserReuseCell", for: indexPath) as! UserCell;
        let profileImage = UIImage(named: "defaultProfileImage");
        let email = arrEmail[indexPath.row];
        
        if arrChoose.contains(arrEmail[indexPath.row]){
            cell.configureCell(profileImage: profileImage!, emailName: email, isSelected: true);
        }else{
            cell.configureCell(profileImage: profileImage!, emailName: email, isSelected: false);
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath");
//        let cell = tableView.dequeueReusableCell(withIdentifier: "UserReuseCell") as! UserCell;
        let cell = tableView.cellForRow(at: indexPath) as! UserCell;
        if(!arrChoose.contains(cell.lblEmail.text!)){
            arrChoose.append(cell.lblEmail.text!)
            lblGroupMember.text = arrChoose.joined(separator: ", ");
            btnDone.isHidden = false;
        }else{
            arrChoose = arrChoose.filter({$0 != cell.lblEmail.text!})
            if(arrChoose.count > 0){
                lblGroupMember.text = arrChoose.joined(separator: ", ");
                btnDone.isHidden = false;
            }else{
                lblGroupMember.text = "Add people to your group";
                btnDone.isHidden = true;
            }
        }
        //print(arrChoose)
    }
}

extension CreateGroupVC:UITextFieldDelegate{
    
}








