//
//  ActivityRecoveryTiredTimeDifficultViewController.swift
//  ThinkFit
//
//  Created by apple on 21/09/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class ActivityRecoveryTiredTimeDifficultViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var tooTiredView: UIView!
    @IBOutlet weak var tooTiredLbl: UILabel!
    @IBOutlet weak var tooTiredButton: UIButton!
    @IBOutlet weak var notimeView: UIView!
    @IBOutlet weak var noTimeLbl: UILabel!
    @IBOutlet weak var noTimeButton: UIButton!
    @IBOutlet weak var tooDificultView: UIView!
    @IBOutlet weak var tooDificultLbl: UILabel!
    @IBOutlet weak var tooDificultButton: UIButton!
    
    
    //MARK:- Define Variables
    var remainTime = Int()
    var time = Int()
    var stopTimeToTired = 0
    var toDifficultTime = 0
    var noTime = 0
    var checkFitnessLevel = ""
    var intruptionType = ""
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        
        if UserDefaults.standard.value(forKey: K_Fitness_Level) != nil {
            let fitnesLevel = UserDefaults.standard.value(forKey: K_Fitness_Level)
            checkFitnessLevel = fitnesLevel as? String ?? ""
        }
        
    }
    
    
    //MARK:- UIButton Actions
    @IBAction func tryAnotherButtonAction(_ sender: Any) {
        self.navigationController?.backToViewController(vc: RecoveryRollingViewController.self)
    }
    
    
    /*** Three Button Joint actions ***/
    @IBAction func tooTiredNoTimeTooDificultJointButtonAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            tooTiredView.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.4941176471, blue: 0.1294117647, alpha: 1)
            tooTiredLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            tooTiredView.borderColor = .clear
            notimeView.backgroundColor = .clear
            tooDificultView.backgroundColor = .clear
            noTimeLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            tooDificultLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            notimeView.borderColor = #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 0.65)
            tooDificultView.borderColor = #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 0.6516748716)
            
            if UserDefaults.standard.value(forKey: "stopTimeToTired") != nil{
                
                stopTimeToTired = UserDefaults.standard.value(forKey: "stopTimeToTired") as! Int+1
                UserDefaults.standard.set(stopTimeToTired, forKey: "stopTimeToTired" )
                UserDefaults.standard.synchronize()
                if stopTimeToTired == 2 {
                    stopTimeToTired = 0
                    UserDefaults.standard.removeObject(forKey: "stopTimeToTired")
                    UserDefaults.standard.synchronize()
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ActiveRecoveryTodayTimeViewController") as! ActiveRecoveryTodayTimeViewController
                    vc.increaseTime = time
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                stopTimeToTired = stopTimeToTired + 1
                UserDefaults.standard.set(stopTimeToTired, forKey: "stopTimeToTired" )
                UserDefaults.standard.synchronize()
                if stopTimeToTired == 1 {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HardDayTodayViewController") as! HardDayTodayViewController
                    vc.remainTime = time
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        case 1:
            notimeView.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.4941176471, blue: 0.1294117647, alpha: 1)
            noTimeLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            notimeView.borderColor = .clear
            tooTiredView.backgroundColor = .clear
            tooDificultView.backgroundColor = .clear
            tooTiredLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            tooDificultLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            tooTiredView.borderColor = #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 0.65)
            tooDificultView.borderColor = #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 0.65)
            
            if (UserDefaults.standard.value(forKey: "noTime") != nil) {
                noTime = UserDefaults.standard.value(forKey: "noTime") as! Int
                noTime =  noTime + 1
                UserDefaults.standard.set(noTime, forKey: "noTime")
                UserDefaults.standard.synchronize()
                if noTime == 3 {
                    noTime = 0
                    UserDefaults.standard.removeObject(forKey: "noTime")
                    UserDefaults.standard.synchronize()
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecoveryImportantViewController") as! RecoveryImportantViewController
                    vc.remainTime = time*60
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ActicvityRecoveryMessageViewController") as! ActicvityRecoveryMessageViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else{
                noTime = noTime + 1
                UserDefaults.standard.set(noTime, forKey: "noTime" )
                UserDefaults.standard.synchronize()
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ActicvityRecoveryMessageViewController") as! ActicvityRecoveryMessageViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        case 2:
            tooDificultView.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.4941176471, blue: 0.1294117647, alpha: 1)
            tooDificultLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            tooDificultView.borderColor = .clear
            tooTiredView.backgroundColor = .clear
            notimeView.backgroundColor = .clear
            tooTiredLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            noTimeLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            tooTiredView.borderColor = #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 0.65)
            notimeView.borderColor = #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 0.65)
            
            if (UserDefaults.standard.value(forKey: "toDifficult") != nil) {
                toDifficultTime = UserDefaults.standard.value(forKey: "toDifficult") as! Int
                toDifficultTime =  toDifficultTime + 1
                UserDefaults.standard.set(toDifficultTime, forKey: "toDifficult")
                UserDefaults.standard.synchronize()
                if toDifficultTime == 4 {
                    
                    
                    if checkFitnessLevel == "Unfit" || checkFitnessLevel == "UNFIT"{
                        toDifficultTime = 0
                        UserDefaults.standard.set(toDifficultTime, forKey: "toDifficult")
                        UserDefaults.standard.synchronize()
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TooDificultMessageViewController") as! TooDificultMessageViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                       // self.navigationController?.backToViewController(vc: ThinkFitFocusTimeViewController.self)
                    }
                    else{
                        
                        toDifficultTime = 0
                        UserDefaults.standard.set(toDifficultTime, forKey: "toDifficult")
                        UserDefaults.standard.synchronize()
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ActivateRecoveryFitUnfitViewController") as! ActivateRecoveryFitUnfitViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
 
                }
                else{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TooDificultMessageViewController") as! TooDificultMessageViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else{
                toDifficultTime = toDifficultTime + 1
                UserDefaults.standard.set(toDifficultTime, forKey: "toDifficult" )
                UserDefaults.standard.synchronize()
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TooDificultMessageViewController") as! TooDificultMessageViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        default:
            
            tooTiredView.backgroundColor = .clear
            tooTiredView.borderColor = #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 0.65)
            notimeView.backgroundColor = .clear
            notimeView.borderColor = #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 0.65)
            tooDificultView.backgroundColor = .clear
            tooDificultView.borderColor = #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 0.65)
            tooTiredLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            noTimeLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
            tooDificultLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
        }
    }
    
    
    /*** Skip Button Actions ***/
    @IBAction func skipThisButtonAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ActivityRecoverySkipOopsViewController") as! ActivityRecoverySkipOopsViewController
        vc.intruptionType = intruptionType
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
