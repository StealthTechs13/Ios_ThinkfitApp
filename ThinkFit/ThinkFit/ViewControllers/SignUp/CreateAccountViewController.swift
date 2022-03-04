//
//  CreateAccountViewController.swift
//  ThinkFit
//
//  Created by stealth tech on 17/08/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit
import GoogleSignIn
import AuthenticationServices

class CreateAccountViewController: UIViewController{
    
    //MARK:- Outlets
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var nameWarningView: UIView!
    @IBOutlet weak var dateBirthTextField: UITextField!
    @IBOutlet weak var dateBirthWarningView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailWarningView: UIView!
    @IBOutlet weak var maleFemaleLbl: UILabel!
    @IBOutlet weak var maleView: UIView!
    @IBOutlet weak var femaleView: UIView!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var emailWarningLbl: UILabel!
    @IBOutlet weak var checkUncheckButton: UIButton!
    @IBOutlet weak var checkUncheckImageView: UIImageView!
    @IBOutlet weak var termsConditionsLbl: UILabel!
    @IBOutlet weak var googleSignInButton: UIButton!
    
    @IBOutlet weak var appleBtnView: UIView!
    
    //MARK:- Define Variables
    let datePicker = UIDatePicker()
    var userInfoDetail = [UserInfoDatailModel]()
    let text = "By proceeding  to create your account. you are agreeing to our Terms of Service and Privacy policy"
    
