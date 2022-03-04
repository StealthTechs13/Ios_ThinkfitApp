//
//  CustomTermsandConditionAlertViewController.swift
//  ThinkFit
//
//  Created by apple on 11/06/21.
//  Copyright © 2021 Harinder Rana. All rights reserved.
//

import UIKit

//MARK:- Set Protocol & Function
protocol TermsConditionCustomAlertViewDelegate: class {
    func popProceedButton()
    func popCancelButton()
}


class CustomTermsandConditionAlertViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet var popUpSuperView: UIView!
    @IBOutlet weak var popUpChildView: UIView!
    @IBOutlet weak var defaultLblFirst: UILabel!
    @IBOutlet weak var defaultLblSecond: UILabel!
    
    
    //MARK:- Define Variable
    let text = "By Clicking proceed you do confirm you have read the Terms and Conditions of the deal and you do agree with ThinkFit General Terms and Conditions, including refund policy, where applicable."
    var delegate: TermsConditionCustomAlertViewDelegate?
    var termsConditionLink = ""
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTextColorChange()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- Change Some Label Text Color
    func lblTextColorChange() {
        let string = NSMutableAttributedString(string: text)
        string.setColorForText("ThinkFit General Terms and Conditions", with: #colorLiteral(red: 0.9843137255, green: 0.4941176471, blue: 0.1294117647, alpha: 1))
        defaultLblSecond.attributedText = string
        defaultLblFirst.text = "Confirm Purchase"
        
        defaultLblSecond.isUserInteractionEnabled = true
        defaultLblSecond.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tap(gesture:))))
    }
    
    //MARK:- Label Tap Action
    @objc func tap(gesture: UITapGestureRecognizer) {
        
        if gesture.didTapAttributedTextInLabelMultiple(label: defaultLblSecond, targetText: "ThinkFit General Terms and Conditions") {
            if let url = URL(string: "https://www.thinkfit.app/terms.html") {
                UIApplication.shared.open(url)
            }
        }
        else {
            print("Tapped none")
        }
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
    
    //MARK:- Cancel Button Action
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate?.popCancelButton()
    }
    
    //MARK:- Procedd Button Action
    @IBAction func proceddButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate?.popProceedButton()
    }
    
}
