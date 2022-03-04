//
//  FocusTimeOopsViewController.swift
//  ThinkFit
//
//  Created by apple on 21/09/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class FocusTimeOopsViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var oopsSomethingWentWrongView: UIView!
    @IBOutlet weak var telePhoneCellButton: UIButton!
    @IBOutlet weak var telePhoneCellLbl: UILabel!
    @IBOutlet weak var personalIntruptionButton: UIButton!
    @IBOutlet weak var personalIntruptionLbl: UILabel!
    @IBOutlet weak var socialMediaButton: UIButton!
    @IBOutlet weak var socialMediaLbl: UILabel!
    @IBOutlet weak var emailNotificationButton: UIButton!
    @IBOutlet weak var emailNotificationLbl: UILabel!
    @IBOutlet weak var toiletEmergancyButton: UIButton!
    @IBOutlet weak var toiletEmergencyLbl: UILabel!
    @IBOutlet weak var noProblemButton: UIButton!
    @IBOutlet weak var noProblemLbl: UILabel!
    @IBOutlet weak var otherButton: UIButton!
    @IBOutlet weak var otherButtonLbl: UILabel!
    @IBOutlet weak var enterDescriptionTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var intruptionTableView: UITableView!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewTop: NSLayoutConstraint!
    @IBOutlet weak var buttonbottom: NSLayoutConstraint!
    
    
    //MARK:- Define Variables
    var intruptionDescription = ""
    var intruptionType = ""
    var ohIntruptionCount = 0
    var recoveryScreenVcTime = 0
    var selectTaskId = ""
    var selectButton = ""
    var taskName = ""
    var taskId = ""
    var intruptionList = [intruptionModel]()
    var selectedIndex = Int()
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //        if let value = UserDefaults.standard.value(forKey: K_ohohIntruption) {
        //            ohIntruptionCount = value as! Int
        //        }
        enterDescriptionTextField.isUserInteractionEnabled = false
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationbarSetup()
        intruptionQuote()
        enterDescriptionTextField.placeHolderColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
        
        if UIScreen.main.bounds.size.height <= 736{
            viewTop?.constant = 50
            self.view.layoutIfNeeded()
        }
        else{
            viewTop?.constant = 90
            //buttonbottom.constant = 100
            self.view.layoutIfNeeded()
        }
        
    }
    
    //MARK:- ViewDidLayout_SubView
    override func viewDidLayoutSubviews(){
        intruptionTableView.frame = CGRect(x: intruptionTableView.frame.origin.x, y: intruptionTableView.frame.origin.y, width: intruptionTableView.frame.size.width, height: intruptionTableView.contentSize.height)
        intruptionTableView.reloadData()
    }
    
    
    //MARK:- Navigation Setup
    func navigationbarSetup(){
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
        title = "Focus Time"
        navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    //    func showNavigationBackButton(){
    //        let leftBarButton = UIBarButtonItem(image: UIImage(named: "icBackArrowWhite"), style: .done, target: self, action: #selector(self.icBackButtonAction))
    //        self.navigationItem.leftBarButtonItem  = leftBarButton
    //    }
    //
    //    @objc func icBackButtonAction(){
    //        self.navigationController?.popViewController(animated: true)
    //    }
    
    
    //MARK:- UIButton Action
    @IBAction func submitButtonAction(_ sender: Any) {
        
        if selectButton == "Other" {
            if enterDescriptionTextField.text == "" {
                Toast.show(message: "please enter the description", controller: self)
            }
            else{
                intruptionOtherFeedbackAPI()
                //print("select Other Feedback")
            }
            
        }
        
        if selectButton == "No problem" {
            updateTaskComplitionStatus()
        }
        
        if selectButton == "" {
            Toast.show(message: "Please select a reason for interruption", controller: self)
        }
        
        if selectButton == "intruption" {
            focusTimeIntruptionAPI()
            
            
        }
        
    }
    
    /*** No Problem Task Complete ***/
    @IBAction func noProblemTaskCompleteButtonAction(_ sender: UIButton) {
        if noProblemButton.tag == 0 {
            noProblemButton.tag = 1
            otherButton.tag = 0
            intruptionDescription = "No problem, Task Completed"
            selectButton = "No problem"
            noProblemButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
            noProblemLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            selectedIndex = -1
            otherButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            otherButtonLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            enterDescriptionTextField.isUserInteractionEnabled = false
            enterDescriptionTextField.resignFirstResponder()
        }
        //        else{
        //            noProblemButton.tag = 0
        //            noProblemButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
        //            noProblemLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
        //        }
        
        intruptionTableView.reloadData()
    }
    
    
    /*** Other Button Action ***/
    @IBAction func otherButtonAction(_ sender: UIButton) {
        if otherButton.tag == 0 {
            otherButton.tag = 1
            noProblemButton.tag = 0
            otherButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
            otherButtonLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            selectButton = "Other"
            intruptionDescription = enterDescriptionTextField.text!
            enterDescriptionTextField.isUserInteractionEnabled = true
            enterDescriptionTextField.becomeFirstResponder()
            noProblemButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            noProblemLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            selectedIndex = -1
        }
        //        else{
        //            otherButton.tag = 0
        //            otherButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
        //            otherButtonLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
        //        }
        intruptionTableView.reloadData()
    }
    
    
    //    @IBAction func allIntruptionButtonJointAction(_ sender: UIButton) {
    //        switch sender.tag {
    //        case 0:
    //            telePhoneCellButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
    //            personalIntruptionButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            socialMediaButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            emailNotificationButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            toiletEmergancyButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            noProblemButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            otherButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            telePhoneCellLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    //            personalIntruptionLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            socialMediaLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            emailNotificationLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            toiletEmergencyLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            noProblemLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            otherButtonLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            intruptionDescription = "Telephone Call"
    //            selectButton = "intruption"
    //            enterDescriptionTextField.isUserInteractionEnabled = false
    //            enterDescriptionTextField.text = ""
    //            enterDescriptionTextField.resignFirstResponder()
    //        case 1:
    //            telePhoneCellButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            personalIntruptionButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
    //            socialMediaButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            emailNotificationButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            toiletEmergancyButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            noProblemButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            otherButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            telePhoneCellLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            personalIntruptionLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    //            socialMediaLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            emailNotificationLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            toiletEmergencyLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            noProblemLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            otherButtonLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            intruptionDescription = "Personal Interruption"
    //            selectButton = "intruption"
    //            enterDescriptionTextField.isUserInteractionEnabled = false
    //            enterDescriptionTextField.text = ""
    //            enterDescriptionTextField.resignFirstResponder()
    //        case 2:
    //            telePhoneCellButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            personalIntruptionButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            socialMediaButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
    //            emailNotificationButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            toiletEmergancyButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            noProblemButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            otherButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            telePhoneCellLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            personalIntruptionLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            socialMediaLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    //            emailNotificationLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            toiletEmergencyLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            noProblemLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            otherButtonLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            intruptionDescription = "Social Media Notification"
    //            selectButton = "intruption"
    //            enterDescriptionTextField.isUserInteractionEnabled = false
    //            enterDescriptionTextField.text = ""
    //            enterDescriptionTextField.resignFirstResponder()
    //        case 3:
    //            telePhoneCellButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            personalIntruptionButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            socialMediaButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            emailNotificationButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
    //            toiletEmergancyButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            noProblemButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            otherButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            telePhoneCellLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            personalIntruptionLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            socialMediaLbl.textColor =  #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            emailNotificationLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    //            toiletEmergencyLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            noProblemLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            otherButtonLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            intruptionDescription = "Email Notification"
    //            selectButton = "intruption"
    //            enterDescriptionTextField.isUserInteractionEnabled = false
    //            enterDescriptionTextField.text = ""
    //            enterDescriptionTextField.resignFirstResponder()
    //        case 4:
    //            telePhoneCellButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            personalIntruptionButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            socialMediaButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            emailNotificationButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            toiletEmergancyButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
    //            noProblemButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            otherButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            telePhoneCellLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            personalIntruptionLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            socialMediaLbl.textColor =  #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            emailNotificationLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            toiletEmergencyLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    //            noProblemLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            otherButtonLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            intruptionDescription =  "Toilet Emergency"
    //            selectButton = "intruption"
    //            enterDescriptionTextField.isUserInteractionEnabled = false
    //            enterDescriptionTextField.text = ""
    //            enterDescriptionTextField.resignFirstResponder()
    //        case 5:
    //            telePhoneCellButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            personalIntruptionButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            socialMediaButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            emailNotificationButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            toiletEmergancyButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            noProblemButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
    //            otherButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            telePhoneCellLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            personalIntruptionLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            socialMediaLbl.textColor =  #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            emailNotificationLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            toiletEmergencyLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            noProblemLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    //            otherButtonLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            intruptionDescription = "No problem, Task Completed"
    //            selectButton = "No problem"
    //            enterDescriptionTextField.isUserInteractionEnabled = false
    //            enterDescriptionTextField.text = ""
    //            enterDescriptionTextField.resignFirstResponder()
    //        // deleteTaskAPI()
    //        case 6:
    //            telePhoneCellButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            personalIntruptionButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            socialMediaButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            emailNotificationButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            toiletEmergancyButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            noProblemButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            otherButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
    //            telePhoneCellLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            personalIntruptionLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            socialMediaLbl.textColor =  #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            emailNotificationLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            toiletEmergencyLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            noProblemLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            otherButtonLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    //            selectButton = "Other"
    //            intruptionDescription = enterDescriptionTextField.text!
    //            enterDescriptionTextField.isUserInteractionEnabled = true
    //            enterDescriptionTextField.becomeFirstResponder()
    //
    //        default:
    //            telePhoneCellButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            personalIntruptionButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            socialMediaButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            emailNotificationButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            toiletEmergancyButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            noProblemButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            otherButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
    //            telePhoneCellLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            personalIntruptionLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            socialMediaLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            emailNotificationLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            toiletEmergencyLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            noProblemLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //            otherButtonLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
    //        }
    //    }
    
    
    /*** IntruptionCount function ***/
    func manageInteruptionCount(name:String){
        if (UserDefaults.standard.value(forKey: k_Update_Intruption_Status_Name) as? String) != nil{
            
            if UserDefaults.standard.value(forKey: k_Update_Intruption_Status_Name) as! String == name{
                if (UserDefaults.standard.value(forKey: k_Update_Intruption_Status_count) as? Int) != nil{
                    let count = UserDefaults.standard.value(forKey: k_Update_Intruption_Status_count) as! Int + 1
                    UserDefaults.standard.set(count, forKey: k_Update_Intruption_Status_count)
                    if count == 4{
                        //count reset
                        UserDefaults.standard.removeObject(forKey: k_Update_Intruption_Status_Name)
                        UserDefaults.standard.removeObject(forKey: k_Update_Intruption_Status_count)
                        UserDefaults.standard.synchronize()
                        //api hit
                        updateIntruptionStatus()
                    }
                }
            }else{
                UserDefaults.standard.set(name, forKey: k_Update_Intruption_Status_Name)
                UserDefaults.standard.set(1, forKey: k_Update_Intruption_Status_count)
            }
        }else{
            UserDefaults.standard.set(name, forKey: k_Update_Intruption_Status_Name)
            UserDefaults.standard.set(1, forKey: k_Update_Intruption_Status_count)
        }
    }
}