    let appleSignInProvider = AppleSignInClient()
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(getGoogleSignInData(notification:)), name: Notification.Name("GoogleSign"), object: nil)
        
        
        appleBtnView.backgroundColor = .clear
        
        setupAppleBtn()
        
        appleBtnView.cornerRadius = appleBtnView.frame.width / 2
        appleBtnView.clipsToBounds = true
        
        
        nameTextfield.delegate = self
        dateBirthTextField.delegate = self
        emailTextField.delegate = self
        
        
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
                
                // socialGoogleSignUp(email: email)
            }
        }
    }
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationSetup()
        setTexfieldColor()
        lblTextColorChange()
        showDatePicker()
        malefemaleViewSetup()
        
        nameTextfield.text = ""
        dateBirthTextField.text = ""
        emailTextField.text = ""
        checkUncheckImageView.image = #imageLiteral(resourceName: "icUnselectedCheckbox")
        
    }
    
    //MARK:- Navigation Setup
    func navigationSetup(){
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        
        
        /*** Navigation LeftBar Button ***/
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "icBackArrowWhite"), style: .done, target: self, action: #selector(self.icMenuButtonAction))
        self.navigationItem.leftBarButtonItem  = leftBarButton
    }
    
    
    //MARK:- Object Function Button Action
    @objc func icMenuButtonAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Change Some Label Text Color
    func lblTextColorChange() {
        let string = NSMutableAttributedString(string: text)
        string.setColorForText("Terms of Service", with: #colorLiteral(red: 0.9843137255, green: 0.4941176471, blue: 0.1294117647, alpha: 1))
        string.setColorForText("Privacy policy", with: #colorLiteral(red: 0.9843137255, green: 0.4941176471, blue: 0.1294117647, alpha: 1))
        termsConditionsLbl.attributedText = string
        
        termsConditionsLbl.isUserInteractionEnabled = true
        termsConditionsLbl.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tap(gesture:))))
        
    }
    
    //MARK:- This Object function to Clieck on Label Specific Text
    @objc func tap(gesture: UITapGestureRecognizer) {
        
        if gesture.didTapAttributedTextInLabelMultiple(label: termsConditionsLbl, targetText: "Terms of Service") {
            print("Terms of service")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermsAndConditionViewController") as! TermsAndConditionViewController
            vc.comingSignUpScreen = true
            self.navigationController?.pushViewController(vc, animated: true)
        } else if gesture.didTapAttributedTextInLabelMultiple(label: termsConditionsLbl, targetText: "Privacy policy") {
            print("Privacy policy")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermsAndConditionViewController") as! TermsAndConditionViewController
            vc.comingSignUpScreen = true
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            print("Tapped none")
        }
    }
    
    //MARK:- Function Working
    func malefemaleViewSetup(){
        maleView.layer.cornerRadius = 18
        maleView.layer.masksToBounds = true
        maleView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
        femaleView.layer.cornerRadius = 18
        femaleView.layer.masksToBounds = true
        femaleView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
        maleView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        femaleView.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.2509803922, blue: 0.2509803922, alpha: 1)
        maleFemaleLbl.text = "Male"
    }
    
    
    //MARK:- TexField PlaceHolder Color
    func setTexfieldColor(){
        nameTextfield.placeHolderColor = #colorLiteral(red: 0.662745098, green: 0.662745098, blue: 0.662745098, alpha: 1)
        dateBirthTextField.placeHolderColor = #colorLiteral(red: 0.662745098, green: 0.662745098, blue: 0.662745098, alpha: 1)
        emailTextField.placeHolderColor = #colorLiteral(red: 0.662745098, green: 0.662745098, blue: 0.662745098, alpha: 1)
    }
    
    
    //MARK:- TextField validation
    func checkfieldValidation(){
        
        //        if nameTextfield.text == "" && dateBirthTextField.text == "" && emailTextField.text == "" {
        //            nameWarningView.isHidden = false
        //            dateBirthWarningView.isHidden = false
        //            emailWarningView.isHidden = false
        //        }
        
        if nameTextfield.text == "" {
            nameWarningView.isHidden = false
        }
        else if dateBirthTextField.text == "" {
            dateBirthWarningView.isHidden = false
            nameWarningView.isHidden = true
        }
        else if emailTextField.text == "" {
            emailWarningView.isHidden = false
            emailWarningLbl.text = "Plase enter your email"
            dateBirthWarningView.isHidden = true
            nameWarningView.isHidden = true
        }
        else if !isValidEmail(emailStr: emailTextField.text!){
            emailWarningView.isHidden = false
            emailWarningLbl.text = "Please enter your valid email"
            dateBirthWarningView.isHidden = true
            nameWarningView.isHidden = true
        }
        else if checkUncheckButton.tag == 0 {
            Toast.show(message: "Please check your terms and conditions", controller: self)
        }
        else {
            nameWarningView.isHidden = true
            dateBirthWarningView.isHidden = true
            emailWarningView.isHidden = true
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreatePasswordViewController") as! CreatePasswordViewController
            
            vc.userName = nameTextfield.text!
            vc.userDateOfBirth = dateBirthTextField.text!
            vc.userEmail = emailTextField.text!
            vc.userGender = maleFemaleLbl.text!
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //MARK:- Validation Code
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        
        let passPred = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passPred.evaluate(with: password)
    }
    
    
    //MARK:- UIButton Actions
    /*** Proceed Button Action ***/
    @IBAction func proceedButtonAction(_ sender: Any) {
        checkfieldValidation()
    }
    
    /*** Sign In Button Action ***/
    @IBAction func signInButtonAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    /*** Male And Female Button Action ***/
    @IBAction func maleFemaleJointButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            maleView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            maleFemaleLbl.text = "Male"
            femaleView.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.2509803922, blue: 0.2509803922, alpha: 1)
        case 1:
            femaleView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            maleFemaleLbl.text = "Female"
            maleView.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.2509803922, blue: 0.2509803922, alpha: 1)
        default:
            
            maleView.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.2509803922, blue: 0.2509803922, alpha: 1)
            femaleView.backgroundColor = #colorLiteral(red: 0.2509803922, green: 0.2509803922, blue: 0.2509803922, alpha: 1)
            
        }
    }
    
    /*** Uncheck and Check Button Action ***/
    @IBAction func checkUncheckButtonAction(_ sender: UIButton) {
        if checkUncheckButton.tag == 0 {
            checkUncheckButton.tag = 1
            checkUncheckImageView.image = #imageLiteral(resourceName: "icSelectedCheckbox")
        }
        else{
            checkUncheckButton.tag = 0
            checkUncheckImageView.image = #imageLiteral(resourceName: "icUnselectedCheckbox")
        }
    }
    
    
    //MARK:- DatePicker
    func showDatePicker(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd. MMMM yyyy"
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        datePicker.setValue(UIColor(cgColor: #colorLiteral(red: 0.9843137255, green: 0.4941176471, blue: 0.1294117647, alpha: 1)), forKeyPath: "textColor")
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        toolbar.barTintColor = #colorLiteral(red: 0.9843137255, green: 0.4941176471, blue: 0.1294117647, alpha: 1)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        doneButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cancelButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        dateBirthTextField.inputAccessoryView = toolbar
        dateBirthTextField.inputView = datePicker
        
    }
    
    /*** DatePicker Done Button Action ***/
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "dd-MM-yyyy"
        dateBirthTextField.text = formatter.string(from: datePicker.date)
        
        self.view.endEditing(true)
    }
    
    /*** DatePicker Cancel Button Action ***/
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    /***  Google SignUp Button Action ***/
    @IBAction func googleSignUpButtonAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    /*** Setup Apple Login Btn ***/
    func setupAppleBtn(){
        if #available(iOS 13.2, *) {
            // let appleBtn = ASAuthorizationAppleIDButton(authorizationButtonType: .continue, authorizationButtonStyle: .white)
            
            let appleBtn = UIButton()
            appleBtn.setImage(#imageLiteral(resourceName: "icApple"), for: .normal)
            

            self.appleBtnView.addSubview(appleBtn)
            appleBtn.addTarget(self, action: #selector(SignInWithAppleAction(sender:)), for: .touchUpInside)
            
            appleBtn.translatesAutoresizingMaskIntoConstraints = false
            appleBtn.topAnchor.constraint(equalTo: appleBtnView.safeAreaLayoutGuide.topAnchor).isActive = true
            appleBtn.bottomAnchor.constraint(equalTo: appleBtnView.safeAreaLayoutGuide.bottomAnchor).isActive = true
            appleBtn.leadingAnchor.constraint(equalTo: appleBtnView.safeAreaLayoutGuide.leadingAnchor).isActive = true
            appleBtn.trailingAnchor.constraint(equalTo: appleBtnView.safeAreaLayoutGuide.trailingAnchor).isActive = true
            
            
        } else {
            self.appleBtnView.backgroundColor = .white
            self.appleBtnView.isHidden = true
        }
        
    }
    
    
    //MARK:- SignIn Apple Action
    @available(iOS 13.0, *)
    @objc
    func SignInWithAppleAction(sender: ASAuthorizationAppleIDButton)  {
        
        appleSignInProvider.handleAppleIdRequest(block: { fullName, email, token in
            // receive data in login class.
            
            //self.appleLogin(name: fullName ?? "", email: email ?? "", token: token ?? "")
            self.socialSignUpApple(email: email ?? "", name: fullName ?? "", appleToken: token ?? "")
            
        })
        
        
    }
    
    
    
    
}


//MARK:- TextField Delegate
extension CreateAccountViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if nameTextfield.isEditing == true {
            nameWarningView.isHidden = true
        }
        if dateBirthTextField.isEditing == true {
            dateBirthWarningView.isHidden = true
        }
        if emailTextField.isEditing == true {
            emailWarningView.isHidden = true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if nameTextfield.isEditing == true {
            nameWarningView.isHidden = true
        }
        if dateBirthTextField.isEditing == true {
            dateBirthWarningView.isHidden = true
        }
        
        if emailTextField.isEditing == true {
            emailWarningView.isHidden = true
        }
        
        return true
    }
    
}





