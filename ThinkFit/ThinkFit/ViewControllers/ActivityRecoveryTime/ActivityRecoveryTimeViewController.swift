//
//  ActivityRecoveryTimeViewController.swift
//  ThinkFit
//
//  Created by apple on 21/09/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit
//import MMDrawerController
import SideMenu
import AudioToolbox
import AVFoundation
import AVKit


class ActivityRecoveryTimeViewController: UIViewController,customDelegate {
    
    
    //MARK:- Outlets
    @IBOutlet weak var navigationBarView: UIView!
    @IBOutlet weak var navigationBarViewHeight: NSLayoutConstraint!
    @IBOutlet weak var fitnessPointLbl: UILabel!
    @IBOutlet weak var productivityNameLbl: UILabel!
    @IBOutlet weak var productivityView: UIView!
    @IBOutlet weak var fitnessPointView: UIView!
    @IBOutlet weak var timerCountLbl: UILabel!
    @IBOutlet weak var excersiceNameLbl: UILabel!
    @IBOutlet weak var givePointNameLbl: UILabel!
    @IBOutlet weak var excersiceLinkLbl: UILabel!
    
    
    //MARK:- Define Variables
    var seconds = Int()
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    var addPoint = ""
    var excersiceList = [recoveryExcersiceListModel]()
    var fitnesLevel = [fitnessLevelModel]()
    var excersiceCounting = 0
    var exerciseNameCount = 0
    var recoverySevenTimeUpdate = 0
    var selectTime = Int()
    var selectedIndex = 0
    var fitnessLevelIndex = 0
    var videoLink = ""
    var player1: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var isVideoPlaying = false
    var checkFitnessLevel = ""
    var intruptionType = ""
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        seconds = selectTime //(defaultTime as! NSString).integerValue
        timerCountLbl.text = timeString(time: TimeInterval(seconds))
        productivityNameLbl.text = ""
        excersiceNameLbl.text = ""
        givePointNameLbl.text = ""
        excersiceLinkLbl.text = "How to work out?"
        UIApplication.shared.isIdleTimerDisabled = true
        recoveryExcerciseUserBased()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationBarSetup()
        uiLabelSetup()
        productAndFitnessViewSetup()
        
