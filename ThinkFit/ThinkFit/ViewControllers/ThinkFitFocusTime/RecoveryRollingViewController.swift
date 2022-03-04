//
//  RecoveryRollingViewController.swift
//  ThinkFit
//
//  Created by apple on 04/12/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit
import SideMenu

func didSelectData(_ selectedIndex: Int) {
    
}

class RecoveryRollingViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var navigationBarView: UIView!
    @IBOutlet weak var navigationBarViewHeight: NSLayoutConstraint!
    @IBOutlet weak var productivityView: UIView!
    @IBOutlet weak var fitnessView: UIView!
    @IBOutlet weak var productivityNameLbl: UILabel!
    @IBOutlet weak var fitnessPointLbl: UILabel!
    
    @IBOutlet weak var timerCountLbl: UILabel!
    @IBOutlet weak var startRecoveryTimeButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    //MARK:- Define Variables
    var seconds = Int()
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    var selectedPreviousIndex = 0
    
    //MARK:- resetMidNightTimeCount
    var recoveryResetTime = 5
    var stopTimeToTired = 0
    var toDifficultTime = 0
    var noTime = 0
    var recoveryScreenVcTime = 0
    var noIntruptionTaskComplete = ""
    
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        checkRecoveryCount()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- Check RecoveryCount
    func checkRecoveryCount(){
    
        if UserDefaults.standard.value(forKey: K_Recovery_Count) != nil {
            let recoveryCount = UserDefaults.standard.value(forKey: K_Recovery_Count)
            self.recoveryScreenVcTime = recoveryCount as! Int+1
            UserDefaults.standard.set(self.recoveryScreenVcTime, forKey: K_Recovery_Count)
            UserDefaults.standard.synchronize()
        }
        else{
            self.recoveryScreenVcTime = self.recoveryScreenVcTime+1
            UserDefaults.standard.set(self.recoveryScreenVcTime, forKey: K_Recovery_Count)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    
    
    //MARK:- ViewLayout
    override func viewWillLayoutSubviews() {
        if UIScreen.main.bounds.size.height <= 736{
            navigationBarViewHeight?.constant = 64
            self.view.layoutIfNeeded()
        }
        else{
            navigationBarViewHeight?.constant = 90
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationBarSetup()
        uiViewSetup()
        productAndFitnessViewSetup()
        //checkDateandCallApi()
        checkTime()
        recoveryExcersiceUpdate()
    }
    
    //MARK:- recoveryExcersiceCount
    func recoveryExcersiceUpdate(){
        
    }
    
    //MARK:- Function Working
    func productAndFitnessViewSetup(){
        fitnessView.layer.cornerRadius = 21
        fitnessView.layer.masksToBounds = true
        fitnessView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
        productivityView.layer.cornerRadius = 21
        productivityView.layer.masksToBounds = true
        productivityView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
    }
    
    //MARK:- HideUnhide or NavigationBar setup
    func navigationBarSetup(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    
    //MARK:- viewLabel Setup
    func uiViewSetup(){
                
        if UserDefaults.standard.value(forKey: K_TotalPoint) != nil {
            if let totalPoint = UserDefaults.standard.value(forKey: K_TotalPoint){
                fitnessPointLbl.text = totalPoint as? String ?? ""
            }
        }
        else{
            fitnessPointLbl.text = ""
        }
//
//        let getvalue = GlobalVariabel.additional_Point
//        fitnessPointLbl.text = getvalue
        
        if let level = UserDefaults.standard.value(forKey: K_Productivity_Level) {
            productivityNameLbl.text = level as? String
        }
        
        
    }
    
    
    //MARK:- Checking TimeValue
    func checkTime(){
        if UserDefaults.standard.value(forKey: K_recoveryTimeUpdate) != nil {
            let newtime = UserDefaults.standard.value(forKey: K_recoveryTimeUpdate) as! Int
            seconds = newtime*60
            timerCountLbl.text = timeString(time: TimeInterval(seconds))
        }
        else{
            seconds =  5*60
            timerCountLbl.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    
    //MARK:- Today_Tommorow_Date checking
    func checkDateandCallApi(){
        
        if UserDefaults.standard.value(forKey: K_todayTomorrowDate) != nil {
            let today =   Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            let todayStr = dateFormatter.string(from: today)
            let oldDatestr = UserDefaults.standard.value(forKey: K_todayTomorrowDate) as? String ?? ""
        
            if oldDatestr == todayStr{
                checkTime()
            }
            else{
                UserDefaults.standard.setValue(todayStr, forKey: K_todayTomorrowDate)
                UserDefaults.standard.setValue(recoveryResetTime, forKey: K_recoveryTimeUpdate)
                UserDefaults.standard.set(stopTimeToTired, forKey: "stopTimeToTired")
                UserDefaults.standard.set(noTime, forKey: "noTime")
                UserDefaults.standard.set(toDifficultTime, forKey: "toDifficult")
                UserDefaults.standard.synchronize()
                seconds = 5*60
                timerCountLbl.text = timeString(time: TimeInterval(seconds))
            }
        }
        else{
            let today =   Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            let todayStr = dateFormatter.string(from: today)
            // let dateToday = dateFormatter.date(from: todayStr)
            UserDefaults.standard.setValue(todayStr, forKey: K_todayTomorrowDate)
            UserDefaults.standard.setValue(recoveryResetTime, forKey: K_recoveryTimeUpdate)
            UserDefaults.standard.removeObject(forKey: K_recoveryTimeUpdate)
            UserDefaults.standard.set(stopTimeToTired, forKey: "stopTimeToTired")
            UserDefaults.standard.set(noTime, forKey: "noTime")
            UserDefaults.standard.set(toDifficultTime, forKey: "toDifficult")
            UserDefaults.standard.synchronize()
            seconds = 5*60
            timerCountLbl.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    //MARK:- UIButton Actions
    @IBAction func startRecoveryTimeButtonAction(_ sender: Any) {
        if isTimerRunning == false {
            // runTimer()
            if UserDefaults.standard.value(forKey: K_recoveryExcersice_Update) != nil {
                let val = UserDefaults.standard.value(forKey: K_recoveryExcersice_Update)
                selectedPreviousIndex = val as! Int+1
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ActivityRecoveryTimeViewController") as! ActivityRecoveryTimeViewController
                vc.selectTime = seconds
                vc.selectedIndex = selectedPreviousIndex
                vc.intruptionType = noIntruptionTaskComplete
                self.navigationController?.pushViewController(vc, animated: true)
                UserDefaults.standard.set(selectedPreviousIndex, forKey: K_recoveryExcersice_Update)
                UserDefaults.standard.synchronize()
                
            }
            else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ActivityRecoveryTimeViewController") as! ActivityRecoveryTimeViewController
                vc.selectTime = seconds
                vc.selectedIndex = 0
                vc.intruptionType = noIntruptionTaskComplete
                self.navigationController?.pushViewController(vc, animated: true)
                UserDefaults.standard.set(selectedPreviousIndex, forKey: K_recoveryExcersice_Update)
                UserDefaults.standard.synchronize()
                // selectedPreviousIndex = 0
            }
            //            UserDefaults.standard.set(selectedPreviousIndex, forKey: K_recoveryExcersice_Update)
            //            UserDefaults.standard.synchronize()
            
            // self.startButton.isEnabled = false
        }
    }
    
    //MARK:- Start Timer
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
        // pauseButton.isEnabled = true
    }
    
    //MARK:- Update Timer
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            print("time is over")
            //Send alert to indicate time's up.
        } else {
            seconds -= 1
            timerCountLbl.text = timeString(time: TimeInterval(seconds*60))
        }
    }
    
    //MARK:- Set TimeInterVal String
    func timeString(time:TimeInterval) -> String {
        // let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    
    //MARK:- UIButton Actions
    @IBAction func navigationLeftButtonAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "menuLeftNavigationController") as! SideMenuNavigationController
        nextViewController.leftSide = true
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    
    /*** Skip Button ***/
    @IBAction func skipButtonAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ActivityRecoveryTiredTimeDifficultViewController") as! ActivityRecoveryTiredTimeDifficultViewController
        vc.remainTime = Int(TimeInterval(seconds))
        vc.time = seconds
        vc.intruptionType = noIntruptionTaskComplete
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

