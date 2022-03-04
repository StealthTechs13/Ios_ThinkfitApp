//
//  ThinkFitFocusTimeViewController.swift
//  ThinkFit
//
//  Created by apple on 21/09/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit
//import MMDrawerController
import SideMenu
import AVFoundation
import AudioToolbox
import CoreMotion
import CoreLocation

class ThinkFitFocusTimeViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var productivityNameView: UIView!
    @IBOutlet weak var fitnessPointView: UIView!
    @IBOutlet weak var pushToStartButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var BottomNoticeView: UIView!
    @IBOutlet weak var productivityNameLbl: UILabel!
    @IBOutlet weak var fitnessPointLbl: UILabel!
    @IBOutlet weak var timerCountingLbl: UILabel!
    @IBOutlet weak var pushToStartLbl: UILabel!
    @IBOutlet weak var taskNameLbl: UILabel!
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var navbarViewHeight: NSLayoutConstraint!
    @IBOutlet weak var focusTimeDefaultLbl: UILabel!
    @IBOutlet weak var notimetaskCompleteDefaultLbl: UILabel!
    
    
    //MARK:- Define Variables
    var seconds = Int()
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    var taskName = ""
    var intruptionTime = 0
    var renewalScreenVcTime = 0
    var congtatsTime = 0
    var recoveryScreenVcTime = 0
    var productivityLevel = ""
    var taskId = ""
    var updateTimeValue = Int()
    var saveTaskData = ""
    var isComingFormHome = false
    let motionManager = CMMotionManager()
    //var intruptionTime = 0
    var recoveryTime = 5
    var renewalTime = 15
    var renewalNotimeCount = 0
    //var renewalScreenVcTime = 0
    var ohIntruptionCount = 0
    var stopTimeToTired = 0
    var toDifficultTime = 0
    var noTime = 0
    var sevenTimeUpdateRecovery = 0
    
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        // Do any additional setup after loading the view.
    }
    
        
    //MARK:- Notification Observer Object Action
    @objc func myObserverMethod(notification : NSNotification) {
        timer.invalidate()
        BottomNoticeView.isHidden = false
        pushToStartButton.isUserInteractionEnabled = false
        //You may call your action method here, when the application did enter background.
        //ie., self.pauseTimer() in your case.
    }
    
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        taskName = GlobalVariabel.taskName
        taskId = GlobalVariabel.taskID
        pushToStartButton.isUserInteractionEnabled = true
        navigationBarSetup()
        productAndFitnessViewSetup()
        uiViewSetup()
        //checkDateandCallApi()
        isTimerRunning = false
        stopButton.isUserInteractionEnabled = false
        BottomNoticeView.isHidden = true
        NotificationCenter.default.removeObserver(self)
        saveTaskData = taskName
        notimetaskCompleteDefaultLbl.text = "No/ \n Task Completed"
        
        //        motionManager.startAccelerometerUpdates(to: OperationQueue.current!){
        //            (data , error) in
        //
        //            if let trueData = data {
        //                self.view.reloadInputViews()
        //                // self.statusAccel.text = "\(trueData)"
        //
        //                if trueData.acceleration.z == 2 {
        //                    AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
        //                }
        //            }
        //        }
        
    }
    
    //MARK:- ViewWillLayoutSubview
    override func viewWillLayoutSubviews() {
        if UIScreen.main.bounds.size.height <= 736{
            navbarViewHeight?.constant = 64
            self.view.layoutIfNeeded()
        }
        else{
            navbarViewHeight?.constant = 90
            self.view.layoutIfNeeded()
        }
    }
    
    
    //MARK:- View Setup
    func uiViewSetup(){
        pushToStartLbl.isHidden = false
        pushToStartButton.isUserInteractionEnabled = true
        taskNameLbl.text = taskName
        
        if UserDefaults.standard.value(forKey: K_TotalPoint) != nil {
            if let totalPoint = UserDefaults.standard.value(forKey: K_TotalPoint){
                fitnessPointLbl.text = totalPoint as? String ?? ""
            }
        }
        else{
            fitnessPointLbl.text = ""
        }

//
//        //**** Point SetUp ****//
//        let getvalue = GlobalVariabel.additional_Point
//        fitnessPointLbl.text = getvalue
        
        //        if UserDefaults.standard.value(forKey: K_additional_Point) != nil {
        //            let pointValue = UserDefaults.standard.value(forKey: K_additional_Point) as? Int
        //
        //            fitnessPointLbl.text = String(pointValue!)
        //        }
        //        else{
        //            fitnessPointLbl.text = "0"
        //        }
        
        
        // **** TimeSetUp ****//
        if UserDefaults.standard.value(forKey: K_defaultTime) != nil {
            if let defaultTime = UserDefaults.standard.value(forKey: K_defaultTime){
                seconds = defaultTime as! Int*60
                updateTimeValue = (defaultTime as? NSString)?.integerValue ?? 25*60
                timerCountingLbl.text = timeString(time: TimeInterval(defaultTime as! Int*60))

               
               // focusTimeDefaultLbl.text = "Focus Time \(timeString(time: TimeInterval(defaultTime as! Int*60)))"
               
                let time = defaultTime as! Int
                if time == 5 {
                    productivityNameLbl.text = "Wonderer"
                    productivityLevel = "Wonderer"
                }
                else if time == 10 {
                    productivityNameLbl.text = "Cloudy"
                    productivityLevel = "Cloudy"
                }
                else if time == 15 {
                    productivityNameLbl.text = "Dreamer"
                    productivityLevel = "Dreamer"
                }
                else if time  == 20 {
                    productivityNameLbl.text = "Sub"
                    productivityLevel = "Sub"
                }
                else if time == 25 {
                    productivityNameLbl.text = "Normal"
                    productivityLevel = "Normal"
                }
                else if time == 30 {
                    productivityNameLbl.text = "Above"
                    productivityLevel = "Above"
                }
                else if time == 35 {
                    productivityNameLbl.text = "Laser"
                    productivityLevel = "Laser"
                }
                else if time == 40 {
                    productivityNameLbl.text = "Expert"
                    productivityLevel = "Expert"
                }
                else if time == 45 {
                    productivityNameLbl.text = "Hero"
                    productivityLevel = "Hero"
                }
                else if time == 50 {
                    productivityNameLbl.text = "Guru"
                    productivityLevel = "Guru"
                }
                
                UserDefaults.standard.set(productivityLevel, forKey: K_Productivity_Level)
                UserDefaults.standard.synchronize()
                
            }
        }
        
//        seconds = 10//defaultTime as! Int*60 //(defaultTime as! NSString).integerValue
//        timerCountingLbl.text = timeString(time: TimeInterval(seconds))
    }
    
    
    //MARK:- Function Working
    func productAndFitnessViewSetup(){
        
        fitnessPointView.layer.cornerRadius = 21
        fitnessPointView.layer.masksToBounds = true
        fitnessPointView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
        productivityNameView.layer.cornerRadius = 21
        productivityNameView.layer.masksToBounds = true
        productivityNameView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
        stopButton.backgroundColor = #colorLiteral(red: 0.2745098039, green: 0.1803921569, blue: 0.1176470588, alpha: 1)
        stopButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5), for: .normal)
        
    }
    
    //MARK:- HideUnhide or NavigationBar setup
    func navigationBarSetup(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "ThinkFit"
        
        //MARK:- Navigation LeftBar Button
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "icMenu"), style: .done, target: self, action: #selector(self.icMenuButtonAction))
        self.navigationItem.leftBarButtonItem  = leftBarButton
        
    }
    
    //MARK:- Object Function Button Action
    @objc func icMenuButtonAction(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "menuLeftNavigationController") as! SideMenuNavigationController
        nextViewController.leftSide = true
        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    //MARK:- UIButton Actions
    @IBAction func icMenuLeftButtonAction(_ sender: Any) {
        if isTimerRunning == true {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "menuLeftNavigationController") as! SideMenuNavigationController
            nextViewController.leftSide = true
            timer.invalidate()
            BottomNoticeView.isHidden = false
            self.present(nextViewController, animated:true, completion:nil)
        }
        else{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "menuLeftNavigationController") as! SideMenuNavigationController
            nextViewController.leftSide = true
            timer.invalidate()
           // BottomNoticeView.isHidden = false
            self.present(nextViewController, animated:true, completion:nil)
        }
        
    }
    
    /*** Push to Start Button Action ***/
    @IBAction func pushToStartButtonAction(_ sender: Any) {
        stopButton.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.4941176471, blue: 0.1294117647, alpha: 1)
        stopButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        pushToStartLbl.isHidden = true
        pushToStartButton.isUserInteractionEnabled = false
        stopButton.isUserInteractionEnabled = true
        //checkDateandCallApi()
        if isTimerRunning == false {
            runTimer()
            // self.startButton.isEnabled = false
        }
    }
    
    
    //MARK:- Start Timer function
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
        
        // pauseButton.isEnabled = true
    }
    
    
    //MARK:- Update Timer function
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            
            NotificationCenter.default.removeObserver(self)
            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
            
           // print("time is over")
            focusDaysIntruptionAPI(intruptionttype: "1")
            //Send alert to indicate time's up.
            
