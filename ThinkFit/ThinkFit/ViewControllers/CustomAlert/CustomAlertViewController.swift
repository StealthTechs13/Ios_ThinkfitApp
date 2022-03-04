//
//  CustomAlertViewController.swift
//  ThinkFit
//
//  Created by apple on 31/05/21.
//  Copyright © 2021 Harinder Rana. All rights reserved.
//

import UIKit

//MARK:- Set Protocol & Function
protocol CongratulationAlertViewDelegate: class {
    func popOkButton()
}

class CustomAlertViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet var popUpSuperView: UIView!
    @IBOutlet weak var popUpChildView: UIView!
    @IBOutlet weak var firstLbl: UILabel!
    @IBOutlet weak var secondLbl: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    
    //MARK:- Define Variable
    var congratsOrOpps = ""
    var congdescription = ""
    var okdelegagte : CongratulationAlertViewDelegate!
    var comingScreen = ""
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        firstLbl.text = congratsOrOpps
        secondLbl.text = congdescription
        // Do any additional setup after loading the view.
    }
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        setupView()
        animateView()
        //nameTextField.text = textFieldData
    }
    
    //MARK:- SetupView
    func setupView(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        popUpSuperView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    
    //MARK:- Showing alert with Animation
    func animateView() {
        popUpChildView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {() -> Void in
            self.popUpChildView.transform = .identity
        }, completion: {(finished: Bool) -> Void in
            // do something once the animation finishes, put it here
        })
        
    }
    
    //MARK:- Okay Button Action
    @IBAction func okButtonTapped(_ sender: Any) {
        okdelegagte.popOkButton()
        self.dismiss(animated: true, completion: nil)
    }
}
