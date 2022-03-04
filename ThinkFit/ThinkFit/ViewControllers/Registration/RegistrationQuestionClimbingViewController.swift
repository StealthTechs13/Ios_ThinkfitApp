//
//  RegistrationQuestionClimbingViewController.swift
//  ThinkFit
//
//  Created by apple on 28/08/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class RegistrationQuestionClimbingViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var greatButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var breathLessButton: UIButton!
    @IBOutlet weak var exhaustedButton: UIButton!
    @IBOutlet weak var cantDoItButton: UIButton!
    @IBOutlet weak var greatLbl: UILabel!
    @IBOutlet weak var okLbl: UILabel!
    @IBOutlet weak var breathlessLbl: UILabel!
    @IBOutlet weak var exhaustedLbl: UILabel!
    @IBOutlet weak var canDoItLbl: UILabel!
    
    //MARK:- Define Variable
    var selectedButton = ""
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .black
        // self.navigationItem.setHidesBackButton(true, animated: true)
        title = "Registration"
        
        /*** Left_Bar Button Action ***/
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "icBackArrowWhite"), style: .done, target: self, action: #selector(self.icBackButtonAction))
        self.navigationItem.leftBarButtonItem  = leftBarButton
    
    }
    
    //MARK:- Navigation Button Action
    @objc func icBackButtonAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- UIButton Actions
    @IBAction func allJointButtonAction(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            greatButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
            okButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            breathLessButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            exhaustedButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            cantDoItButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            greatLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            okLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            breathlessLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            exhaustedLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            canDoItLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            selectedButton = "4"
            break
        case 1:
            greatButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            okButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
            breathLessButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            exhaustedButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            cantDoItButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            greatLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            okLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            breathlessLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            exhaustedLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            canDoItLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            selectedButton = "3"
            break
        case 2:
            greatButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            okButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            breathLessButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
            exhaustedButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            cantDoItButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            greatLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            okLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            breathlessLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            exhaustedLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            canDoItLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            selectedButton = "2"
            break
        case 3:
            greatButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            okButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            breathLessButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            exhaustedButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
            cantDoItButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            greatLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            okLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            breathlessLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            exhaustedLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            canDoItLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            selectedButton = "1"
            break
        case 4:
            greatButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            okButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            breathLessButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            exhaustedButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            cantDoItButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
            greatLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            okLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            breathlessLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            exhaustedLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            canDoItLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            selectedButton = "0"
            break
        default:
            greatButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            okButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            breathLessButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            exhaustedButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            cantDoItButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            greatLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            okLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            breathlessLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            exhaustedLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            canDoItLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            break
        }
        
    }
    
    
    @IBAction func nextScreenButtonAction(_ sender: Any) {
        questionThreeAPI()
    }
    
}


//MARK:- API's Calling
extension RegistrationQuestionClimbingViewController {
    
    /*** Question Three API ***/
    func questionThreeAPI(){
        self.showIndicator()
        DataService.sharedInstance.questionThree(userId: GlobalVariabel.userId, question: selectedButton) { (resultDict, errorMsg) in
            
            self.hideIndicator()
            
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool {
                    if status == true {
                        
                        UserDefaults.standard.removeObject(forKey: K_StepFour)
                        UserDefaults.standard.synchronize()
                        if let message = resultDict?["message"] as? String {
                            Toast.show(message: message, controller: self)
                        }
                        
                        if self.selectedButton == "4" {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationQuestionPushUpViewController") as! RegistrationQuestionPushUpViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        else if self.selectedButton == "3"{
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationQuestionPushUpViewController") as! RegistrationQuestionPushUpViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        else{
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TipsViewController") as! TipsViewController
                            vc.getIndex = self.selectedButton
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        
                    }
                    else{
                        UserDefaults.standard.set("0", forKey: K_StepFour)
                        UserDefaults.standard.synchronize()
                        if let message = resultDict?["message"] as? String {
                            Toast.show(message: message, controller: self)
                        }
                    }
                }
                
            }
            else{
                UserDefaults.standard.set("0", forKey: K_StepFour)
                UserDefaults.standard.synchronize()
                self.alert(message: "Something went wrong", title: "")
                if let message = resultDict?["message"] as? String {
                    Toast.show(message: message, controller: self)
                }
            }
        }
    }
}
