//
//  RegistrationDescriptionViewController.swift
//  ThinkFit
//
//  Created by apple on 27/08/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class RegistrationDescriptionViewController: UIViewController {

    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = true
        title = "Registration"
        navigationController?.navigationBar.barStyle = .black
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    //MARK:- Continue Button Action
    @IBAction func continueButtonAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationDepartmentViewController") as! RegistrationDepartmentViewController
               self.navigationController?.pushViewController(vc, animated: true)
    }
}
