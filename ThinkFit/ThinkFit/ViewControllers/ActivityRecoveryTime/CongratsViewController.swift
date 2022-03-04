//
//  CongratsViewController.swift
//  ThinkFit
//
//  Created by apple on 07/12/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class CongratsViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var fitUnFitSuperFitLbl: UILabel!
    @IBOutlet weak var fitnessColorImage: UIImageView!
    
    
    //MARK:- Define Variable
    var saveFitnesLevel = ""
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        checkFitnessLevel()
    }
    
    
    
    //MARK:- FitnessLevel Check
    func checkFitnessLevel(){
        
        if UserDefaults.standard.value(forKey: K_Fitness_Level) != nil {
            let fitnessLevel = UserDefaults.standard.value(forKey: K_Fitness_Level)
            
            if fitnessLevel as? String == "Superfit" || fitnessLevel as? String == "SUPERFIT"{
                fitUnFitSuperFitLbl.text = "SUPERFIT"
                saveFitnesLevel = "Superfit"
                fitnessColorImage.image = UIImage(named: "icBlueCircleDots")
            }
            else if fitnessLevel as? String == "Fit" || fitnessLevel as? String == "FIT" {
                fitUnFitSuperFitLbl.text = "SUPERFIT"
                saveFitnesLevel = "Superfit"
                fitnessColorImage.image = UIImage(named: "icBlueCircleDots")
            }
            else if fitnessLevel as? String == "Unfit" || fitnessLevel as? String == "UNFIT" {
                fitUnFitSuperFitLbl.text = "FIT"
                saveFitnesLevel = "Fit"
                fitnessColorImage.image = UIImage(named: "icYellowCircleDots")
            }
        }
        
    }
    
    //MARK:- UIButton Actions
    @IBAction func continueButtonAction(_ sender: Any) {
        updateFitnessLevel()
    }
    
}


//MARK:- Calling API'S
extension CongratsViewController {
    
    func updateFitnessLevel(){
        self.showIndicator()
        
        DataService.sharedInstance.fitnessLevelUpdate(userid: GlobalVariabel.userId, fitnessLevel: saveFitnesLevel) { (resultDict, errorMsg) in
            
            self.hideIndicator()
            
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool {
                    
                    if status == true {
                        
                        if let result = resultDict?["result"] as? String {
                            
                            UserDefaults.standard.set(result, forKey: K_Fitness_Level)
                            UserDefaults.standard.synchronize()
                            
                            self.navigationController?.backToViewController(vc: ThinkFitFocusTimeViewController.self)
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
                if let message = resultDict?["message"] as? String {
                    Toast.show(message: message, controller: self)
                }
            }
        }
    }
}
