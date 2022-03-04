//
//  ActivityRecoveryOopsTimeOverViewController.swift
//  ThinkFit
//
//  Created by apple on 21/09/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class ActivityRecoveryOopsTimeOverViewController: UIViewController {

    
    //MARK:- Outlets
    @IBOutlet weak var topLbl: UILabel!
    @IBOutlet weak var centerLbl: UILabel!
    @IBOutlet weak var bottomLbl: UILabel!
    @IBOutlet weak var timeIsOverView: UIView!
    
    
    //MARK:- Define Variable
    var currenIndex = 0
    var intruptionType = ""
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
       // timeIsOverView.isHidden = true
        
        topLbl.text = "Time is Over"
        centerLbl.text = "00:00"
        bottomLbl.text = "You got [0] Points"
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    
    //MARK:- UIButton Actions 
    @IBAction func doneButtonAction(_ sender: UIButton) {
        
        if intruptionType == "No Intruption Task Complete" {
            self.navigationController?.backToViewController(vc: HomeMyTaskViewController.self)
        }
        else{
            self.navigationController?.backToViewController(vc: ThinkFitFocusTimeViewController.self)
        }
        
    }
}
