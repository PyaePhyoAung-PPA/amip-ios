//
//  ChangePasswordViewController.swift
//  amip-ios
//
//  Created by Administrator on 12/8/17.
//  Copyright © 2017 Thuriya ACE Technology. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var oldPasswordMsg: UILabel!
    @IBOutlet weak var newPasswordMsg: UILabel!
    @IBOutlet weak var confirmPasswordMsg: UILabel!
    
    var oldPassword : String!
    var newPassword : String!
    var confirmPassword : String!
    var userInfo : User!
    override func viewDidLoad() {
        super.viewDidLoad()
        oldPasswordMsg.isHidden = true
        newPasswordMsg.isHidden = true
        confirmPasswordMsg.isHidden = true
        self.userInfo = Global.sharedGlobal.user
        nameTextField.text = userInfo?.usercode
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackToHome(_ sender: Any) {
        let home: UITabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        home.selectedIndex = 0
        OperationQueue.main.addOperation {
            self.present(home, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func changePassword(_ sender: Any) {
        self.oldPassword = oldPasswordTextField.text
        self.newPassword = newPasswordTextField.text
        self.confirmPassword = confirmPasswordTextField.text
        viewDidLoad()
        if (ValidateForm() == true ) {
            print ("Success")
        }
        
    }
    func ValidateForm() -> Bool {
        var isValidate : Bool = true
        if (oldPassword == nil || oldPassword.isEmpty){
            oldPasswordMsg.isHidden = false
            isValidate = false
        }
        if (newPassword == nil || newPassword.isEmpty){
            newPasswordMsg.isHidden = false
            isValidate = false
        }
        if (confirmPassword == nil || confirmPassword.isEmpty) {
            confirmPasswordMsg.isHidden = false
            isValidate = false
        }
        if (oldPassword != self.userInfo.password ) {
            oldPasswordMsg.text = "Old Password not match."
            oldPasswordMsg.isHidden = true
        }
        if (newPassword != confirmPassword) {
            confirmPasswordMsg.text = "New Password and Confirm Password not match."
            confirmPasswordMsg.isHidden = false
            isValidate = false
        }
        return isValidate
    }

}
