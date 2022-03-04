//
//  RegistrationDepartmentViewController.swift
//  ThinkFit
//
//  Created by apple on 27/08/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class RegistrationDepartmentViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var YouAchieveButton: UIButton!
    @IBOutlet weak var yourAlmostButton: UIButton!
    @IBOutlet weak var youDoArroundButton: UIButton!
    @IBOutlet weak var yourLongButton: UIButton!
    @IBOutlet weak var yourAchieveLbl: UILabel!
    @IBOutlet weak var yourAlmostLbl: UILabel!
    @IBOutlet weak var youDoArroundLbl: UILabel!
    @IBOutlet weak var yourLongLbl: UILabel!
    @IBOutlet weak var hideBackGroundView: UIView!
    @IBOutlet weak var noticeView: UIView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var noticeLbl: UILabel!
    
    
    //MARK:- Define Variable
    var buttonSelect = ""
    let text = "The Department of Health recommends adults are moderately active for 150 minutes or vigorously active for 75 minutes each week. \n \n In an average week, how close are you to achieving this ?"
    let term = "moderately"
    let policy = "vigorously"
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        hideBackGroundView.isHidden = true
        self.view.sendSubviewToBack(hideBackGroundView)
        self.view.layoutIfNeeded()
        noticeView.isHidden = true
        lblTextColorChange()
       
    }
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationSetup()
        lblTextColorChange()
    }
    
    //MARK:- Change Some Label Text Color
    func lblTextColorChange() {
        let string = NSMutableAttributedString(string: text)
        
        string.setColorForText("TheDepartmentofHealthrecommendsadultsare", with: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        string.setColorForText("active for 150 minutes or", with: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        string.setColorForText("active for 75 minutes each week. In an average week, how close are you to achieving this ?", with: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        string.setColorForText("moderately", with: #colorLiteral(red: 0.9843137255, green: 0.4941176471, blue: 0.1294117647, alpha: 1))
        string.setColorForText("vigorously", with: #colorLiteral(red: 0.9843137255, green: 0.4941176471, blue: 0.1294117647, alpha: 1))
        descriptionLbl.attributedText = string
                   
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(gesture:)))
        self.descriptionLbl.addGestureRecognizer(tap)
        self.descriptionLbl.isUserInteractionEnabled = true
        
        
    }
    
    
    //MARK:- Spacific Label Text Button Tap Action
    @objc func tap(gesture: UITapGestureRecognizer) {
        
        if gesture.didTapAttributedTextInLabelMultiple(label: descriptionLbl, targetText: "moderately") {
            print("Terms of service")
            hideBackGroundView.isHidden = false
            noticeView.isHidden = false
            noticeLbl.text = "Physical activity that increases your  heart rate, makes you warm and slightly out of breath but allows you to maintain a conversation."
        } else if gesture.didTapAttributedTextInLabelMultiple(label: descriptionLbl, targetText: "vigorously") {
            print("Privacy policy")
            hideBackGroundView.isHidden = false
            noticeView.isHidden = false
            noticeLbl.text =  "Physical activity that increases your heart rate, causes you to breathe rapidly and makes a conversation difficult. \n \nAdults should do a minimum of 150 minutes moderate or 75 minutes vigorous physical activity a week. This activity should last for at least 10 minutes, could be a combination of both and can be spread out over the week."
        } else {
            print("Tapped none")
        }
        
        
    }
        
    //MARK:- Navigation Setup
    func navigationSetup(){
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .black
       
        
        /*** Navigation LeftBar Button ***/
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "icBackArrowWhite"), style: .done, target: self, action: #selector(self.icBackButtonAction))
        self.navigationItem.leftBarButtonItem  = leftBarButton
        
        title = "Registration"
    }
    
    
    @objc func icBackButtonAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- UIButton Actions
    @IBAction func allJointButtoAction(_ sender: UIButton) {
        
        switch sender.tag {
            
        case 0:
            YouAchieveButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
            yourAlmostButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            youDoArroundButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            yourLongButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            yourAchieveLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            yourAlmostLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            youDoArroundLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            yourLongLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            buttonSelect = "3"
        case 1:
            YouAchieveButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            yourAlmostButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
            youDoArroundButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            yourLongButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            yourAchieveLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            yourAlmostLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            youDoArroundLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            yourLongLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            buttonSelect = "2"
        case 2:
            YouAchieveButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            yourAlmostButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            youDoArroundButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
            yourLongButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            yourAchieveLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            yourAlmostLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            youDoArroundLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            yourLongLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            buttonSelect = "1"
        case 3:
            YouAchieveButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            yourAlmostButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            youDoArroundButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            yourLongButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
            yourAchieveLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            yourAlmostLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            youDoArroundLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            yourLongLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            buttonSelect = "0"
            
        default:
            YouAchieveButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            yourAlmostButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            youDoArroundButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            yourLongButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            yourAchieveLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            yourAlmostLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            youDoArroundLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            yourLongLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            buttonSelect = ""
            
        }
    
        print(buttonSelect)
        
    }
 
    //MARK:- Notice Continue Button Action
    @IBAction func noticeContinueButton(_ sender: Any) {
        hideBackGroundView.isHidden = true
        noticeView.isHidden = true
    }
    
    
    //MARK:- Next Screen Button Action
    @IBAction func nextScreenButtonAction(_ sender: Any) {
        questionOneAPI()
    }
    
}


//MARK:- API SetUp
extension RegistrationDepartmentViewController {
    
    /*** Question One API ***/
    func questionOneAPI() {
        self.showIndicator()
        
        DataService.sharedInstance.questionOne(userId: GlobalVariabel.userId, questionOne: buttonSelect) { (resultDict, errorMsg) in
            
            self.hideIndicator()
            
            print(resultDict as Any)
            
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool {
                    if status == true {
                        
                        UserDefaults.standard.removeObject(forKey: K_StepTwo)
                        UserDefaults.standard.synchronize()
                        if let message = resultDict?["message"] as? String {
                            Toast.show(message: message, controller: self)
                        }
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GoodJobViewController") as!GoodJobViewController
                        vc.getIndex = self.buttonSelect
                        self.navigationController?.pushViewController(vc, animated: true)
                    
                    }
                    else{
                        UserDefaults.standard.set("0", forKey: K_StepTwo)
                        UserDefaults.standard.synchronize()
                        if let message = resultDict?["message"] as? String {
                            Toast.show(message: message, controller: self)
                        }
                    }
                }
            }
            else{
                UserDefaults.standard.set("0", forKey: K_StepTwo)
                UserDefaults.standard.synchronize()
                self.alert(message: "Something went wrong", title: "")
                if let message = resultDict?["message"] as? String {
                    Toast.show(message: message, controller: self)
                }
            }
        }
    }
}
