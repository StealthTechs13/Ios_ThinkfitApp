//
//  TipsViewController.swift
//  ThinkFit
//
//  Created by apple on 28/08/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class TipsViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var tipLbl: UILabel!
    @IBOutlet weak var tipDescriptionLbl: UILabel!
    
    //MARK:- Define Variable
    var currenIndex = 0
    var getIndex = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isCommingScreenSetup()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK:- This Function to Set Label Text
    func isCommingScreenSetup(){
        if getIndex == "4" {
            tipLbl.text = "Tip!"
            tipDescriptionLbl.text = "Avoid taking the lift or escalator every time and start using the stairs. It’s an easy way to build activity into your day!"
        }
        else if getIndex == "3" {
           tipLbl.text = "Tip!"
            tipDescriptionLbl.text = "Try to make small changes in your day to increase your activity levels. Over time you'll be able to climb stairs without feeling exhausted!"
        }
        else if getIndex == "2" {
            tipLbl.text = "Tip!"
            tipDescriptionLbl.text = "Avoid taking the lift or escalator every time and start using the stairs. It’s an easy way to build activity into your day!"
        
        }
        else if getIndex == "1" {
            tipLbl.text = "Tip!"
                       tipDescriptionLbl.text = "Try to make small changes in your day to increase your activity levels. Over time you'll be able to climb stairs without feeling exhausted!"
        }
        else if getIndex == "0"{
            tipLbl.text = "Tip!"
            tipDescriptionLbl.text = "Not being able to climb stairs may suggest you need to see your GP for a health check."
        }
        
    }
    
    
    //MARK:- Continue Button Action
    @IBAction func continueButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationQuestionPushUpViewController") as! RegistrationQuestionPushUpViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
