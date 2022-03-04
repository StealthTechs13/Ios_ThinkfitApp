//
//  ActivityRecoverySkipOopsViewController.swift
//  ThinkFit
//
//  Created by apple on 06/01/21.
//  Copyright © 2021 Harinder Rana. All rights reserved.
//

import UIKit

class ActivityRecoverySkipOopsViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var oopsLbl: UILabel!
    @IBOutlet weak var zeroPointLbl: UILabel!
    
    
    //MARK:- Define Variable
    var intruptionType = ""
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationSetup()
        oopsLbl.text = "Oops!!"
        zeroPointLbl.text = "Total point of the day: 0"
        
    }
    
    //MARK:- Navigation Setup
    func navigationSetup(){
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        title = "Active Recovery Time"
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    //MARK:- UI Done Button Action
    @IBAction func doneButtonAction(_ sender: Any) {
        if intruptionType == "No Intruption Task Complete"{
            self.navigationController?.backToViewController(vc: HomeMyTaskViewController.self)
        }
        else {
           self.navigationController?.backToViewController(vc: ThinkFitFocusTimeViewController.self)
        }
    }
        
}
