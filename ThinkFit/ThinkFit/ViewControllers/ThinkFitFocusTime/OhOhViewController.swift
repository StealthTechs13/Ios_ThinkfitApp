//
//  OhOhViewController.swift
//  ThinkFit
//
//  Created by apple on 02/12/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class OhOhViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var totalTimeLbl: UILabel!
    @IBOutlet weak var productivityLbl: UILabel!
    
    
    //MARK:- Define Variable
    var timeCount = Int()
    var productivityLevel = ""
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        levelSetup()
    }

    
    func levelSetup(){
        let time = timeCount 
        if time == 5 {
            productivityLbl.text = "Productivity Level : Wonderer"
            productivityLevel = "Wonderer"
        }
        else if time == 10 {
            productivityLbl.text = "Productivity Level : Cloudy"
            productivityLevel = "Cloudy"
        }
        else if time == 15 {
            productivityLbl.text = "Productivity Level : Dreamer"
            productivityLevel = "Dreamer"
        }
        else if time  == 20 {
            productivityLbl.text = "Productivity Level : Sub"
            productivityLevel = "Sub"
        }
        else if time == 25 {
            productivityLbl.text = "Productivity Level : Normal"
            productivityLevel = "Normal"
        }
        else if time == 30 {
            productivityLbl.text = "Productivity Level : Above"
            productivityLevel = "Above"
        }
        else if time == 35 {
            productivityLbl.text = "Productivity Level : Laser"
            productivityLevel = "Laser"
        }
        else if time == 40 {
            productivityLbl.text = "Productivity Level : Expert"
            productivityLevel = "Expert"
        }
        else if time == 45 {
            productivityLbl.text = "Productivity Level : Hero"
            productivityLevel = "Hero"
        }
        else if time == 50 {
            productivityLbl.text = "Productivity Level : Guru"
            productivityLevel = "Guru"
        }
        
        totalTimeLbl.text = "\(timeCount):00"
        
        UserDefaults.standard.setValue(timeCount, forKey: K_defaultTime)
        UserDefaults.standard.set(productivityLevel, forKey: K_Productivity_Level)
        UserDefaults.standard.synchronize()
    
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        self.navigationController?.backToViewController(vc: ThinkFitFocusTimeViewController.self)
        
//        for vc in (self.navigationController?.viewControllers)! {
//            if vc is ThinkFitFocusTimeViewController {
//                self.navigationController?.popToViewController(vc, animated: true)
//            }
//        }
        
    }
    
}