//            if UserDefaults.standard.value(forKey: K_renewal_Count) != nil{
//                let renewalCount = UserDefaults.standard.value(forKey: K_renewal_Count)
//                self.renewalScreenVcTime = renewalCount as! Int+1
//                UserDefaults.standard.set(self.renewalScreenVcTime, forKey: K_renewal_Count)
//                UserDefaults.standard.synchronize()
//                if UserDefaults.standard.value(forKey: K_renewal_Count) as! Int == 4 {
//                    self.renewalScreenVcTime = 0
//                    UserDefaults.standard.set(self.renewalScreenVcTime, forKey: K_renewal_Count)
//                    UserDefaults.standard.synchronize()
//                    //              UserDefaults.standard.removeObject(forKey: K_renewal_Count)
//                    //              UserDefaults.standard.synchronize()
//
//
//                    GlobalVariabel.taskName = taskName
//                    GlobalVariabel.taskID = taskId
//
//                    NotificationCenter.default.removeObserver(self)
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RenewalPeriodTimeBreakViewController") as! RenewalPeriodTimeBreakViewController
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
//                else{
//
//                }
//            }
//            else{
//                self.renewalScreenVcTime = self.renewalScreenVcTime+1
//                UserDefaults.standard.set(self.renewalScreenVcTime, forKey: K_renewal_Count)
//                UserDefaults.standard.synchronize()
//                focusDaysIntruptionAPI(intruptionttype: "1")
//                //focusDaysIntruptionAPI(intruptionttype: "1")
//            }
        } else {
            
            seconds -= 1
            timerCountingLbl.text = timeString(time: TimeInterval(seconds))
            
            NotificationCenter.default.addObserver(self, selector: #selector(myObserverMethod(notification:)), name:UIApplication.didEnterBackgroundNotification, object: nil)
            
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler:{
                deviceManager, error in
                if(error == nil){
                    if let mgr = deviceManager{
                        self.handleMotion(rate: mgr.rotationRate)
                    }
                }
            })
        }
    }
    
    //MARK:- this functio to handle Motion to rotation phone
    func handleMotion(rate: CMRotationRate){
        let totalRotation = abs(rate.x) + abs(rate.y) + abs(rate.z)
        
        if(totalRotation > 10) {//Play around with the number 20 to find the optimal level for your case
            start()
        }else{
            //print(totalRotation)
        }
    }
    
    //MARK:- Start Motion Function
    func start(){
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
        BottomNoticeView.isHidden = false
        timer.invalidate()
        isTimerRunning = false
        self.resumeTapped = true
        motionManager.stopDeviceMotionUpdates()
        // The function you want to trigger when the device is rotated
        
    }
    
    //MARK:- Set TimeInterval String
    func timeString(time:TimeInterval) -> String {
        // let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    /*** stop Button ***/
    @IBAction func stopButtonAction(_ sender: Any) {
        timer.invalidate()
        BottomNoticeView.isHidden = false
        isTimerRunning = false
        self.resumeTapped = true
    }
    
    
    /*** stop Button ***/
    @IBAction func stopButton(_ sender: Any) {
        timer.invalidate()
        seconds = seconds*60
        timerCountingLbl.text = timeString(time: TimeInterval(seconds))
        NotificationCenter.default.removeObserver(self)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FocusTimeOopsViewController") as! FocusTimeOopsViewController
        BottomNoticeView.isHidden = true
        vc.intruptionType =  "0"
        vc.selectTaskId = taskId
        
        motionManager.stopDeviceMotionUpdates()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    /*** Continue Button ***/
    @IBAction func continueButton(_ sender: Any) {
        BottomNoticeView.isHidden = true
        runTimer()
        self.resumeTapped = false
        isTimerRunning = true
        NotificationCenter.default.removeObserver(self)
        
    }
    
}


//MARK:- Calling API's 
extension ThinkFitFocusTimeViewController {
    
    func focusDaysIntruptionAPI(intruptionttype: String){
        
        DataService.sharedInstance.focusDays(userId: GlobalVariabel.userId, description: "", type: intruptionttype) { (resultDict, errorMsg) in
            
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool{
                    if status == true {
                        
                        GlobalVariabel.taskName = self.taskName
                        GlobalVariabel.taskID = self.taskId
                        
                        var saveIntTime = Int()
                        
                        //                        /* Renewal Adding Count */
                        //                        if UserDefaults.standard.value(forKey: K_renewal_Count) != nil{
                        //                            let renewalCount = UserDefaults.standard.value(forKey: K_renewal_Count)
                        //                            self.renewalScreenVcTime = renewalCount as! Int+1
                        //                            //self.renewalScreenVcTime = self.renewalScreenVcTime+1
                        //                            UserDefaults.standard.set(self.renewalScreenVcTime, forKey: K_renewal_Count)
                        //                            UserDefaults.standard.synchronize()
                        //                        }
                        
                        //                        /* Get Time from Backend and Save Time */
                        //                        if let timer_count = resultDict?["timer_count"] as? String {
                        //                            let IntTime = (timer_count as NSString).integerValue //Int(timer_count as? String ?? "")//(timer_count as NSString).integerValue
                        //                            saveIntTime = IntTime
                        //                            UserDefaults.standard.set(IntTime, forKey: K_defaultTime)
                        //                            UserDefaults.standard.synchronize()
                        //                        }
                        
                        /* get result and Going To Next Screen according to count */
                        if let result = resultDict?["result"] as? NSDictionary {
                            // print(result)
                            if let count = result["count"] as? Int {
                                // print(count)
                                if count == 2 {
                                    
                                    if UserDefaults.standard.value(forKey: K_defaultTime) != nil {
                                        if let defaultTime = UserDefaults.standard.value(forKey: K_defaultTime){
                                            /* Get Time from Backend and Save Time */
                                            if let timer_count = resultDict?["timer_count"] as? String {
                                                let IntTime = (timer_count as NSString).integerValue //Int(timer_count as? String ?? "")//(timer_count as NSString).integerValue
                                                saveIntTime = IntTime
                                                UserDefaults.standard.set(IntTime, forKey: K_defaultTime)
                                                UserDefaults.standard.synchronize()
                                            }
                                            
                                            if defaultTime as! Int == saveIntTime {
                                                if UserDefaults.standard.value(forKey: K_Recovery_Count) != nil {
                                                    let recoveryCount = UserDefaults.standard.value(forKey: K_Recovery_Count) as? Int
                                                    if recoveryCount == 3 {
                                                        self.recoveryScreenVcTime = 0
                                                        UserDefaults.standard.set(self.recoveryScreenVcTime, forKey: K_Recovery_Count)
                                                        UserDefaults.standard.synchronize()

                                                        GlobalVariabel.taskName = self.taskName
                                                        GlobalVariabel.taskID = self.taskId
                                                        
                                                        NotificationCenter.default.removeObserver(self)
                                                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RenewalPeriodTimeBreakViewController") as! RenewalPeriodTimeBreakViewController
                                                        self.navigationController?.pushViewController(vc, animated: true)
                                                    }
                                                    else{
                                                        NotificationCenter.default.removeObserver(self)
                                                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecoveryRollingViewController") as! RecoveryRollingViewController
                                                        self.navigationController?.pushViewController(vc, animated: true)
                                                    }
                                                }
                                                else{
                                                    NotificationCenter.default.removeObserver(self)
                                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecoveryRollingViewController") as! RecoveryRollingViewController
                                                    self.navigationController?.pushViewController(vc, animated: true)
                                                }
                                                
                                                
//                                                if UserDefaults.standard.value(forKey: K_renewal_Count) as! Int == 4 {
//                                                    self.renewalScreenVcTime = 0
//                                                    UserDefaults.standard.set(self.renewalScreenVcTime, forKey: K_renewal_Count)
//                                                    UserDefaults.standard.synchronize()
//                                                    // UserDefaults.standard.removeObject(forKey: K_renewal_Count)
//                                                    // UserDefaults.standard.synchronize()
//
//                                                    GlobalVariabel.taskName = self.taskName
//                                                    GlobalVariabel.taskID = self.taskId
//
//                                                    NotificationCenter.default.removeObserver(self)
//                                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RenewalPeriodTimeBreakViewController") as! RenewalPeriodTimeBreakViewController
//                                                    self.navigationController?.pushViewController(vc, animated: true)
//                                                }else{
//
//                                                    //                                                    /* Renewal Adding Count */
//                                                    //                                                    if UserDefaults.standard.value(forKey: K_renewal_Count) != nil{
//                                                    //                                                        let renewalCount = UserDefaults.standard.value(forKey: K_renewal_Count)
//                                                    //                                                        self.renewalScreenVcTime = renewalCount as! Int+1
//                                                    //                                                        //self.renewalScreenVcTime = self.renewalScreenVcTime+1
//                                                    //                                                        UserDefaults.standard.set(self.renewalScreenVcTime, forKey: K_renewal_Count)
//                                                    //                                                        UserDefaults.standard.synchronize()
//                                                    //                                                    }
//
//                                                    NotificationCenter.default.removeObserver(self)
//                                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecoveryRollingViewController") as! RecoveryRollingViewController
//                                                    self.navigationController?.pushViewController(vc, animated: true)
//                                                }
                                            }
                                            else{
                                                /* Get Time from Backend and Save Time */
                                                if let timer_count = resultDict?["timer_count"] as? String {
                                                    let IntTime = (timer_count as NSString).integerValue //Int(timer_count as? String ?? "")//(timer_count as NSString).integerValue
                                                    saveIntTime = IntTime
                                                    UserDefaults.standard.set(IntTime, forKey: K_defaultTime)
                                                    UserDefaults.standard.synchronize()
                                                }
                                                
                                                NotificationCenter.default.removeObserver(self)
                                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "WellDoneViewController") as! WellDoneViewController
                                                vc.checkTimeCount = saveIntTime
                                                self.navigationController?.pushViewController(vc, animated: true)
                                            }
                                        }
                                        
                                    }
                                    
                                    //                                    NotificationCenter.default.removeObserver(self)
                                    //                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "WellDoneViewController") as! WellDoneViewController
                                    //                                    vc.checkTimeCount = saveIntTime
                                    //                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                else{
                                    if UserDefaults.standard.value(forKey: K_Recovery_Count) != nil {
                                        let recoveryCount = UserDefaults.standard.value(forKey: K_Recovery_Count) as? Int
                                        if recoveryCount == 3 {
                                            self.recoveryScreenVcTime = 0
                                            UserDefaults.standard.set(self.recoveryScreenVcTime, forKey: K_Recovery_Count)
                                            UserDefaults.standard.synchronize()

                                            GlobalVariabel.taskName = self.taskName
                                            GlobalVariabel.taskID = self.taskId
                                            
                                            
                                            NotificationCenter.default.removeObserver(self)
                                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RenewalPeriodTimeBreakViewController") as! RenewalPeriodTimeBreakViewController
                                            self.navigationController?.pushViewController(vc, animated: true)
                                        }
                                        else{
                                            NotificationCenter.default.removeObserver(self)
                                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecoveryRollingViewController") as! RecoveryRollingViewController
                                            self.navigationController?.pushViewController(vc, animated: true)
                                        }
                                    }
                                    else{
                                        NotificationCenter.default.removeObserver(self)
                                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecoveryRollingViewController") as! RecoveryRollingViewController
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }
                                    
//                                    NotificationCenter.default.removeObserver(self)
//                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecoveryRollingViewController") as! RecoveryRollingViewController
//                                    self.navigationController?.pushViewController(vc, animated: true)

                                    
//                                    if UserDefaults.standard.value(forKey: K_renewal_Count) as! Int == 4 {
//                                        self.renewalScreenVcTime = 0
//                                        UserDefaults.standard.set(self.renewalScreenVcTime, forKey: K_renewal_Count)
//                                        UserDefaults.standard.synchronize()
//                                        // UserDefaults.standard.removeObject(forKey: K_renewal_Count)
//                                        // UserDefaults.standard.synchronize()
//
//                                        GlobalVariabel.taskName = self.taskName
//                                        GlobalVariabel.taskID = self.taskId
//
//                                        NotificationCenter.default.removeObserver(self)
//                                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RenewalPeriodTimeBreakViewController") as! RenewalPeriodTimeBreakViewController
//                                        self.navigationController?.pushViewController(vc, animated: true)
//                                    }
//                                    else{
//
//                                        NotificationCenter.default.removeObserver(self)
//                                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecoveryRollingViewController") as! RecoveryRollingViewController
//                                        self.navigationController?.pushViewController(vc, animated: true)
//                                    }
                                    
                                }
                            }
                            
                        }
                    }
                    else{
                        if let message = resultDict?["message"] as? String{
                            Toast.show(message: message, controller: self)
                        }
                    }
                }
            }
            else{
                if let message = resultDict?["message"] as? String{
                    Toast.show(message: message, controller: self)
                }
            }
        }
        
    }
    
}