        if excersiceList.count > 0 {
            self.runTimer()
        }
    }
    
    //MARK:- Excersice Setup
    func setupExcersices(){
        
        if selectedIndex > excersiceList.count-1{
            self.selectedIndex = 0
            UserDefaults.standard.set(selectedIndex, forKey: K_recoveryExcersice_Update)
            // UserDefaults.standard.removeObject(forKey: K_recoveryExcersice_Update)
            UserDefaults.standard.synchronize()
            setupExcersices()
        }else{
            if excersiceList.count > 0 {
                let data = excersiceList.choose(excersiceList.count)
                if UserDefaults.standard.value(forKey: K_Fitness_Level) != nil {
                    let fitnessLevel = UserDefaults.standard.value(forKey: K_Fitness_Level) as? String
                    for item in fitnesLevel{
                        if data[selectedIndex].id == item.exercise_id{
                            if fitnessLevel?.uppercased() == item.fit_level.uppercased(){
                                excersiceNameLbl.text = "You got \(item.reps) \(data[selectedIndex].exercise)"
                                givePointNameLbl.text = "Gives you [\(item.points)] Fit Points"
                                addPoint = item.points
                                videoLink = data[selectedIndex].video_link
                            }
                        }
                    }
                }
                
                
                //     print(data[selectedIndex].exercise)
                
                //                print(data[selectedIndex].exercise)
                //                print(data[selectedIndex].exercise)
                //                print(data[selectedIndex].exercise)
            }
            
            
            //            for i in 0..<excersiceList.count{
            //
            //                // print(excersiceList[i])
            //                if i == selectedIndex {
            //
            //                    //display data here
            //                    if UserDefaults.standard.value(forKey: K_Fitness_Level) != nil {
            //
            //                        let fitnessLevel = UserDefaults.standard.value(forKey: K_Fitness_Level) as? String
            //
            //
            //                        for item in fitnesLevel{
            //                            if excersiceList[i].id == item.exercise_id{
            //                                if fitnessLevel?.uppercased() == item.fit_level.uppercased(){
            //                                    excersiceNameLbl.text = "You got \(item.reps) \(excersiceList[selectedIndex].exercise)"
            //                                    // excersiceLinkLbl.text = "\(excersiceList[selectedIndex].video_link)"
            //                                    givePointNameLbl.text = "Gives you [\(item.points)] Fit Points"
            //                                    addPoint = item.points
            //                                    videoLink = excersiceList[selectedIndex].video_link
            //                                }
            //                            }
            //                        }
            //                    }
            //
            //                }
            //
            //            }
        }
        
    }
    
    
    //MARK:- Cehck Remaning time and Value.
    func didSelectData(_ remainingTime: String, _ selectedIndex: Int) {
        
        if remainingTime == "True"{
            if UserDefaults.standard.value(forKey: "ReamingTime") != nil{
                let strSeconds = UserDefaults.standard.value(forKey: "ReamingTime")
                seconds = (strSeconds as! NSString).integerValue
                seconds -= 1
                timerCountLbl.text = timeString(time: TimeInterval(seconds))
                
                timer.invalidate()
                runTimer()
                
            }else{
                seconds =  5 //(defaultTime as! NSString).integerValue
                timerCountLbl.text = timeString(time: TimeInterval(seconds*60))
                runTimer()
            }
        }else{
            seconds =  5 //(defaultTime as! NSString).integerValue
            timerCountLbl.text = timeString(time: TimeInterval(seconds*60))
            runTimer()
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
            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
            print("time is over")
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ActivityRecoveryOopsTimeOverViewController") as! ActivityRecoveryOopsTimeOverViewController
            vc.intruptionType = intruptionType
            self.navigationController?.pushViewController(vc, animated: true)
            
            
            //            for vc in (self.navigationController?.viewControllers)! {
            //                if vc is ThinkFitFocusTimeViewController {
            //                    self.navigationController?.popToViewController(vc, animated: true)
            //                }
            //            }
            //            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ActivityTimeOverViewController") as! ActivityTimeOverViewController
            //            self.navigationController?.pushViewController(vc, animated: true)
            //Send alert to indicate time's up.
            
            
        }else {
            seconds -= 1
            timerCountLbl.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    //MARK:- Set TimeInterVal in String
    func timeString(time:TimeInterval) -> String {
        // let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    
    //MARK:- UILaelSetup
    func uiLabelSetup() {
        
        //MARK:- Point Value
        if UserDefaults.standard.value(forKey: K_TotalPoint) != nil {
            if let totalPoint = UserDefaults.standard.value(forKey: K_TotalPoint){
                fitnessPointLbl.text = totalPoint as? String ?? ""
            }
        }
        else{
            fitnessPointLbl.text = ""
        }

//        let getvalue = GlobalVariabel.additional_Point
//        fitnessPointLbl.text = getvalue
//
        //        if UserDefaults.standard.value(forKey: K_additional_Point) != nil {
        //            let pointValue = UserDefaults.standard.value(forKey: K_additional_Point) as? Int
        //
        //            fitnessPointLbl.text = String(pointValue!)
        //        }
        //        else{
        //            fitnessPointLbl.text = "0"
        //        }
        
        
        if let level = UserDefaults.standard.value(forKey: K_Productivity_Level) {
            productivityNameLbl.text = level as? String
            
        }
        
        if UserDefaults.standard.value(forKey: K_Fitness_Level) != nil {
            let fitnesLevel = UserDefaults.standard.value(forKey: K_Fitness_Level)
            checkFitnessLevel = fitnesLevel as? String ?? ""
        }
        
    }
    
    //MAR:- viewWillLayout
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
    
    
    //MARK:- Function Working
    func productAndFitnessViewSetup(){
        fitnessPointView.layer.cornerRadius = 21
        fitnessPointView.layer.masksToBounds = true
        fitnessPointView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
        productivityView.layer.cornerRadius = 21
        productivityView.layer.masksToBounds = true
        productivityView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
    }
    
    //MARK:- Hide_Unhide or NavigationBar setup
    func navigationBarSetup(){
        navigationController?.navigationBar.isHidden = true
        navigationItem.title = "Active Recovery Time"
        
        //MARK:- Navigation LeftBar Button
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "icMenu"), style: .done, target: self, action: #selector(self.icMenuButtonAction))
        self.navigationItem.leftBarButtonItem  = leftBarButton
        
    }
    
    
    //MARK:- Object Function Button Action
    @objc func icMenuButtonAction(){
        
    }
    
    
    //MARK:- UIButton Actions
    @IBAction func navigationLeftBarButtonAction(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "menuLeftNavigationController") as! SideMenuNavigationController
        nextViewController.leftSide = true
        timer.invalidate()
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func completeButtonAction(_ sender: Any) {
        
        
        if UserDefaults.standard.value(forKey: k_sevenTime_Update_Recovery) != nil {
            let sevenTimeValue = UserDefaults.standard.value(forKey: k_sevenTime_Update_Recovery) as! Int
            recoverySevenTimeUpdate = sevenTimeValue + 1
            UserDefaults.standard.set(recoverySevenTimeUpdate, forKey: k_sevenTime_Update_Recovery)
            UserDefaults.standard.synchronize()
            
            if UserDefaults.standard.value(forKey: k_sevenTime_Update_Recovery) as! Int == 7 {
                
                self.recoverySevenTimeUpdate = 0
                UserDefaults.standard.set(recoverySevenTimeUpdate, forKey: k_sevenTime_Update_Recovery)
                UserDefaults.standard.synchronize()
                
                if checkFitnessLevel == "Superfit" || checkFitnessLevel == "SUPERFIT" || checkFitnessLevel == "SuperFit"{
                    //                    self.recoverySevenTimeUpdate = 0
                    //                    UserDefaults.standard.set(recoverySevenTimeUpdate, forKey: k_sevenTime_Update_Recovery)
                    //                    UserDefaults.standard.synchronize()
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecoveryWellDoneViewController") as! RecoveryWellDoneViewController
                    vc.delegate = self
                    vc.intruptionType = intruptionType
                    // vc.selectedPreviousIndex = self.selectedIndex+1
                    vc.remaningtime = self.timeString(time: TimeInterval(self.seconds))
                    //vc.addPoint = self.addPoint
                    //vc.increasePoint = String(featchLocalPoint + getPoint!)
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
                else{
                    self.recoverySevenTimeUpdate = 0
                    UserDefaults.standard.set(recoverySevenTimeUpdate, forKey: k_sevenTime_Update_Recovery)
                    UserDefaults.standard.synchronize()
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "CongratsViewController") as! CongratsViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }
            else{
                let valueSecondsStr = String(seconds)
                UserDefaults.standard.set(valueSecondsStr, forKey: "ReamingTime")
                UserDefaults.standard.synchronize()
                addadditionalPoint()
            }
        }
        else{
            let valueSecondsStr = String(seconds)
            recoverySevenTimeUpdate = recoverySevenTimeUpdate + 1
            UserDefaults.standard.set(recoverySevenTimeUpdate, forKey: k_sevenTime_Update_Recovery)
            UserDefaults.standard.set(valueSecondsStr, forKey: "ReamingTime")
            UserDefaults.standard.synchronize()
            addadditionalPoint()
        }
        
        timer.invalidate()
    }
    
    
    @IBAction func skipButtonAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ActivityRecoveryTiredTimeDifficultViewController") as! ActivityRecoveryTiredTimeDifficultViewController
        vc.remainTime = Int(TimeInterval(seconds))//timeString(time: TimeInterval(seconds))
        vc.time = seconds
        vc.intruptionType = intruptionType
        self.navigationController?.pushViewController(vc, animated: true)
        timer.invalidate()
    }
    
    @IBAction func howToWorkOutButtonAction(_ sender: Any) {
        
        timer.invalidate()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "YouTubeViewController") as! YouTubeViewController
        vc.youtubeId = videoLink
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        //        guard let myVC = self.storyboard?.instantiateViewController(withIdentifier: "YouTubeViewController") as? YouTubeViewController else { return }
        //        let navController = UINavigationController(rootViewController: myVC)
        //        myVC.modalPresentationStyle = .fullScreen
        //        self.navigationController?.present(navController, animated: true, completion: nil)
        
        
    }
    
}


