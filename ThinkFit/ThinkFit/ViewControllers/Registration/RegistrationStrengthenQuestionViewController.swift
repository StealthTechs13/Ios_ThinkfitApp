//
//  RegistrationStrengthenQuestionViewController.swift
//  ThinkFit
//
//  Created by apple on 28/08/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class RegistrationStrengthenQuestionViewController: UIViewController {
    
    //MARK:- Outltes
    @IBOutlet weak var atleastTwoDaysButton: UIButton!
    @IBOutlet weak var oneDayButton: UIButton!
    @IBOutlet weak var hardlyEverButton: UIButton!
    @IBOutlet weak var atleastTwoDayLbl: UILabel!
    @IBOutlet weak var oneDayLbl: UILabel!
    @IBOutlet weak var hardlyEverLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var noticeQuestionLbl: UILabel!
    @IBOutlet weak var noticeLbl: UILabel!
    @IBOutlet weak var noticeBackGroundView: UIView!
    @IBOutlet weak var noticeView: UIView!
    @IBOutlet weak var noticeContinueButton: UIButton!
    
    //MARK:- Define Variable
    var buttonSelected = ""
    let text = "How many days a week do you do activities that strengthen your muscles?"
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        noticeBackGroundView.isHidden = true
        noticeView.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .black
       // self.navigationItem.setHidesBackButton(true, animated: true)
        title = "Registration"

        let leftBarButton = UIBarButtonItem(image: UIImage(named: "icBackArrowWhite"), style: .done, target: self, action: #selector(self.icBackButtonAction))
        self.navigationItem.leftBarButtonItem  = leftBarButton
        
        changeTextColor()
    }
    
    @objc func icBackButtonAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Change TextColor
    func changeTextColor(){
        let string = NSMutableAttributedString(string: "How many days a week do you do activities that strengthen your muscles?")
        string.setColorForText("strengthen", with: #colorLiteral(red: 0.9843137255, green: 0.4941176471, blue: 0.1294117647, alpha: 1))
        descriptionLbl.attributedText = string
       // descriptionLbl.attributedText = string
        descriptionLbl.isUserInteractionEnabled = true
        descriptionLbl.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tap(gesture:))))
        
    }
    
    @objc func tap(gesture: UITapGestureRecognizer) {
        
        if gesture.didTapAttributedTextInLabelMultiple(label: descriptionLbl, targetText: "strengthen") {
            noticeBackGroundView.isHidden = false
            noticeView.isHidden = false
            noticeQuestionLbl.text = "What are muscle strengthening activities?"
            noticeLbl.text = "Besides aerobic activity, you need to do things to strengthen your muscles at least two days a week. These activities should work all the major muscle groups of your body (legs, hips, back, chest, abdomen, shoulders, and arms). \n \n Examples include lifting weights, doing exercises that use your body weight for resistance (eg sit-ups, push-ups), heavy gardening or manual work, yoga or tai chi. \n \n To gain health benefits, muscle-strengthening activities need to be done to the point where it's hard for you to do another repetition without help."
        } else {
            print("Tapped none")
        }
        
        
    }
    
    
    //MARK:- UIButton Actions
    /*** Joint button Action to Atleat,One,Hardly ***/
    @IBAction func jointButtonAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            atleastTwoDaysButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
            oneDayButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            hardlyEverButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            atleastTwoDayLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            oneDayLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            hardlyEverLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            buttonSelected = "2"
        case 1:
            atleastTwoDaysButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            oneDayButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
            hardlyEverButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            atleastTwoDayLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            oneDayLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            hardlyEverLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            buttonSelected = "1"
        case 2:
            atleastTwoDaysButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            oneDayButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            hardlyEverButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
            atleastTwoDayLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            oneDayLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            hardlyEverLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            buttonSelected = "0"
            
        default:
            atleastTwoDaysButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            oneDayButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            hardlyEverButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
            atleastTwoDayLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            oneDayLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            hardlyEverLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            buttonSelected = ""
        }
        
    }
    
  
    /*** Notice Continue Button Action ***/
    @IBAction func noticeContinueButtonAction(_ sender: Any) {
        noticeBackGroundView.isHidden = true
        noticeView.isHidden = true
    }
    
    /*** Next Screen Button Action ***/
    @IBAction func nextScreenButtonAction(_ sender: Any) {
         questionTwoAPI()
    }
    
}


//MARK:- API Setup
extension RegistrationStrengthenQuestionViewController {
    
    /*** Question Two API ***/
    func questionTwoAPI(){
        self.showIndicator()
        DataService.sharedInstance.questionTwo(userId: GlobalVariabel.userId, question: buttonSelected) { (resultDict, errorMsg) in
            self.hideIndicator()
            
            if errorMsg == nil {
                
                print(resultDict as Any)
                
                
                if let status = resultDict?["status"] as? Bool{
                    if status == true {
                        
                        UserDefaults.standard.removeObject(forKey: K_StepThree)
                        UserDefaults.standard.synchronize()
                        if let message = resultDict?["message"] as? String {
                            Toast.show(message: message, controller: self)
                        }
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WoowCoolWellViewController") as! WoowCoolWellViewController
                        vc.getIndex = self.buttonSelected
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }
                    else{
                        UserDefaults.standard.set("0", forKey: K_StepThree)
                        UserDefaults.standard.synchronize()
                        if let message = resultDict?["message"] as? String {
                            Toast.show(message: message, controller: self)
                        }
                    }
                }
                
            }
            else{
                UserDefaults.standard.set("0", forKey: K_StepThree)
                UserDefaults.standard.synchronize()
                self.alert(message: "Something went wrong", title: "")
                if let message = resultDict?["message"] as? String {
                    Toast.show(message: message, controller: self)
                }
            }
        }
    }
}
