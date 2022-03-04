//
//  RecoveryImportantViewController.swift
//  ThinkFit
//
//  Created by apple on 23/12/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class RecoveryImportantViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    
    //MARK:- Define Variable
    var notimeUpdateTime = Int()
    var remainTime = Int()

    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        
        if UserDefaults.standard.value(forKey: K_recoveryTimeUpdate) != nil {
            var getTime = UserDefaults.standard.value(forKey: K_recoveryTimeUpdate) as! Int
            
            if getTime == 3 {
                getTime = 3
                timeLbl.text = "\(String(getTime)):00"
                descriptionLbl.text = "It looks you are super busy !. What if I deduct your recovery time to 3 Minutes."
                UserDefaults.standard.set(getTime, forKey: K_recoveryTimeUpdate)
                UserDefaults.standard.synchronize()
            }
            else{
                getTime = getTime - 2
                descriptionLbl.text = "It looks you are super busy !. What if I deduct your recovery time to 3 Minutes."
                timeLbl.text = "\(String(getTime)):00"
                UserDefaults.standard.set(getTime, forKey: K_recoveryTimeUpdate)
                UserDefaults.standard.synchronize()
                
            }
            print(getTime)
            
        }
        else{
            let time = 3
            timeLbl.text = "\(String(time)):00"
            descriptionLbl.text = "It looks you are super busy !. What if I deduct your recovery time to 3 Minutes."
            UserDefaults.standard.set(time, forKey: K_recoveryTimeUpdate)
            UserDefaults.standard.synchronize()
        }
        
    }

    //MARK:- UIButton Actions
    @IBAction func dealButtonAction(_ sender: Any) {
        self.navigationController?.backToViewController(vc: ThinkFitFocusTimeViewController.self)

    }
    
}
