	//
//  LoginViewController.swift
//  Tabbed Library
//
//  Created by aceplus on 11/27/17.
//  Copyright © 2017 Thuriya ACE Technology. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordField: UITextField!
    @IBOutlet weak var nameRequired: UILabel!
    @IBOutlet weak var passwordRequired: UILabel!
     
    var userName: String!
    var password: String!
    //let singleton = Global.sharedGlobal

    override func viewDidLoad() {
        super.viewDidLoad()
        let emailIcon = UIImageView();
        let emailIconImage = UIImage(named:"ic_logout");
        emailIcon.image=emailIconImage
      //  emailIcon.backgroundColor= 
        
        
        /*userNameTextField.leftView = emailIcon;
        userNameTextField.leftViewMode = UITextFieldViewMode.always;
        userNameTextField.leftView = emailIcon
        userNameTextField.leftView?.frame = CGRect(x: 0, y: 5, width: 20 , height:20)
        userNameTextField.leftViewMode = .always
        nameRequired.isHidden = true
        passwordRequired.isHidden = true */
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginProcess(_ sender: Any) {
        self.userName = userNameTextField.text
        self.password = userPasswordField.text
        let url = NSURL(string: "http://192.168.11.200:4040/amip/ws/checkUserLogin")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        viewDidLoad()
        if (ValidateForm() == false )
        {
            return
        }
        else {
        //if Reachability.isConnectedToNetwork() == false {
        //    OperationQueue.main.addOperation {
        //        self.displayAlertMessage(userMessage: "Please Check Your Internet Connections")
        //    }
        //    return
            
        //}
        let params = ["usercode":userName, "password":password] as NSObject
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: (request as URLRequest), completionHandler: {(data,response,error) -> Void in
            if error != nil {
                OperationQueue.main.addOperation {
                    self.displayAlertMessage(userMessage: "Server Error!")
                }
                return
            }
           /* if let safeData = data{
                print("response: \(String(describing: String(data:safeData, encoding:.utf8)))")
            } */
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!,options: .allowFragments) as? NSObject {

                let status = jsonObj!.value(forKey: "status") as? String
                print (status! )
                if (status == "Login Success") {
      
                    //let userInfo = User.init(usercode:self.userName!,password:self.password!,status:status!)
                    //self.singleton.user = userInfo
                    let home: UITabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
                    home.selectedIndex = 0
                    OperationQueue.main.addOperation {
                    self.present(home, animated: true, completion: nil)
                    }
                  
                }
                if (status == "Login Fail") {
                    OperationQueue.main.addOperation {
                    self.displayAlertMessage(userMessage: "User Name and Password do not match!")
                    return
                    }
                }
                if (status == "Account is Disabled") {
                    OperationQueue.main.addOperation {
                    self.displayAlertMessage(userMessage: "User Account is Disabled.")
                        return
                    }
                }
            }
            })
        .resume()
        }
        
    }
    func displayAlertMessage (userMessage:String) {
        let myAlert = UIAlertController(title:"Error", message:userMessage, preferredStyle:UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        myAlert.addAction(okAction);
        self.present(myAlert,animated: true,completion: nil)
    }
   func ValidateForm() -> Bool {
    var isValidate : Bool = true
        if (userName == nil || (userName?.isEmpty)!) {
            nameRequired.isHidden = false
            isValidate = false
        }
        if (password == nil || (password?.isEmpty)!) {
            passwordRequired.isHidden = false
            isValidate = false
        }
    return isValidate
    }
  

}