//MARK:- UITableView Delegate & DataSource Method
extension FocusTimeOopsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if intruptionList.count == 0 {
            oopsSomethingWentWrongView.isHidden = true
        }
        else{
            oopsSomethingWentWrongView.isHidden = false
            
            // navigationItem.setHidesBackButton(true, animated: true)
            return intruptionList.count
        }
        
        return 0
        //        oopsSomethingWentWrongView.isHidden = false
        //       // navigationItem.setHidesBackButton(true, animated: true)
        //        return intruptionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FocusTimeIntruptionTableViewCell") as! FocusTimeIntruptionTableViewCell
        cell.intruptionNameLbl.text = intruptionList[indexPath.row].intruptionFocusTip
        cell.intruptionSelectButton.tag = indexPath.row
        cell.intruptionSelectButton.addTarget(self, action: #selector(tappedCell(sender:)), for: .touchUpInside)
        
        if intruptionDescription == intruptionList[indexPath.row].intruptionFocusTip {
            cell.intruptionSelectButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
            cell.intruptionNameLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        else{
            cell.intruptionSelectButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            cell.intruptionNameLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
        }
        
        return cell
    }
    
    
    //MARK:- Cell Button Object Action
    @objc func tappedCell(sender: UIButton){
        selectedIndex = sender.tag
        intruptionDescription = intruptionList[sender.tag].intruptionFocusTip
        print(intruptionDescription)
        selectButton = "intruption"
        otherButton.tag = 0
        noProblemButton.tag = 0
        noProblemButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
        noProblemLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
        otherButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
        otherButtonLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
        otherButton.tag = 0
        noProblemButton.tag = 0
        enterDescriptionTextField.isUserInteractionEnabled = false
        enterDescriptionTextField.resignFirstResponder()
        intruptionTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


//MARK:-Calling API'S

extension FocusTimeOopsViewController {
    
    func intruptionQuote(){
        
        self.showIndicator()
        
        DataService.sharedInstance.intruption_type(userid: GlobalVariabel.userId) { (resultDict, errorMsg) in
            
            self.hideIndicator()
            
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool {
                    if status == true {
                        
                        if let result = resultDict?["result"] as? [NSDictionary]{
                            print(result)
                            
                            self.intruptionList.removeAll()
                            for i in 0..<result.count {
                                
                                let data = result[i]
                               // let intruptionTipsList = intruptionListEntries()
                                
                                if let intruption_id = data["id"] as? Int {
                                    let intruptionFocusTip = data["focus_tip"] as? String
                                    //let intruptionStatus = data["status"] as? String
                                    let intruptionCreateAt = data["createdAt"] as? String
                                    let intruptionUpdateAt = data["updatedAt"] as? String
                                    
                                    
                                    self.intruptionList.append(intruptionModel.init(intruptionId: intruption_id, intruptionFocusTip: intruptionFocusTip ?? "", intruptionStatus: 0, intruptionCreateAt: intruptionCreateAt ?? "", intruptionUpdateAt: intruptionUpdateAt ?? ""))
                                    
                                }
                                
                            }
                            
                            self.intruptionTableView.reloadData()
                        }
                    }
                    else{
                        
                        if let msg = resultDict?["message"] as? String{
                            Toast.show(message: msg, controller: self)
                        }
                    }
                }
            }
            else{
                self.intruptionQuote()
                //                if let msg = resultDict?["message"] as? String{
                //                    Toast.show(message: msg, controller: self)
                //                }
            }
            
        }
    }
    
    
    //++++++++ intruption ++++++++//
    func focusTimeIntruptionAPI(){
        
        self.showIndicator()
        
        DataService.sharedInstance.focusDays(userId: GlobalVariabel.userId, description: intruptionDescription, type: intruptionType) { (resultDict, errorMsg) in
            
            self.hideIndicator()
            
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool{
                    if status == true {
                        
                        var saveIntTime = Int()
                        self.manageInteruptionCount(name: self.intruptionDescription)
                        
                        if let timer_count = resultDict?["timer_count"] as? String {
                            let IntTime = (timer_count as NSString).integerValue
                            saveIntTime = IntTime
//                            UserDefaults.standard.set(IntTime, forKey: K_defaultTime)
//                            UserDefaults.standard.synchronize()
                            
                        }
                    
                        if let result = resultDict?["result"] as? NSDictionary {
                            print(result)
                            if let count = result["count"] as? Int {
                                print(count)
                                if count == 2 {
                                    if UserDefaults.standard.value(forKey: K_defaultTime) != nil {
                                        if let defaultTime = UserDefaults.standard.value(forKey: K_defaultTime){
                                            if defaultTime as! Int == saveIntTime {
                                                /* Check timer */
                                                if let timer_count = resultDict?["timer_count"] as? String {
                                                    let IntTime = (timer_count as NSString).integerValue
                                                    saveIntTime = IntTime
                                                    UserDefaults.standard.set(IntTime, forKey: K_defaultTime)
                                                    UserDefaults.standard.synchronize()
                                                    
                                                }
                                                self.navigationController?.backToViewController(vc: ThinkFitFocusTimeViewController.self)
                                            }
                                            else{
                                                /* Check timer */
                                                if let timer_count = resultDict?["timer_count"] as? String {
                                                    let IntTime = (timer_count as NSString).integerValue
                                                    saveIntTime = IntTime
                                                    UserDefaults.standard.set(IntTime, forKey: K_defaultTime)
                                                    UserDefaults.standard.synchronize()
                                                }
                                                
                                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "OhOhViewController") as! OhOhViewController
                                                vc.timeCount = saveIntTime
                                                self.navigationController?.pushViewController(vc, animated: true)
                                            }
                                            
                                        }
                                    }
                                    else{
                                        if let timer_count = resultDict?["timer_count"] as? String {
                                            let IntTime = (timer_count as NSString).integerValue
                                            saveIntTime = IntTime
                                            UserDefaults.standard.set(IntTime, forKey: K_defaultTime)
                                            UserDefaults.standard.synchronize()
                                            
                                        }
                                        self.navigationController?.backToViewController(vc: ThinkFitFocusTimeViewController.self)
                                    }
                                    
                                    //                                    if UserDefaults.standard.value(forKey: K_defaultTime) != nil {
                                    //                                        if let defaultTime = UserDefaults.standard.value(forKey: K_defaultTime){
                                    //                                            /* Check timer */
                                    //                                            if let timer_count = resultDict?["timer_count"] as? String {
                                    //                                                let IntTime = (timer_count as NSString).integerValue
                                    //                                                saveIntTime = IntTime
                                    //                                                UserDefaults.standard.set(IntTime, forKey: K_defaultTime)
                                    //                                                UserDefaults.standard.synchronize()
                                    //
                                    //                                            }
                                    //                                            if defaultTime as! Int == saveIntTime {
                                    //                                                /* Check timer */
                                    //                                                if let timer_count = resultDict?["timer_count"] as? String {
                                    //                                                    let IntTime = (timer_count as NSString).integerValue
                                    //                                                    saveIntTime = IntTime
                                    //                                                    UserDefaults.standard.set(IntTime, forKey: K_defaultTime)
                                    //                                                    UserDefaults.standard.synchronize()
                                    //
                                    //                                                }
                                    //                                                self.navigationController?.backToViewController(vc: ThinkFitFocusTimeViewController.self)
                                    //                                            }
                                    //                                            else{
                                    //
                                    //                                            }
                                    //                                        }
                                    //                                    }
                                    //                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "OhOhViewController") as! OhOhViewController
                                    //                                    vc.timeCount = saveIntTime
                                    //                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                else{
                                    /* Check timer */
                                    if let timer_count = resultDict?["timer_count"] as? String {
                                        let IntTime = (timer_count as NSString).integerValue
                                        saveIntTime = IntTime
                                        UserDefaults.standard.set(IntTime, forKey: K_defaultTime)
                                        UserDefaults.standard.synchronize()
                                    }
                                    
                                    self.navigationController?.backToViewController(vc: ThinkFitFocusTimeViewController.self)
                                }
                            }
                            
                        }
                        
                        //                        self.manageInteruptionCount(name: self.intruptionDescription)
                        //                        if UserDefaults.standard.value(forKey: K_ohohIntruption) != nil {
                        //                            let getohCount = UserDefaults.standard.value(forKey: K_ohohIntruption)
                        //                            self.ohIntruptionCount = getohCount as! Int+1
                        //                        }
                        //                        else{
                        //                            self.ohIntruptionCount = self.ohIntruptionCount+1
                        //                        }
                        //
                        //                        UserDefaults.standard.set(self.ohIntruptionCount, forKey: K_ohohIntruption)
                        //                        UserDefaults.standard.synchronize()
                        //
                        //                        if let timer_count = resultDict?["timer_count"] as? String {
                        //                            let IntTime = (timer_count as NSString).integerValue
                        //                            UserDefaults.standard.set(IntTime, forKey: K_defaultTime)
                        //                            UserDefaults.standard.synchronize()
                        //
                        //                            if UserDefaults.standard.value(forKey: K_ohohIntruption) != nil{
                        //                                if UserDefaults.standard.value(forKey: K_ohohIntruption) as! Int == 3 {
                        //                                    self.ohIntruptionCount = 0
                        //                                    UserDefaults.standard.removeObject(forKey: K_ohohIntruption)
                        //                                    UserDefaults.standard.synchronize()
                        //                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "OhOhViewController") as! OhOhViewController
                        //                                    vc.timeCount = IntTime
                        //                                    self.navigationController?.pushViewController(vc, animated: true)
                        //                                }
                        //                                else{
                        //                                    self.navigationController?.backToViewController(vc: ThinkFitFocusTimeViewController.self)
                        //
                        //                                    // self.navigationController?.popViewController(animated: true)
                        //                                }
                        //
                        //                            }
                        //
                        //                        }
                        
                    }
                    else{
                        
                        if let message = resultDict?["message"] as? String{
                            Toast.show(message: message, controller: self)
                        }
                    }
                }
            }
            else{
                self.alert(message: "Something went wrong", title: "")
                if let message = resultDict?["message"] as? String{
                    Toast.show(message: message, controller: self)
                }
            }
        }
    }
    
    
    
    //++++++++ Update task Complition Status API ++++++++//
    func updateTaskComplitionStatus(){
        
        self.showIndicator()
        
        DataService.sharedInstance.userTaskComplitionStatus(userid: GlobalVariabel.userId, taskId: selectTaskId) { (resultDict, errorMsg) in
            
            self.hideIndicator()
            
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool{
                    if status == true{
                        
                        if let message = resultDict?["message"] as? String {
                            Toast.show(message: message, controller: self)
                            
                            if UserDefaults.standard.value(forKey: K_Recovery_Count) != nil {
                                let recoveryCount = UserDefaults.standard.value(forKey: K_Recovery_Count) as? Int
                                if recoveryCount == 3 {
                                    
                                    self.recoveryScreenVcTime = 0
                                    UserDefaults.standard.set(self.recoveryScreenVcTime, forKey: K_Recovery_Count)
                                    UserDefaults.standard.synchronize()

                                    GlobalVariabel.taskName = self.taskName
                                    GlobalVariabel.taskID = self.taskId
                                    
                                    
                                    NotificationCenter.default.removeObserver(self)
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RenewalPeriodTimeBreakViewController") as! RenewalPeriodTimeBreakViewController
                                    vc.intruptionType = "No Intruption Task Complete"
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                else{
                                    NotificationCenter.default.removeObserver(self)
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecoveryRollingViewController") as! RecoveryRollingViewController
                                    vc.noIntruptionTaskComplete = "No Intruption Task Complete"
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                            }
                            else{
                                NotificationCenter.default.removeObserver(self)
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecoveryRollingViewController") as! RecoveryRollingViewController
                                vc.noIntruptionTaskComplete = "No Intruption Task Complete"
                                self.navigationController?.pushViewController(vc, animated: true)
                            }

                            
//                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecoveryRollingViewController") as! RecoveryRollingViewController
//                            vc.noIntruptionTaskComplete = "No Intruption Task Complete"
//                            self.navigationController?.pushViewController(vc, animated: true)
                            //self.navigationController?.backToViewController(vc: HomeMyTaskViewController.self)
                            //                            for vc in (self.navigationController?.viewControllers)! {
                            //                                if vc is HomeMyTaskViewController {
                            //                                    self.navigationController?.popToViewController(vc, animated: true)
                            //                                }
                            //                            }
                        }
                        
                    }
                    else{
                        if let message = resultDict?["result"] as? String {
                            Toast.show(message: message, controller: self)
                        }
                    }
                }
                
            }
            else{
                self.alert(message: "Something went wrong", title: "")
                //                if let message = resultDict?["result"] as? String {
                //                    Toast.show(message: message, controller: self)
                //                }
            }
        }
        
    }
    
    
    //++++++++ intruptionOtherFeedback ++++++++//
    func intruptionOtherFeedbackAPI(){
        
        self.showIndicator()
        
        DataService.sharedInstance.intruptionOtherFeedback(userid: GlobalVariabel.userId, otherdescription: enterDescriptionTextField.text ?? "") { (resultDict, errorMsg) in
            
            self.hideIndicator()
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool {
                    if status == true {
                        
                        if let msg = resultDict?["message"] as? String {
                            Toast.show(message: msg, controller: self)
                        }
                        
                        self.navigationController?.backToViewController(vc: ThinkFitFocusTimeViewController.self)
                        //                        for vc in (self.navigationController?.viewControllers)! {
                        //                            if vc is ThinkFitFocusTimeViewController {
                        //                                self.navigationController?.popToViewController(vc, animated: true)
                        //                            }
                        //                        }
                        
                    }
                    else{
                        if let msg = resultDict?["message"] as? String {
                            Toast.show(message: msg, controller: self)
                        }
                    }
                }
            }
            else{
                if let msg = resultDict?["message"] as? String {
                    Toast.show(message: msg, controller: self)
                }
            }
        }
    }
    
    
    //MARK:- Intruption_update_status
    func updateIntruptionStatus(){
        
        // self.showIndicator()
        
        DataService.sharedInstance.updateIntruptionStatus(userid: GlobalVariabel.userId, interruptionName: intruptionDescription) { (resultDict, errorMsg) in
            
            //  self.hideIndicator()
            
            if errorMsg == nil {
                if let status = resultDict?["status"] as? Bool {
                    if status == true {
                        
                    }
                    else{
                        if let msg = resultDict?["message"] as? String {
                            Toast.show(message: msg, controller: self)
                        }
                    }
                }
                else{
                    self.alert(message: "Something went wrong", title: "")
                }
                
            }
            
            
        }
    }
    
    
}

//if intruptionType == "No Intruption Task Complete" {
//    self.navigationController?.backToViewController(vc: HomeMyTaskViewController.self)
//}
//else{
//    self.navigationController?.backToViewController(vc: ThinkFitFocusTimeViewController.self)
//}
