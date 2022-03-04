//
//  WoowCoolWellViewController.swift
//  ThinkFit
//
//  Created by apple on 28/08/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class WoowCoolWellViewController: UIViewController {
    
    //MARK:- Outltes
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    
    //MARK:- Define Variable
    var currenIndex = 0
    var getIndex = ""
    
    //MARK:- ViewDidLoad
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
        
        if getIndex == "2" {
            nameLbl.text = "Wow!"
            descriptionLbl.text = "You’re already working on strengthening your muscles which is great for your health."
        }
        else if getIndex == "1" {
            nameLbl.text = "Cool!"
            descriptionLbl.text = "You’re already working on your muscle strength which is great for your health. By increasing it to two days a week you’ll gain maximum health benefits"
        }
        else if getIndex == "0" {
            nameLbl.text = "Well!"
            descriptionLbl.text = "you need to work on your muscle strength. Try doing exercises that use your body weight for resistance. We are here for that!"
        }
        
    }
    
    //MARK:- Continue Button Actions
    @IBAction func continueButtonAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationQuestionClimbingViewController") as! RegistrationQuestionClimbingViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
