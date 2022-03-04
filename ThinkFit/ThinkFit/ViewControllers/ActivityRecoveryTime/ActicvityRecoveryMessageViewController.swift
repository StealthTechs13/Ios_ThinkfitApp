//
//  ActicvityRecoveryMessageViewController.swift
//  ThinkFit
//
//  Created by apple on 22/09/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class ActicvityRecoveryMessageViewController: UIViewController {
    
    //MARK:- ViewDidload
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationbarSetup()
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
    @IBAction func youAreRightButtonAction(_ sender: Any) {
        self.navigationController?.backToViewController(vc: RecoveryRollingViewController.self)
       
    }
    
    @IBAction func yesButtonAction(_ sender: Any) {
        self.navigationController?.backToViewController(vc: ThinkFitFocusTimeViewController.self)

    }
    
}
