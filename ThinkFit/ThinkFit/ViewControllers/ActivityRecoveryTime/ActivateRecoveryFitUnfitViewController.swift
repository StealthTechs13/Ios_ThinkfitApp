//
//  ActivateRecoveryFitUnfitViewController.swift
//  ThinkFit
//
//  Created by apple on 07/12/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class ActivateRecoveryFitUnfitViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var fitUnFitSuperFitLbl: UILabel!
    @IBOutlet weak var fitnessColorImage: UIImageView!
    
    
    //MARK:- Define Variables
    var saveFitnesLevel = ""
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        title = "Active Recovery Time"
        checkFitnessLevel()
    }
    
    
    //MARK:- Check Fitness Level
    func checkFitnessLevel(){
    
        if UserDefaults.standard.value(forKey: K_Fitness_Level) != nil {
            let fitnessLevel = UserDefaults.standard.value(forKey: K_Fitness_Level)
            
            if fitnessLevel as? String == "Superfit" || fitnessLevel as? String == "SUPERFIT"{
                fitUnFitSuperFitLbl.text = "FIT"
                saveFitnesLevel = "Fit"
                fitnessColorImage.image = UIImage(named: "icYellowCircleDots")
            }
            else if fitnessLevel as? String == "Fit" || fitnessLevel as? String == "FIT" {
                fitUnFitSuperFitLbl.text = "UNFIT"
                saveFitnesLevel = "Unfit"
                fitnessColorImage.image = UIImage(named: "icGreenCircleDots")
            }
            else if fitnessLevel as? String == "Unfit" || fitnessLevel as? String == "UNFIT"{
                fitUnFitSuperFitLbl.text = "UNFIT"
                saveFitnesLevel = "Unfit"
                fitnessColorImage.image = UIImage(named: "icGreenCircleDots")
            }
        }
        
    }
    
    //MARK:- UIButton Actions
    @IBAction func doneButtonAction(_ sender: Any) {
        updateFitnessLevel()
    }
}


//MARK:- Calling API's
extension ActivateRecoveryFitUnfitViewController {
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
                            
                            
                            if let msg = resultDict?["message"] as? String {
                                Toast.show(message: msg, controller: self)
                            }
                            
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
