//
//  RegistrationQuestionPushUpViewController.swift
//  ThinkFit
//
//  Created by apple on 28/08/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class RegistrationQuestionPushUpViewController: UIViewController {
    
    //MARK:- Outltes
    @IBOutlet weak var sitUpButton: UIButton!
    @IBOutlet weak var sitUpTopButton: UIButton!
    @IBOutlet weak var pushUpButton: UIButton!
    @IBOutlet weak var pushUpTopButton: UIButton!
    @IBOutlet weak var touchToesButton: UIButton!
    @IBOutlet weak var touchToesTopButton: UIButton!
    @IBOutlet weak var starJumpsButton: UIButton!
    @IBOutlet weak var starJumpTopButton: UIButton!
    @IBOutlet weak var noneOfTheseButton: UIButton!
    @IBOutlet weak var noneofTopButton: UIButton!
    @IBOutlet weak var sitUpLbl: UILabel!
    @IBOutlet weak var pushUpLbl: UILabel!
    @IBOutlet weak var touchYourTossLbl: UILabel!
    @IBOutlet weak var starJumpsLbl: UILabel!
    @IBOutlet weak var noneOfTheseLbl: UILabel!
    
    
    //MARK:- Define Variable
    var selectedButton = ""
    var selectedButtonValue = [String]()
    
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
        self.navigationItem.setHidesBackButton(true, animated: true)
        title = "Registration"
    }
    
    //MARK:- UIButton
    
    /*** SitUp Button Action ***/
    @IBAction func sitUpButtonAction(_ sender: UIButton) {
        
        if sitUpButton.tag == 0 && sitUpTopButton.tag == 0 {
            sitUpButton.tag = 1
            sitUpTopButton.tag = 1
            noneOfTheseButton.tag = 0
            noneofTopButton.tag = 0
            sitUpButton.setImage(#imageLiteral(resourceName: "icSelectedCheckbox"), for: .normal)
            sitUpLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            selectedButton = "2"
            selectedButtonValue.append(selectedButton)
            print(selectedButtonValue)
            noneOfTheseButton.setImage(#imageLiteral(resourceName: "icUnselectedCheckbox"), for: .normal)
            noneOfTheseLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
        }
        else{
            sitUpButton.tag = 0
            sitUpTopButton.tag = 0
            sitUpButton.setImage(#imageLiteral(resourceName: "icUnselectedCheckbox"), for: .normal)
            sitUpLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            print(selectedButtonValue)
            if selectedButtonValue.contains(selectedButton){
                let index = selectedButtonValue.firstIndex(where: {$0 == selectedButton})
                selectedButtonValue.remove(at: index!)
            }
            print(selectedButtonValue)
        }
    }
    
    /*** Push Up Button Action ***/
    @IBAction func pushUpButtonAction(_ sender: UIButton) {
        if pushUpButton.tag == 0 && pushUpTopButton.tag == 0 {
            pushUpButton.tag = 1
            pushUpTopButton.tag = 1
            noneOfTheseButton.tag = 0
            noneofTopButton.tag = 0
            pushUpButton.setImage(#imageLiteral(resourceName: "icSelectedCheckbox"), for: .normal)
            pushUpLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            selectedButton = "2"
            selectedButtonValue.append(selectedButton)
            print(selectedButtonValue)
            noneOfTheseButton.setImage(#imageLiteral(resourceName: "icUnselectedCheckbox"), for: .normal)
            noneOfTheseLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
        }
        else{
            pushUpButton.tag = 0
            pushUpTopButton.tag = 0
            pushUpButton.setImage(#imageLiteral(resourceName: "icUnselectedCheckbox"), for: .normal)
            pushUpLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            print(selectedButtonValue)
            if selectedButtonValue.contains(selectedButton){
                let index = selectedButtonValue.firstIndex(where: {$0 == selectedButton})
                selectedButtonValue.remove(at: index!)
            }
            print(selectedButtonValue)
        }
        
    }
    
    /*** Touch Your Toes Button Action ***/
    @IBAction func touchYourToesButtonAction(_ sender: UIButton) {
        
        if touchToesButton.tag == 0 && touchToesTopButton.tag == 0 {
            touchToesButton.tag = 1
            touchToesTopButton.tag = 1
            noneOfTheseButton.tag = 0
            noneofTopButton.tag = 0
            touchToesButton.setImage(#imageLiteral(resourceName: "icSelectedCheckbox"), for: .normal)
            touchYourTossLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            selectedButton = "1"
            selectedButtonValue.append(selectedButton)
            print(selectedButtonValue)
            noneOfTheseButton.setImage(#imageLiteral(resourceName: "icUnselectedCheckbox"), for: .normal)
            noneOfTheseLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
        }
        else{
            touchToesButton.tag = 0
            touchToesTopButton.tag = 0
            touchToesButton.setImage(#imageLiteral(resourceName: "icUnselectedCheckbox"), for: .normal)
            touchYourTossLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            if selectedButtonValue.contains(selectedButton){
                let index = selectedButtonValue.firstIndex(where: {$0 == selectedButton})
                selectedButtonValue.remove(at: index!)
            }
            print(selectedButtonValue)
        }
    }
    
    /*** Star Jump Button Action ***/
    @IBAction func starJumpsButtonAction(_ sender: UIButton) {
        if starJumpsButton.tag == 0 && starJumpTopButton.tag == 0 {
            starJumpsButton.tag = 1
            starJumpTopButton.tag = 1
            noneOfTheseButton.tag = 0
            noneofTopButton.tag = 0
            starJumpsButton.setImage(#imageLiteral(resourceName: "icSelectedCheckbox"), for: .normal)
            starJumpsLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            selectedButton = "2"
            selectedButtonValue.append(selectedButton)
            noneOfTheseButton.setImage(#imageLiteral(resourceName: "icUnselectedCheckbox"), for: .normal)
            noneOfTheseLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            print(selectedButtonValue)
        }
        else{
            starJumpsButton.tag = 0
            starJumpTopButton.tag = 0
            starJumpsButton.setImage(#imageLiteral(resourceName: "icUnselectedCheckbox"), for: .normal)
            starJumpsLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            print(selectedButtonValue)
            if selectedButtonValue.contains(selectedButton){
                let index = selectedButtonValue.firstIndex(where: {$0 == selectedButton})
                selectedButtonValue.remove(at: index!)
            }
            print(selectedButtonValue)
        }
    }
    
    /*** None of These Button Action ***/
    @IBAction func noneOfTheseButtonAction(_ sender: UIButton) {
        if noneOfTheseButton.tag == 0 && noneofTopButton.tag == 0 {
            noneOfTheseButton.tag = 1
            noneofTopButton.tag = 1
            sitUpButton.tag = 0
            sitUpTopButton.tag = 0
            pushUpButton.tag = 0
            pushUpTopButton.tag = 0
            touchToesButton.tag = 0
            touchToesTopButton.tag = 0
            starJumpsButton.tag = 0
            starJumpTopButton.tag = 0
            noneOfTheseButton.setImage(#imageLiteral(resourceName: "icSelectedCheckbox"), for: .normal)
            sitUpButton.setImage(#imageLiteral(resourceName: "icUnselectedCheckbox"), for: .normal)
            sitUpLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            pushUpButton.setImage(#imageLiteral(resourceName: "icUnselectedCheckbox"), for: .normal)
            pushUpLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            touchToesButton.setImage(#imageLiteral(resourceName: "icUnselectedCheckbox"), for: .normal)
            touchYourTossLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            starJumpsButton.setImage(#imageLiteral(resourceName: "icUnselectedCheckbox"), for: .normal)
            starJumpsLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            noneOfTheseLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            selectedButton = "0"
            selectedButtonValue.removeAll()
            selectedButtonValue.append(selectedButton)
            print(selectedButtonValue)
        }
        else{
            noneOfTheseButton.tag = 0
            noneofTopButton.tag = 0
            noneOfTheseButton.setImage(#imageLiteral(resourceName: "icUnselectedCheckbox"), for: .normal)
            noneOfTheseLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            print(selectedButtonValue)
        }
    }
    
    /*** Continue Button Action ***/
    @IBAction func continueButtonAction(_ sender: Any) {
        let array = selectedButtonValue
        let datastring = array.joined(separator: ",")
        print(datastring)
        questionFourAPI(value: datastring)
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationQuestionWorkstationViewController") as! RegistrationQuestionWorkstationViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}



//MARK:- API Setup
extension RegistrationQuestionPushUpViewController{
    
    /*** Question Four API ***/
    func questionFourAPI(value : String){
        
        self.showIndicator()
        
        DataService.sharedInstance.questionFour(userId: GlobalVariabel.userId, question: value) { (resultDict, errorMsg) in
            
            self.hideIndicator()
            
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool {
                    if status == true {
                        
                        UserDefaults.standard.removeObject(forKey: K_StepFive)
                        UserDefaults.standard.synchronize()
                        if let message = resultDict?["message"] as? String {
                            Toast.show(message: message, controller: self)
                        }
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationQuestionWorkstationViewController") as! RegistrationQuestionWorkstationViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else{
                        UserDefaults.standard.set("0", forKey: K_StepFive)
                        UserDefaults.standard.synchronize()
                        if let message = resultDict?["message"] as? String {
                            Toast.show(message: message, controller: self)
                        }
                    }
                }
                
            }
            else{
                UserDefaults.standard.set("0", forKey: K_StepFive)
                UserDefaults.standard.synchronize()
                self.alert(message: "Something went wrong", title: "")
                if let message = resultDict?["message"] as? String {
                    Toast.show(message: message, controller: self)
                }
            }
        }
        
    }
}