//MARK:- Calling API'S
extension ActivityRecoveryTimeViewController {
    
    //*** recovery exercise ***//
    func recoveryExercise(){
        
        self.showIndicator()
        
        DataService.sharedInstance.sitPushUp(userid: GlobalVariabel.userId) { (resultDict, errorMsg) in
            
            self.hideIndicator()
            
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool {
                    if status == true {
                        
                        if let result = resultDict?["result"] as? [NSDictionary]{
                            print(result)
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
    
    //*** Add Aditional Point ***//
    func addadditionalPoint(){
        
        self.showIndicator()
        
        DataService.sharedInstance.additionalPoint(userId: GlobalVariabel.userId, exercise: "sitUp", point: addPoint) { (resultDict, errorMsg) in
            
            self.hideIndicator()
            
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool {
                    if status == true {
                        
                        if let result = resultDict?["result"] as? NSDictionary {
                            
                            if result.count > 0 {
                                if let point = result["points"] as? String {
                                    
                                    let getPoint = Int(point)
                                    var featchLocalPoint = Int()
                                    
                                    if UserDefaults.standard.value(forKey: K_additional_Point) != nil {
                                        let pointValue = UserDefaults.standard.value(forKey: K_additional_Point) as? Int
                                        featchLocalPoint = pointValue ?? 0
                                        UserDefaults.standard.set(pointValue! + getPoint!, forKey: K_additional_Point)
                                        UserDefaults.standard.synchronize()
                                    }
                                    else{
                                        UserDefaults.standard.set(getPoint, forKey: K_additional_Point)
                                        UserDefaults.standard.synchronize()
                                        
                                    }
                                    
                                    if GlobalVariabel.additional_Point != ""{
                                        let getvalue = GlobalVariabel.additional_Point
                                        
                                        print(getvalue)
                                        let getInt = Int(getvalue)
                                        let getPoint = Int(point)
                                        let addvalue = getInt! + getPoint!
                                        print(addvalue)
                                        GlobalVariabel.additional_Point = String(addvalue)
                                        
                                    }
                                    else{
                                        GlobalVariabel.additional_Point = point
                                    }
                                    
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecoveryWellDoneViewController") as! RecoveryWellDoneViewController
                                    vc.delegate = self
                                    vc.intruptionType = self.intruptionType
                                    // vc.selectedPreviousIndex = self.selectedIndex+1
                                    vc.remaningtime = self.timeString(time: TimeInterval(self.seconds))
                                    vc.addPoint = self.addPoint
                                    vc.increasePoint = String(featchLocalPoint + getPoint!)
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                            }
                            else{
                                if let msg = resultDict?["message"] as? String{
                                    Toast.show(message: msg, controller: self)
                                }
                            }
                        }
                    }
                    else{
                        Toast.show(message: "Something went wrong", controller: self)
                    }
                }
                
            }
            else{
                Toast.show(message: "Something went wrong", controller: self)
                
            }
        }
        
    }
    
    
    func recoveryExcerciseUserBased(){
        
        self.showIndicator()
        
        DataService.sharedInstance.recoveryExcersiceListUserBased(userid: GlobalVariabel.userId) { (resultDict, errorMsg) in
            
            self.hideIndicator()
            
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool {
                    if status == true {
                        
                        self.runTimer()
                        
                        if let result = resultDict?["fitnessExercise"] as? [NSDictionary] {
                            
                            self.excersiceList.removeAll()
                            self.fitnesLevel.removeAll()
                            
                            for i in 0..<result.count {
                                
                                let dict = result[i]
                                let exercises = dict["exercises"] as? NSDictionary
                                let fitnessArray = dict["fitness-level"] as? [NSDictionary]
                                
                                if let id = exercises?["id"] as? Int {
                                    let exercise = exercises?["exercise"] as? String
                                    let bodySection = exercises?["body_section"] as? String
                                    let videoLink = exercises?["video_link"] as? String
                                    let status = exercises?["status"] as? String
                                    let createdAt = exercises?["createdAt"] as? String
                                    let updatedAt = exercises?["updatedAt"] as? String
                                    
                                    self.excersiceList.append(recoveryExcersiceListModel.init(id: id, exercise: exercise ?? "", body_section: bodySection ?? "" , video_link: videoLink ?? "" , status: status ?? "" , createdAt: createdAt ?? "" , updatedAt: updatedAt ?? ""))
                                    
                                }
                                
                                if fitnessArray?.count ?? 0 > 0{
                                    for i in 0..<fitnessArray!.count {
                                        
                                        let fitnesObjc = fitnessArray?[i]
                                        
                                        if let id = fitnesObjc?["id"] as? Int {
                                            let exerciseId = fitnesObjc?["exercise_id"] as? Int
                                            let fitLevel = fitnesObjc?["fit_level"] as? String
                                            let reps = fitnesObjc?["reps"] as? String
                                            let points = fitnesObjc?["points"] as? String
                                            let status = fitnesObjc?["status"] as? String
                                            let createdAt = fitnesObjc?["createdAt"] as? String
                                            let updatedAt = fitnesObjc?["updatedAt"] as? String
                                            
                                            self.fitnesLevel.append(fitnessLevelModel.init(id: id, exercise_id: exerciseId ?? 0, fit_level: fitLevel ?? "" , reps: reps ?? "", points: points ?? "" , status: status ?? "" , createdAt: createdAt ?? "" , updatedAt: updatedAt ?? ""))
                                        }
                                        
                                    }
                                }
                                
                            }
                            
                            self.setupExcersices()
                        }
                        
                        
                    }
                    else{
                        if let message = resultDict?["message"] as? String {
                            Toast.show(message: message, controller: self)
                        }
                        self.timer.invalidate()
                        Toast.show(message: "Something went wrong", controller: self)
                    }
                }
            }
            else{
                self.alert(message: "Something went wrong", title: "")
                if let message = resultDict?["message"] as? String {
                    Toast.show(message: message, controller: self)
                }
                // Toast.show(message: "Something went wrong", controller: self)
                self.timer.invalidate()
            }
        }
    }
    
}
