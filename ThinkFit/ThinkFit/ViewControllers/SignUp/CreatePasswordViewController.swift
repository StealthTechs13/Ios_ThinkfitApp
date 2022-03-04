//
//  CreatePasswordViewController.swift
//  ThinkFit
//
//  Created by stealth tech on 17/08/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class CreatePasswordViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reenterPasswordTextField: UITextField!
    @IBOutlet weak var passwordHideView: UIView!
    @IBOutlet weak var passwordHideLbl: UILabel!
    
    @IBOutlet weak var passwordHideUnhideButton: UIButton!
    @IBOutlet weak var reEnterPasswordHideUnhideButton: UIButton!
    @IBOutlet weak var reenterPasswordHideView: UIView!
    @IBOutlet weak var reenterPasswordHideLbl: UILabel!
    
    @IBOutlet weak var noticeView: UIView!
    
    //MARK:- Define Variable
    var userName = ""
    var userEmail = ""
    var userDateOfBirth = ""
    var userGender = ""
    var saveUserData = [signUpModel]()
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.delegate = self
        reenterPasswordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        passwordTextField.text = ""
        reenterPasswordTextField.text = ""
        passwordHideView.isHidden = true
        reenterPasswordHideView.isHidden = true
        
        setTexfieldColor()
    }
    
    
    //MARK:- Function Setup
    func setTexfieldColor(){
        passwordTextField.placeHolderColor = #colorLiteral(red: 0.662745098, green: 0.662745098, blue: 0.662745098, alpha: 1)
        reenterPasswordTextField.placeHolderColor = #colorLiteral(red: 0.662745098, green: 0.662745098, blue: 0.662745098, alpha: 1)
    }
    
    //MARK:- UIButton Actions
    @IBAction func signUpButtonAction(_ sender: Any) {
        
        if passwordTextField.text! == "" {
            passwordHideView.isHidden = false
            passwordHideLbl.text = "Please enter your password"
            //Toast.show(message: "Please enter your password", controller: self)
        }
        else if passwordTextField.text!.count < 4 {
            passwordHideView.isHidden = false
            passwordHideLbl.text = "please enter minimum 4 digit password"
        }
//        else if !isValidPassword(passwordTextField.text!){
//            passwordHideView.isHidden = false
//            passwordHideLbl.text = "Minimum Password length is 8 character includes a lower case letter , an upper case letter, a special character and no whitespace allowed. e.g (Thinkfit@1234!!)"
//            
//            //Toast.show(message:, controller: self)
//        }
        else if reenterPasswordTextField.text! == ""{
            reenterPasswordHideView.isHidden = false
            passwordHideView.isHidden = true
            reenterPasswordHideLbl.text = "enter your confirm password"
            //Toast.show(message: " ", controller: self)
        }
        else if passwordTextField.text! != reenterPasswordTextField.text! {
            reenterPasswordHideView.isHidden = false
            reenterPasswordHideLbl.text = "password Dose'nt Match"
           // Toast.show(message: "password Dose'nt Match", controller: self)
        }
            
        else{
            signUpUserApi()
           // Toast.show(message: "All Good", controller: self)
        }
       // noticeView.isHidden = false
    }
    
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        
        let passPred = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passPred.evaluate(with: password)
    }
    
    
    /*** Back to Previous Button Action ***/
    @IBAction func backArrowButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    /*** Password Hide Unhide Button Action ***/
    @IBAction func passwordHideUnhideButtonAction(_ sender: Any) {
        if passwordHideUnhideButton.tag == 0 {
            passwordHideUnhideButton.tag = 1
            passwordHideUnhideButton.setImage(UIImage(named: "icUnhidePassword"), for: .normal)
            passwordTextField.isSecureTextEntry = false
        }else{
            passwordHideUnhideButton.tag = 0
            passwordHideUnhideButton.setImage(UIImage(named: "icHidePassword"), for: .normal)
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    
    /*** Re-Enter Password Hide Unhide Button Action ***/
    @IBAction func reEnterPasswordHideUnhideButtonAction(_ sender: Any) {
        if reEnterPasswordHideUnhideButton.tag == 0 {
            reEnterPasswordHideUnhideButton.tag = 1
            reEnterPasswordHideUnhideButton.setImage(UIImage(named: "icUnhidePassword"), for: .normal)
            reenterPasswordTextField.isSecureTextEntry = false
        }else{
            reEnterPasswordHideUnhideButton.tag = 0
            reEnterPasswordHideUnhideButton.setImage(UIImage(named: "icHidePassword"), for: .normal)
            reenterPasswordTextField.isSecureTextEntry = true
        }
    }
    
    
    /*** Notice Continue Button Action ***/
    @IBAction func noticeContinueButton(_ sender: Any) {
        noticeView.isHidden = true
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    /*** ReSend Button Action ***/
    @IBAction func resendButtonAction(_ sender: Any) {
        sendActivateLinkAccount(emailID: GlobalVariabel.userEmail)
    }
    
}


//MARK:- UITextField Delegate
extension CreatePasswordViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if passwordTextField.isEditing == true {
            
            passwordHideView.isHidden = true
            
        }
        else if reenterPasswordTextField.isEditing == true{
            reenterPasswordHideView.isHidden = true
        }
        else{
            passwordHideView.isHidden = false
            reenterPasswordHideView.isHidden = false
        }
    }
    
}

