//
//  LoginVC.swift
//  BreakpointApp_Firebase
//
//  Created by Nguyen Hieu Trung on 5/10/18.
//  Copyright © 2018 NHTSOFT. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var txtEmail: InsetTextView!
    @IBOutlet weak var txtPassword: InsetTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func PressCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil);
    }
    
    @IBAction func PressSignIn(_ sender: UIButton) {
        print("Email: \(txtEmail.text)");
        print("Pass: \(txtPassword.text)");
        if txtEmail.text! == "" ||  txtEmail.text! == nil{
            print("Vui lòng nhập email");
            return;
        }
        if txtPassword.text! == "" || txtPassword.text! == nil {
            print("Vui lòng nhập Password");
            return;
        }
        
        AuthService.instant.loginUser(withEmail: txtEmail.text!, password: txtPassword.text!) { (success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
            }else{
                print("Đăng nhập thất bại: \(error?.localizedDescription)");
            }
            
            AuthService.instant.CreateUser(withEmail: self.txtEmail.text!, password: self.txtPassword.text!, completion: { (createSuccess, createError) in
                if createSuccess{
                    AuthService.instant.loginUser(withEmail: self.txtEmail.text!, password: self.txtPassword.text!, completion: { (loginSuccess, loginError) in
                        if loginSuccess{
                            print("Đăng nhập sau khi đăng ký thành công");
                            self.dismiss(animated: true, completion: {
                                
                            })
                        }
                    })
                }else{
                    print("Đăng ký thất bại: \(createError?.localizedDescription)");
                }
            })
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
