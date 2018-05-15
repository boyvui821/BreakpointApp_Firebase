//
//  CreatePostVC.swift
//  BreakpointApp_Firebase
//
//  Created by Nguyen Hieu Trung on 5/11/18.
//  Copyright © 2018 NHTSOFT. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtContent: UITextView!
    @IBOutlet weak var btnSend: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtContent.delegate = self;
        self.btnSend.bindToKeyboard();
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.lblEmail.text = Auth.auth().currentUser?.email;
    }

    @IBAction func PressClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil);
    }
    @IBAction func PressSend(_ sender: UIButton) {
        if txtContent.text != nil && txtContent.text != "Say some thing here..." {
            btnSend.isEnabled = false;
            DataService.instant.uploadPost(withMessage: txtContent.text, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil, sendComplete: { (isSuccess) in
                if isSuccess{
                    self.btnSend.isEnabled = true;
                    self.dismiss(animated: true, completion: nil);
                }else{
                    self.btnSend.isEnabled = true;
                    print("Có lỗi khi send post message");
                }
            })
        }else{
            
        }
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

extension CreatePostVC:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = "";
    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if(text == "\n") {
//            textView.resignFirstResponder()
//            return false
//        }
//        return true
//    }
}
