//MARK:- API's Calling
extension CreateAccountViewController {
    
    /*** Social Google SignUp ***/
    func socialGoogleSignUp(email: String, name: String, dob: String, gender: String){
        
        self.showIndicator()
        DataService.sharedInstance.socialLogin(email: email, login_type: "Google", device_type: "iOS", devToken: GlobalVariabel.firebase_token, dob: dob, name: name, gender: gender) { (resultDict, errorMsg) in
            
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
                                
                                UserDefaults.standard.set(String(user_Id ), forKey: K_UserId)
                                UserDefaults.standard.set(user_email ?? "", forKey: K_UserEmail)
                                UserDefaults.standard.set(user_email_verified ?? "", forKey: K_EmailVerified)
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
                                
                                
                                if user_step_one == "0"{
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationSetTimeViewController") as! RegistrationSetTimeViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                else if user_step_two == "0" {
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationDepartmentViewController") as! RegistrationDepartmentViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                else if user_step_three == "0"{
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationStrengthenQuestionViewController") as! RegistrationStrengthenQuestionViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                else if user_step_four == "0" {
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationQuestionClimbingViewController") as! RegistrationQuestionClimbingViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                else if user_step_five == "0" {
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationQuestionPushUpViewController") as! RegistrationQuestionPushUpViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                else if user_step_six == "0" {
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationQuestionWorkstationViewController") as! RegistrationQuestionWorkstationViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                else{
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeMyTaskViewController") as! HomeMyTaskViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                            }
                        }
                        else{
                            self.alert(message: "Something went wrong", title: "")
                            
                            if let message = resultDict?["message"] as? String {
                                Toast.show(message: message, controller: self)
                            }
                        }
                    } else{
                        // self.alert(message: "Something went wrong", title: "")
                        if let message = resultDict?["message"] as? String {
                            Toast.show(message: message, controller: self)
                        }
                    }
                }
            }
            else{
                self.alert(message: "Something went wrong", title: "")
            }
            
        }
    }
}


