//
//  ActivityTimeOverViewController.swift
//  ThinkFit
//
//  Created by apple on 07/12/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class ActivityTimeOverViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var timeIsOverLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var pointLbl: UILabel!
    

    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        title = "Active Recovery Time"
        lblSetUp()
    }
    
    
    //MARK:- Functions Setup
    func lblSetUp(){
        timeIsOverLbl.text = "Time is Over"
        timeLbl.text = "00:00"
        pointLbl.text = "You got \("[0]") Points"
        
    }
    
    //MARK:- UIButton Actions
    @IBAction func DoneButtonAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ThinkFitFocusTimeViewController") as! ThinkFitFocusTimeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
