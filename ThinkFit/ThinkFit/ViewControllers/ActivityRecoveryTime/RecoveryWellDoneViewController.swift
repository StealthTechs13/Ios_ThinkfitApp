//
//  RecoveryWellDoneViewController.swift
//  ThinkFit
//
//  Created by apple on 07/12/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit
import SideMenu
protocol customDelegate: class {
    func didSelectData(_ remainingTime: String, _ selectedIndex: Int)
}

class RecoveryWellDoneViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var productivityView: UIView!
    @IBOutlet weak var fitnessPointView: UIView!
    @IBOutlet weak var navigationBarViewHeight: NSLayoutConstraint!
    @IBOutlet weak var restTimeLbl: UILabel!
    @IBOutlet weak var productivityNameLbl: UILabel!
    @IBOutlet weak var fitnessPointLbl: UILabel!
    @IBOutlet weak var totalPointLbl: UILabel!
    @IBOutlet weak var userActivityImage: UIImageView!
    
    
    //MARK:- Define Variable
    var remaningtime = ""
    var increasePoint = ""
    var delegate: customDelegate?
    var selectedPreviousIndex = 0
    var addPoint = ""
    var seconds = Int()
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    var intruptionType = ""
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        // registerBackgroundTask()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- This Function to Check time to application Background
    @objc func appMovedToBackground() {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "HH:mm:ss"
        let dateString = df.string(from: date)
        print(dateString)
        UserDefaults.standard.set(dateString, forKey: "LastTimeBackground")
        UserDefaults.standard.synchronize()
        if restTimeLbl.text?.count ?? 0 > 0 {
            UserDefaults.standard.set(seconds, forKey: "LastSecondBackground")
            UserDefaults.standard.synchronize()
        }
        print(seconds)
        print("App moved to background!")
    }
    
    //MARK:- This Function to Check after background app back in front
    @objc func appMovedToForground() {
        timedifference()
        print(seconds)
        print("App moved to forground!")
    }
    
    
    //MARK:- This function to set timeDifference and set new time.
    func timedifference(){
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "HH:mm:ss"
        let dateString = df.string(from: date)
        print(dateString)
        var time1 = ""
        if UserDefaults.standard.value(forKey: "LastTimeBackground") != nil {
            time1 = UserDefaults.standard.value(forKey: "LastTimeBackground") as? String ?? ""
        }else{
            time1 = "10:30AM"
        }
        
        let time2 = dateString
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        let date1 = formatter.date(from: time1)!
        let date2 = formatter.date(from: time2)!
        
        let elapsedTime = date2.timeIntervalSince(date1)
        
        // convert from seconds to hours, rounding down to the nearest hour
        let hours = floor(elapsedTime / 60 / 60)
        
        // we have to subtract the number of seconds in hours from minutes to get
        // the remaining minutes, rounding down to the nearest minute (in case you
        // want to get seconds down the road)
        let minutes = floor((elapsedTime - (hours * 60 * 60)) / 60)
        
        print(minutes)
        print(elapsedTime)
        let  elapsedTimeInt = Int(elapsedTime)
        if elapsedTimeInt > seconds {
            seconds = 0
        }else{
            if UserDefaults.standard.value(forKey: "LastSecondBackground") != nil {
                let lastSecond = UserDefaults.standard.value(forKey: "LastSecondBackground") as? Int ?? 0
                let difference = lastSecond - elapsedTimeInt
                seconds = difference
                print(seconds)
                timer.invalidate()
                runTimer()
                
            }
            
        }
        
    }
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationBarSetup()
        productAndFitnessViewSetup()
        lblSetup()
        
        if UserDefaults.standard.value(forKey: K_TotalPoint) != nil {
            if let totalPoint = UserDefaults.standard.value(forKey: K_TotalPoint){
                
                let totalPointValueConvertInt = Int(totalPoint as? String ?? "0") ?? 0
                let increasePointValueConvertInt = Int(addPoint) ?? 0
                
                let additionPointAdd = totalPointValueConvertInt + increasePointValueConvertInt
                fitnessPointLbl.text = String(additionPointAdd)
            }
        }
        else{
            fitnessPointLbl.text = ""
        }

        //fitnessPointLbl.text = increasePoint
        totalPointLbl.text = "Total Point of the day : \(increasePoint) Points"

        //        bgTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
        //            UIApplication.shared.endBackgroundTask(self.bgTask)
        //        })
        //
        //        let timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(notificationReceived), userInfo: nil, repeats: true)
        //        RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
        
        //        backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: {
        //            UIApplication.shared.endBackgroundTask(self.backgroundTaskIdentifier!)
        //                })
        //var timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: "update", userInfo: nil, repeats: true)
        convertingRemaingTimeStringIntoInteger()
        
    }

    
    //MARK:- ConvertingStringValue to Time
    func convertingRemaingTimeStringIntoInteger(){
        let remaingTimeString = remaningtime
        let firstVal = remaingTimeString.firstIndex(of: ":")!
        let secondVal = remaingTimeString.prefix(upTo: firstVal)
        let componentVal = remaingTimeString.components(separatedBy: ":")[1]
        //print(componentVal)
        let convertingIntegerVal = Int(secondVal) ?? 0
        let newTime = convertingIntegerVal*60
        let secondIntTime = Int(componentVal) ?? 0
        let newTimeToDisplay = newTime + secondIntTime
        seconds = newTimeToDisplay
        print(newTimeToDisplay)
        print(newTime)
        runTimer()
    }
    
    
    //MARK:- ViewWillLayout
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
            if intruptionType == "No Intruption Task Complete" {
                self.navigationController?.backToViewController(vc: HomeMyTaskViewController.self)
            }
            else{
                self.navigationController?.backToViewController(vc: ThinkFitFocusTimeViewController.self)
            }
        }else{
            seconds -= 1
            restTimeLbl.text = "Rest Time : \(timeString(time: TimeInterval(seconds)))"
            
        }
    }
    
    //MARK:- set TimeInterVal String
    func timeString(time:TimeInterval) -> String {
        // let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    //MARK:- Function Working
    func productAndFitnessViewSetup(){
        fitnessPointView.layer.cornerRadius = 21
        fitnessPointView.layer.masksToBounds = true
        fitnessPointView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
        productivityView.layer.cornerRadius = 21
        productivityView.layer.masksToBounds = true
        productivityView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
    }
    
    //MARK:- HideUnhide or NavigationBar setup
    func navigationBarSetup(){
        navigationController?.navigationBar.isHidden = true
        
    }
    
    func lblSetup(){
//        let getvalue = GlobalVariabel.additional_Point
//        fitnessPointLbl.text = getvalue
        
        if let level = UserDefaults.standard.value(forKey: K_Productivity_Level) {
            productivityNameLbl.text = level as? String
        }
        
    }
    
    //MARK:- UIButton Actions
    @IBAction func customNavigationBarButtonAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "menuLeftNavigationController") as! SideMenuNavigationController
        nextViewController.leftSide = true
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func startNowButtonAction(_ sender: Any) {
        timer.invalidate()
        if intruptionType == "No Intruption Task Complete" {
            self.navigationController?.backToViewController(vc: HomeMyTaskViewController.self)
        }else{
        self.navigationController?.backToViewController(vc: ThinkFitFocusTimeViewController.self)
        }
        
    }
    
}