//MARK:- SignUp Apple
extension CreateAccountViewController {
    
    /*** Social SignUp With Apple ***/
    func socialSignUpApple(email: String, name: String, appleToken: String){
        
        self.showIndicator()
        DataService.sharedInstance.socialLoginApple(email: email, login_type: "Apple", device_type: "iOS", devToken: GlobalVariabel.firebase_token, name: name, apple_Token: appleToken) { (resultDict, errorMsg) in
            
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
                                
                                UserDefaults.standard.set(String(user_Id ), forKey: K_UserId)
                                UserDefaults.standard.set(user_email ?? "", forKey: K_UserEmail)
                                UserDefaults.standard.set(user_email_verified ?? "", forKey: K_EmailVerified)
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
                                
                                
                                if user_step_one == "0"{
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationSetTimeViewController") as! RegistrationSetTimeViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                else if user_step_two == "0" {
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationDepartmentViewController") as! RegistrationDepartmentViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                else if user_step_three == "0"{
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationStrengthenQuestionViewController") as! RegistrationStrengthenQuestionViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                else if user_step_four == "0" {
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationQuestionClimbingViewController") as! RegistrationQuestionClimbingViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                else if user_step_five == "0" {
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationQuestionPushUpViewController") as! RegistrationQuestionPushUpViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                else if user_step_six == "0" {
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationQuestionWorkstationViewController") as! RegistrationQuestionWorkstationViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                else{
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeMyTaskViewController") as! HomeMyTaskViewController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                            }
                        }
                        else{
                            self.alert(message: "Something went wrong", title: "")
                            
                            if let message = resultDict?["message"] as? String {
                                Toast.show(message: message, controller: self)
                            }
                        }
                    } else{
                        // self.alert(message: "Something went wrong", title: "")
                        if let message = resultDict?["message"] as? String {
                            Toast.show(message: message, controller: self)
                        }
                    }
                }
            }
            else{
                self.alert(message: "Something went wrong", title: "")
            }
        }
    }
}
