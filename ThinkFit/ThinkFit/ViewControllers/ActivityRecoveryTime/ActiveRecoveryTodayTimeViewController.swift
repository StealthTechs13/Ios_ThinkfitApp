//
//  ActiveRecoveryTodayTimeViewController.swift
//  ThinkFit
//
//  Created by apple on 22/09/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class ActiveRecoveryTodayTimeViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var describeLbl: UILabel!
    
    
    //MARK:- Define Variables
    var increaseTime = Int()
    var newTime = Int()
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationbarSetup()
        
        
        if UserDefaults.standard.value(forKey: K_recoveryTimeUpdate) != nil {
            var updateTime = UserDefaults.standard.value(forKey: K_recoveryTimeUpdate) as? Int
             
            if updateTime == 7 {
                updateTime = 7 //updateTime! + 2
                timeLbl.text = "\(String(updateTime!)):00"
                UserDefaults.standard.set(updateTime, forKey: K_recoveryTimeUpdate)
                UserDefaults.standard.synchronize()
            }
            else{
                updateTime = updateTime! + 2
                timeLbl.text = "\(String(updateTime!)):00"
                UserDefaults.standard.set(updateTime, forKey: K_recoveryTimeUpdate)
                UserDefaults.standard.synchronize()
            }

        }
        else{
            let time = 7
            timeLbl.text = "\(String(time)):00"
            UserDefaults.standard.set(time, forKey: K_recoveryTimeUpdate)
            UserDefaults.standard.synchronize()
        }
        
    }

    //MARK:- Define Functions
    func navigationbarSetup(){
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
        title = "Active Recovery Time"
        navigationItem.hidesBackButton = true
    }
    
    
    //MARK:- UIButton Actions
    @IBAction func doneButtonAction(_ sender: Any) {
        self.navigationController?.backToViewController(vc: ThinkFitFocusTimeViewController.self)
    }
    
}
