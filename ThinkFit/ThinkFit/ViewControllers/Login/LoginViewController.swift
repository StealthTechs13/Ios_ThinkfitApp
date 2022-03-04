//
//  LoginViewController.swift
//  ThinkFit
//
//  Created by stealth tech on 17/08/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameWarningView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordWarningView: UIView!
    @IBOutlet weak var passwordHIdeUnhideButton: UIButton!
    @IBOutlet weak var warningEmailLbl: UILabel!
    
    //MARK:- Define Variable
    var userInfoDetail = [UserInfoDatailModel]()
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        passwordTextField.delegate = self
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(getGoogleSignInData(notification:)), name: Notification.Name("GoogleSign"), object: nil)
        
    }
    
    //MARK:- This Object Function to Get Google User credentials Using Notifcation
    @objc func getGoogleSignInData(notification: Notification){
        
        if let dict = notification.userInfo as NSDictionary? {
            if let email = dict["email"] as? String{
                if let dob = dict["dob"] as? String {
                    if let name = dict["name"] as? String{
                        if let gender = dict["gender"] as? String{
                            socialGoogleSignUp(email: email, name: name, dob: dob, gender: gender)
                        }
                    }
                }
            }
        }
    }
    
    //MARK:- View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        navigationSetup()
        setTexfieldColor()
    }
    
    
    //MARK:- Navigation Setup
    func navigationSetup(){
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        //title = "Terms & Conditions"
        
        /*** Navigation LeftBar Button ***/
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "icBackArrowWhite"), style: .done, target: self, action: #selector(self.icMenuButtonAction))
        self.navigationItem.leftBarButtonItem  = leftBarButton
    }
    
    //MARK:- Object Function Button Action
    @objc func icMenuButtonAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Function Working
    func checkTextFieldValidation(){
        
        if nameTextField.text == "" {
            nameWarningView.isHidden = false
            warningEmailLbl.text = "Please enter your email"
        }
        else if !isValidEmail(emailStr: nameTextField.text!){
            nameWarningView.isHidden = false
            warningEmailLbl.text = "Please enter your valid email"
        }
        else if passwordTextField.text == "" {
            passwordWarningView.isHidden = false
            nameWarningView.isHidden = true
        }
        else {
            passwordWarningView.isHidden = true
            nameWarningView.isHidden = true
            loginAccount()
            
        }
        
    }
    
    //MARK:- Validation Code
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    func setTexfieldColor(){
        passwordTextField.placeHolderColor = #colorLiteral(red: 0.662745098, green: 0.662745098, blue: 0.662745098, alpha: 1)
        nameTextField.placeHolderColor = #colorLiteral(red: 0.662745098, green: 0.662745098, blue: 0.662745098, alpha: 1)
    }
    
    //MARK:- UIButton Actions
    @IBAction func signInButtonAction(_ sender: Any) {
        checkTextFieldValidation()
    }
    
    /*** SignUp Button Action ***/
    @IBAction func signUpButtonAction(_ sender: Any) {
        self.navigationController?.backToViewController(vc: CreateAccountViewController.self)
        // self.navigationController?.popViewController(animated: true)
    }
    
    
    /*** Forgot Button Action ***/
    @IBAction func forgotButtonAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    /*** Password HideUnhide Button Action ***/
    @IBAction func passwordHideUnhideButton(_ sender: UIButton) {
        if passwordHIdeUnhideButton.tag == 0 {
            passwordHIdeUnhideButton.tag = 1
            passwordTextField.isSecureTextEntry = false
            passwordHIdeUnhideButton.setImage(#imageLiteral(resourceName: "icUnhidePassword"), for: .normal)
        }else {
            passwordHIdeUnhideButton.tag = 0
            passwordTextField.isSecureTextEntry = true
            passwordHIdeUnhideButton.setImage(#imageLiteral(resourceName: "icHidePassword"), for: .normal)
        }
    }
    
    
    /*** Google SignIn Button Action ***/
    @IBAction func googleSignInButton(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
}


//MARK:- TextField Delegate method
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if nameTextField.isEditing == true {
            nameWarningView.isHidden = true
        }
        
        if passwordTextField.isEditing == true {
            passwordWarningView.isHidden = true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if nameTextField.isEditing == true {
            nameWarningView.isHidden = true
        }
        
        if passwordTextField.isEditing == true {
            passwordWarningView.isHidden = true
        }
        
        return true
    }
}

/* API Setup */
extension LoginViewController {
    
    /*** Login Account API ***/
    func loginAccount(){
        self.showIndicator()
        DataService.sharedInstance.Login(emailId: nameTextField.text!, password: passwordTextField.text!, devToken: GlobalVariabel.firebase_token) { (resultDict, errorMsg) in
            
            self.hideIndicator()
            
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool {
                    if status == true {
                        
                        self.userInfoDetail.removeAll()
                        
                        if let result = resultDict?["result"] as? NSDictionary {
                            
                            if let user_Id = result["id"] as? Int {
                                let user_status = result["status"] as? Int
                                let user_name = result["name"] as? String
                                let user_email = result["email"] as? String
                                let user_gender = result["gender"] as? String
                                let user_dob = result["dob"] as? String
                                let user_login_type = result["login_type"] as? String
                                let user_device_type = result["device_type"] as? String
                                let user_intruption = result["interuption"] as? String
                                let user_default_time = Int(result["default_time"] as? String ?? "")
                                let user_dev_token = result["dev_token"] as? String
                                let user_token = result["token"] as? String
                                let user_forgot_token = result["forgot_token"] as? String
                                let user_create_at = result["createdAt"] as? String
                                let user_update_at = result["updatedAt"] as? String
                                let user_email_verified = result["email_varified"] as? String
                                let fitness_level = result["fitness_status"] as? String
                                let user_step_one = result["step1"] as? String
                                let user_step_two = result["step2"] as? String
                                let user_step_three = result["step3"] as? String
                                let user_step_four = result["step4"] as? String
                                let user_step_five = result["step5"] as? String
                                let user_step_six = result["step6"] as? String
                                
                                GlobalVariabel.userId = String(user_Id )
                                GlobalVariabel.userEmail = user_email ?? ""
                                GlobalVariabel.stepOne = user_step_one ?? ""
                                GlobalVariabel.stepTwo = user_step_two ?? ""
                                GlobalVariabel.stepThree = user_step_three ?? ""
                                GlobalVariabel.stepFour = user_step_four ?? ""
                                GlobalVariabel.stepFive = user_step_five ?? ""
                                GlobalVariabel.stepSix = user_step_six ?? ""
                                GlobalVariabel.userName = user_name ?? ""
                                UserDefaults.standard.set(user_email_verified ?? "", forKey: K_EmailVerified)
                                UserDefaults.standard.set(String(user_Id ), forKey: K_UserId)
                                UserDefaults.standard.set(user_email ?? "", forKey: K_UserEmail)
                                UserDefaults.standard.set(user_default_time, forKey: K_defaultTime)
                                UserDefaults.standard.set(fitness_level, forKey: K_Fitness_Level)
                                
                                UserDefaults.standard.set(user_step_one ?? "0", forKey: K_StepOne)
                                UserDefaults.standard.set(user_step_two ?? "0", forKey: K_StepTwo)
                                UserDefaults.standard.set(user_step_three ?? "0", forKey: K_StepThree)
                                UserDefaults.standard.set(user_step_four ?? "0", forKey: K_StepFour)
                                UserDefaults.standard.set(user_step_five ?? "0", forKey: K_StepFive)
                                UserDefaults.standard.set(user_step_six ?? "0", forKey: K_StepSix)
                                UserDefaults.standard.synchronize()
                                
                                self.userInfoDetail.append(UserInfoDatailModel.init(u_id: user_Id , status: user_status ?? 0, u_name: user_name ?? "", u_email: user_email ?? "", u_gender: user_gender ?? "", u_dob: user_dob ?? "", u_login_type: user_login_type ?? "", u_device_type: user_device_type ?? "", u_intruption: user_intruption ?? "", u_default_time: user_default_time ?? 0, u_dev_token: user_dev_token ?? "", u_token: user_token ?? "", u_foget_token: user_forgot_token ?? "", u_create_at: user_create_at ?? "", u_update_at: user_update_at ?? "", u_email_verified: user_email_verified ?? "", u_stepOne: user_step_one ?? "", u_stepTwo: user_step_two ?? "", u_stepThree: user_step_three ?? "", u_stepFour: user_step_four ?? "", u_stepFive: user_step_five ?? "", u_stepsix: user_step_six ?? ""))
                                
                                if user_email_verified == "0"{
                                    UserDefaults.standard.set("0", forKey: K_EmailVerified)
                                    UserDefaults.standard.synchronize()
                                    Toast.show(message: "Please activate your account by clicking on the link send to your email", controller: self)
                                }
                                
                                
                                if user_step_one == "0"{
                                    UserDefaults.standard.set("0", forKey: K_StepOne)
                                    UserDefaults.standard.synchronize()
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationSetTimeViewController") as! RegistrationSetTimeViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                else if user_step_two == "0" {
                                    UserDefaults.standard.set("0", forKey: K_StepTwo)
                                    UserDefaults.standard.synchronize()
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationDepartmentViewController") as! RegistrationDepartmentViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                else if user_step_three == "0"{
                                    UserDefaults.standard.set("0", forKey: K_StepThree)
                                    UserDefaults.standard.synchronize()
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationStrengthenQuestionViewController") as! RegistrationStrengthenQuestionViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                else if user_step_four == "0" {
                                    UserDefaults.standard.set("0", forKey: K_StepFour)
                                    UserDefaults.standard.synchronize()
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationQuestionClimbingViewController") as! RegistrationQuestionClimbingViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                else if user_step_five == "0" {
                                    UserDefaults.standard.set("0", forKey: K_StepFive)
                                    UserDefaults.standard.synchronize()
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationQuestionPushUpViewController") as! RegistrationQuestionPushUpViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                else if user_step_six == "0" {
                                    UserDefaults.standard.set("0", forKey: K_StepSix)
                                    UserDefaults.standard.synchronize()
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationQuestionWorkstationViewController") as! RegistrationQuestionWorkstationViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                else{
                                    //                                UserDefaults.standard.removeObject(forKey: K_StepOne)
                                    //                                UserDefaults.standard.removeObject(forKey: K_StepTwo)
                                    //                                UserDefaults.standard.removeObject(forKey: K_StepThree)
                                    //                                UserDefaults.standard.removeObject(forKey: K_StepFour)
                                    //                                UserDefaults.standard.removeObject(forKey: K_StepFive)
                                    //                                UserDefaults.standard.removeObject(forKey: K_StepSix)
                                    //                                UserDefaults.standard.synchronize()
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeMyTaskViewController") as! HomeMyTaskViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                
                            }
                        }
                    }
                    else{
                        // self.alert(message: "Something went wrong", title: "")
                        if let message = resultDict?["message"] as? String {
                            Toast.show(message: message, controller: self)
                        }
                    }
                }
            }else{
                //self.alert(message: "Something went wrong", title: "")
                if let message = resultDict?["message"] as? String {
                    Toast.show(message: message, controller: self)
                }
            }
        }
        
    }
    
    
    //**** Social Login ****//
    func socialGoogleSignUp(email: String, name: String, dob: String, gender: String){
        
        self.showIndicator()
        DataService.sharedInstance.socialLogin(email: email, login_type: "Google", device_type: "iOS", devToken: GlobalVariabel.device_token, dob: dob, name: name, gender: gender) { (resultDict, errorMsg) in
            
            self.hideIndicator()
            print(resultDict as Any)
            
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool {
                    if status == true {
                        
                        
                        
                        self.userInfoDetail.removeAll()
                        
                        if let result = resultDict?["result"] as? NSDictionary {
                            print(result)
                            
                            if let user_Id = result["id"] as? Int {
                                let user_status = result["status"] as? Int
                                let user_name = result["name"] as? String
                                let user_email = result["email"] as? String
                                let user_gender = result["gender"] as? String
                                let user_dob = result["dob"] as? String
                                let user_login_type = result["login_type"] as? String
                                let user_device_type = result["device_type"] as? String
                                let user_intruption = result["interuption"] as? String
                                let user_default_time = Int(result["default_time"] as? String ?? "")
                                let user_dev_token = result["dev_token"] as? String
                                let user_token = result["token"] as? String
                                let user_forgot_token = result["forgot_token"] as? String
                                let user_create_at = result["createdAt"] as? String
                                let user_update_at = result["updatedAt"] as? String
                                let user_email_verified = result["email_varified"] as? String
                                let user_step_one = result["step1"] as? String
                                let user_step_two = result["step2"] as? String
                                let user_step_three = result["step3"] as? String
                                let user_step_four = result["step4"] as? String
                                let user_step_five = result["step5"] as? String
                                let user_step_six = result["step6"] as? String
                                
                                GlobalVariabel.userId = String(user_Id )
                                GlobalVariabel.userEmail = user_email ?? ""
                                GlobalVariabel.stepOne = user_step_one ?? ""
                                GlobalVariabel.stepTwo = user_step_two ?? ""
                                GlobalVariabel.stepThree = user_step_three ?? ""
                                GlobalVariabel.stepFour = user_step_four ?? ""
                                GlobalVariabel.stepFive = user_step_five ?? ""
                                GlobalVariabel.stepSix = user_step_six ?? ""
                                GlobalVariabel.userName = user_name ?? ""
                                UserDefaults.standard.set(user_email_verified ?? "", forKey: K_EmailVerified)
                                UserDefaults.standard.set(String(user_Id ), forKey: K_UserId)
                                UserDefaults.standard.set(user_email ?? "", forKey: K_UserEmail)
                                
                                UserDefaults.standard.set(user_default_time, forKey: K_defaultTime)
                                
                                UserDefaults.standard.set(user_step_one ?? "0", forKey: K_StepOne)
                                UserDefaults.standard.set(user_step_two ?? "0", forKey: K_StepTwo)
                                UserDefaults.standard.set(user_step_three ?? "0", forKey: K_StepThree)
                                UserDefaults.standard.set(user_step_four ?? "0", forKey: K_StepFour)
                                UserDefaults.standard.set(user_step_five ?? "0", forKey: K_StepFive)
                                UserDefaults.standard.set(user_step_six ?? "0", forKey: K_StepSix)
                                UserDefaults.standard.synchronize()
                                
                                self.userInfoDetail.append(UserInfoDatailModel.init(u_id: user_Id , status: user_status ?? 0, u_name: user_name ?? "", u_email: user_email ?? "", u_gender: user_gender ?? "", u_dob: user_dob ?? "", u_login_type: user_login_type ?? "", u_device_type: user_device_type ?? "", u_intruption: user_intruption ?? "", u_default_time: user_default_time ?? 0, u_dev_token: user_dev_token ?? "", u_token: user_token ?? "", u_foget_token: user_forgot_token ?? "", u_create_at: user_create_at ?? "", u_update_at: user_update_at ?? "", u_email_verified: user_email_verified ?? "", u_stepOne: user_step_one ?? "", u_stepTwo: user_step_two ?? "", u_stepThree: user_step_three ?? "", u_stepFour: user_step_four ?? "", u_stepFive: user_step_five ?? "", u_stepsix: user_step_six ?? ""))
                                
                            }
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationSetTimeViewController") as! RegistrationSetTimeViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                            //                            if user_step_one == "0"{
                            //                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationSetTimeViewController") as! RegistrationSetTimeViewController
                            //                                self.navigationController?.pushViewController(vc, animated: true)
                            //                            }
                            //                            else if user_step_two == "0" {
                            //                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationDepartmentViewController") as! RegistrationDepartmentViewController
                            //                                self.navigationController?.pushViewController(vc, animated: true)
                            //                            }
                            //                            else if user_step_three == "0"{
                            //                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationStrengthenQuestionViewController") as! RegistrationStrengthenQuestionViewController
                            //                                self.navigationController?.pushViewController(vc, animated: true)
                            //                            }
                            //                            else if user_step_four == "0" {
                            //                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationQuestionClimbingViewController") as! RegistrationQuestionClimbingViewController
                            //                                self.navigationController?.pushViewController(vc, animated: true)
                            //                            }
                            //                            else if user_step_five == "0" {
                            //                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationQuestionPushUpViewController") as! RegistrationQuestionPushUpViewController
                            //                                self.navigationController?.pushViewController(vc, animated: true)
                            //                            }
                            //                            else if user_step_six == "0" {
                            //                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationQuestionWorkstationViewController") as! RegistrationQuestionWorkstationViewController
                            //                                self.navigationController?.pushViewController(vc, animated: true)
                            //                            }
                            //                            else{
                            //                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeMyTaskViewController") as! HomeMyTaskViewController
                            //                                self.navigationController?.pushViewController(vc, animated: true)
                            //                            }
                            
                        }
                        else{
                            if let message = resultDict?["message"] as? String {
                                Toast.show(message: message, controller: self)
                            }
                        }
                    }
                    else{
                        if let message = resultDict?["message"] as? String {
                            Toast.show(message: message, controller: self)
                        }
                    }
                }
                else{
                    self.alert(message: "Something went wrong", title: "")
                    //                    if let message = resultDict?["message"] as? String {
                    //                        Toast.show(message: message, controller: self)
                    //                    }
                }
            }
            else{
                self.alert(message: "Something went wrong", title: "")
            }
            
        }
    }
}
