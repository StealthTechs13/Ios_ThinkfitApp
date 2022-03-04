//
//  RegistrationSuperFitUnfitViewController.swift
//  ThinkFit
//
//  Created by apple on 22/09/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class RegistrationSuperFitUnfitViewController: UIViewController {
    
    //MARK:- Define Outlets
    @IBOutlet weak var bottomNoticeView: UIView!
    @IBOutlet weak var FitUnFitSuperFitLbl: UILabel!
    @IBOutlet weak var fitnessColorImage: UIImageView!
    @IBOutlet weak var bottomSheetBlackView: UIView!
    @IBOutlet weak var whatisThisButton: UIButton!
    @IBOutlet weak var bottomSheetLbl: UILabel!
    @IBOutlet weak var bottomSheetClosebutton: UIButton!
    
    //MARK:- Define Variables
    var totalPoint = ""
    var sendFitnessLevel = ""
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomNoticeView.isHidden = true
        bottomSheetBlackView.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationbarSetup()
        uILabelSetUp()
        
    }
    
    
    func uILabelSetUp(){
        
        //**** Point SetUp ****////
        let pointVal = GlobalVariabel.totalPoint
        let intVal = Int(pointVal)
        if intVal ?? 0 >= 0 && intVal ?? 0 <= 6 {
            FitUnFitSuperFitLbl.text = "UNFIT"
            sendFitnessLevel = "Unfit"
            fitnessColorImage.image = UIImage(named: "icGreenCircleDots")
            bottomSheetLbl.text = "Based on your responses today you're not very \n active and struggling with motivation. Start \n small and build up. You’ll soon gain in \n confidence and feel better."
        }
        else if intVal ?? 0 > 6 && intVal ?? 0 <= 12 {
            FitUnFitSuperFitLbl.text = "FIT"
            sendFitnessLevel = "Fit"
            fitnessColorImage.image = UIImage(named: "icYellowCircleDots")
            bottomSheetLbl.text = "Based on your responses today you’re physically \n active but not quite meeting recommended \n levels."
        }
        else if intVal ?? 0 > 12 && intVal ?? 0 <= 16 && intVal ?? 0 > 16 {
            FitUnFitSuperFitLbl.text = "SUPERFIT"
            sendFitnessLevel = "Superfit"
            fitnessColorImage.image = UIImage(named: "icBlueCircleDots")
            bottomSheetLbl.text = "Based on your responses today you are close to \n meeting or exceeding the recommended levels \n of physical activity. This is great for your health. \n Keep up the good work."
        }
        
    }
    
    //MARK:- Navigation Button Action
    func navigationbarSetup(){
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .black
        title = "Registration"
        navigationItem.hidesBackButton = true
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "icBackArrowWhite"), style: .done, target: self, action: #selector(self.icBackButtonAction))
        self.navigationItem.leftBarButtonItem  = leftBarButton
        
    }
    
    @objc func icBackButtonAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- UIButton Actions
    
    /*** Close Button Action ***/
    @IBAction func closeButtonAction(_ sender: Any) {
        bottomNoticeView.isHidden = true
        bottomSheetBlackView.isHidden = true
    }
    
    /*** Continue Button Action ***/
    @IBAction func continueButtonAction(_ sender: Any) {
        updateFitnessLevel()
       
        
    }
    
    /*** What Is This Button Action ***/
    @IBAction func whatIsThisButtonAction(_ sender: Any) {
        bottomNoticeView.isHidden = false
        bottomSheetBlackView.isHidden = false
        uILabelSetUp()
    }
    
}


//MARK:- Calling API'S
extension RegistrationSuperFitUnfitViewController {
    
    /*** Update Fitness Level ***/
    func updateFitnessLevel(){
        self.showIndicator()
        
        DataService.sharedInstance.fitnessLevelUpdate(userid: GlobalVariabel.userId, fitnessLevel: FitUnFitSuperFitLbl.text ?? "" ) { (resultDict, errorMsg) in
            
            self.hideIndicator()
            
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool {
                    
                    if status == true {
                        
                        if let result = resultDict?["result"] as? String {
                            
                            UserDefaults.standard.set(result, forKey: K_Fitness_Level)
                            UserDefaults.standard.synchronize()
                            
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeMyTaskViewController") as! HomeMyTaskViewController
                            self.navigationController?.navigationBar.isTranslucent = false
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                    else{
                        if let message = resultDict?["message"] as? String {
                            Toast.show(message: message, controller: self)
                        }
                    }
                }
                
            }
            else{
                self.alert(message: "Something went wrong", title: "")
                if let message = resultDict?["message"] as? String {
                    Toast.show(message: message, controller: self)
                }
            }
        }
    }
    
    
}
