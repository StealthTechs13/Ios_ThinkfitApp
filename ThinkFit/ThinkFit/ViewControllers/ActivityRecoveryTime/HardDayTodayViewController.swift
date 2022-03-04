//
//  HardDayTodayViewController.swift
//  ThinkFit
//
//  Created by apple on 22/09/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class HardDayTodayViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var timeRemaningLbl: UILabel!
    
    
    //MARK:- Define variables
    var remainTime = Int()
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isIdleTimerDisabled = true
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    //MARK:- This Function to Check background time for application
    @objc func appMovedToBackground() {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "HH:mm:ss"
        let dateString = df.string(from: date)
        print(dateString)
        UserDefaults.standard.set(dateString, forKey: "LastTimeBackground")
        UserDefaults.standard.synchronize()
        if timeRemaningLbl.text?.count ?? 0 > 0 {
            UserDefaults.standard.set(remainTime, forKey: "LastSecondBackground")
            UserDefaults.standard.synchronize()
        }
        print(remainTime)
        print("App moved to background!")
    }
    
    
    //MARK:- This Function to check time after background application to back in front
    @objc func appMovedToForground() {
        timedifference()
        print(remainTime)
        print("App moved to forground!")
    }
    
    
    //MARK:- This function to Ceck TimeDifference
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
        if elapsedTimeInt > remainTime {
            remainTime = 0
        }else{
            if UserDefaults.standard.value(forKey: "LastSecondBackground") != nil {
                let lastSecond = UserDefaults.standard.value(forKey: "LastSecondBackground") as? Int ?? 0
                let difference = lastSecond - elapsedTimeInt
                remainTime = difference
                print(remainTime)
                timer.invalidate()
                runTimer()
                
            }
            
        }
        
    }
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationbarSetup()
        runTimer()
    }
    
    
    //MARK:- Navigation_Setup
    func navigationbarSetup(){
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
        title = "Active Recovery Time"
        navigationItem.hidesBackButton = true
    }
    
    
    //MARK:- UIButton Actions
    @IBAction func doneButtonAction(_ sender: Any) {
        timer.invalidate()
        self.navigationController?.backToViewController(vc: ThinkFitFocusTimeViewController.self)
        
    }
    
    //MARK:- Start Timer
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
        // pauseButton.isEnabled = true
    }
    
    
    //MARK:- Update Timer
    @objc func updateTimer() {
        if remainTime < 1 {
            timer.invalidate()
            self.navigationController?.backToViewController(vc: ThinkFitFocusTimeViewController.self)
            //  print("time is over")
            
            
        } else {
            remainTime -= 1
            timeRemaningLbl.text = "\("Time Remaning : \(timeString(time: TimeInterval(remainTime)))")"
        }
    }
    
    //MARK:- Set TimeInterVal String
    func timeString(time:TimeInterval) -> String {
        // let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
}