//MARK:- This function check api to call one time at a day.
extension ThinkFitFocusTimeViewController {
    
    func checkDateandCallApi(){
        
        if UserDefaults.standard.value(forKey: K_todayTomorrowDate) != nil {
            let today = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            let todayStr = dateFormatter.string(from: today)
            let oldDatestr = UserDefaults.standard.value(forKey: K_todayTomorrowDate) as? String ?? ""
            
            if oldDatestr == todayStr{
                //Do something here...
            }else{
                UserDefaults.standard.setValue(todayStr, forKey: K_todayTomorrowDate)
                UserDefaults.standard.removeObject(forKey: K_additional_Point)
                UserDefaults.standard.set(self.intruptionTime, forKey: K_IntruptionCount)
                UserDefaults.standard.setValue(renewalTime, forKey: K_Renewal_UpdateTime)
                UserDefaults.standard.set(recoveryTime, forKey: K_recoveryTimeUpdate)
                UserDefaults.standard.set(renewalNotimeCount, forKey: k_renewalNoTimeCount)
                UserDefaults.standard.set(self.renewalScreenVcTime, forKey: K_renewal_Count)
                UserDefaults.standard.set(self.recoveryScreenVcTime, forKey: K_Recovery_Count)
                UserDefaults.standard.set(self.ohIntruptionCount, forKey: K_ohohIntruption)
                UserDefaults.standard.set(0, forKey: k_Update_Intruption_Status_count)
                UserDefaults.standard.removeObject(forKey: k_Update_Intruption_Status_Name)
                UserDefaults.standard.set(stopTimeToTired, forKey: "stopTimeToTired")
                UserDefaults.standard.set(noTime, forKey: "noTime")
                UserDefaults.standard.set(toDifficultTime, forKey: "toDifficult")
                UserDefaults.standard.set(sevenTimeUpdateRecovery, forKey: k_sevenTime_Update_Recovery)
                UserDefaults.standard.synchronize()
            }
        }else{
            let today = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            let todayStr = dateFormatter.string(from: today)
            // let dateToday = dateFormatter.date(from: todayStr)
            UserDefaults.standard.setValue(todayStr, forKey: K_todayTomorrowDate)
            UserDefaults.standard.removeObject(forKey: K_additional_Point)
            UserDefaults.standard.set(self.intruptionTime, forKey: K_IntruptionCount)
            UserDefaults.standard.setValue(renewalTime, forKey: K_Renewal_UpdateTime)
            UserDefaults.standard.set(recoveryTime, forKey: K_recoveryTimeUpdate)
            UserDefaults.standard.set(renewalNotimeCount, forKey: k_renewalNoTimeCount)
            UserDefaults.standard.set(self.renewalScreenVcTime, forKey: K_renewal_Count)
            UserDefaults.standard.set(self.recoveryScreenVcTime, forKey: K_Recovery_Count)
            UserDefaults.standard.set(self.ohIntruptionCount, forKey: K_ohohIntruption)
            UserDefaults.standard.set(0, forKey: k_Update_Intruption_Status_count)
            UserDefaults.standard.removeObject(forKey: k_Update_Intruption_Status_Name)
            UserDefaults.standard.set(stopTimeToTired, forKey: "stopTimeToTired")
            UserDefaults.standard.set(noTime, forKey: "noTime")
            UserDefaults.standard.set(toDifficultTime, forKey: "toDifficult")
            UserDefaults.standard.set(sevenTimeUpdateRecovery, forKey: k_sevenTime_Update_Recovery)
            UserDefaults.standard.synchronize()
        }
    }
    
}