//MARK:- Calling API'S
extension CreatePasswordViewController {
    
    /*** SignUp User API ***/
    func signUpUserApi(){
        self.showIndicator()
        
        DataService.sharedInstance.signUp(name: userName, dob: userDateOfBirth, emailId: userEmail, deviceToken: GlobalVariabel.firebase_token, password: passwordTextField.text!, gender: userGender) { (resultDict, errorMsg) in
            
            self.hideIndicator()
            
            print(resultDict as Any)
            
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool {
                    if status == true {
                        
                        if let result = resultDict?["result"] as? NSDictionary {
                            
                            
                            if let user_id = result["id"] as? Int {
                                //let email_verified = result["email_varified"] as? Int
                                let user_name = result["name"] as? String
                                let user_email = result["email"] as? String
                                //let device_token = result["dev_token"] as? String
                                //let user_gender = result["gender"] as? String
                                //let user_dob = result["dob"] as? String
                                //let updated_at = result["updatedAt"] as? String
                                //let create_at = result["createdAt"] as? String
                                //let step_one = result["step1"] as? Int
                                //let step_two = result["step2"] as? Int
                                //let step_three = result["step3"] as? Int
                                //let step_four = result["step4"] as? Int
                                //let step_five = result["step5"] as? Int
                                //let step_six = result["step6"] as? Int
                                
                                GlobalVariabel.userId = String(user_id)
                                GlobalVariabel.userEmail = user_email ?? ""
                                GlobalVariabel.userName = user_name ?? ""
                                
                                self.sendActivateLinkAccount(emailID: user_email ?? "")
        
                            }
                        }
                    }
                    else{
                        if let message = resultDict?["message"] as? String {
                            Toast.show(message: message, controller: self)
                        }
                    }
                }
                
            }
            else{
                self.alert(message: "Something went wrong", title: "")
//                if let message = resultDict?["message"] as? String {
//                    Toast.show(message: message, controller: self)
//                }
            }
        }
    }
    
    
    /*** Send Active Link Account ***/
    func sendActivateLinkAccount(emailID: String){
        
        DataService.sharedInstance.sendActiveLink(userID: GlobalVariabel.userId, emailId: emailID) { (resultDict, errorMsg) in
            
            print(resultDict as Any)
            
            if errorMsg == nil {
                if let status = resultDict?["status"] as? Bool{
                    if status == true {
                        
                        self.noticeView.isHidden = false
                    }
                    else{
                        if let message = resultDict?[""] as? String{
                            Toast.show(message: message, controller: self)
                        }
                    }
                }
            }
            else{
                if let message = resultDict?[""] as? String{
                    Toast.show(message: message, controller: self)
                }
            }
        }
    }
}
