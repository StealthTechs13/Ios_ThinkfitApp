//
//  HomeMyTaskViewController.swift
//  ThinkFit
//
//  Created by apple on 10/09/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit
import SideMenu
import RealmSwift

class HomeMyTaskViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var myTaskListTableView: UITableView!
    @IBOutlet weak var mytaskListTableViewBackGroundView: UIView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var navLeftBarButton: UIButton!
    @IBOutlet weak var navRightBarButton: UIButton!
    @IBOutlet weak var navigationViewHeight: NSLayoutConstraint!
    @IBOutlet weak var qutoteCrossButton: UIButton!
    @IBOutlet weak var quoteBackGroundBlackView: UIView!
    @IBOutlet weak var quoteLbl: UILabel!
    @IBOutlet weak var quoteType: UILabel!
    @IBOutlet weak var quoteBackView: UIView!
    
    
    //MARK:- Define array
    var colorArray = [#colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 0.18),#colorLiteral(red: 0.2196078431, green: 0.5176470588, blue: 0.9960784314, alpha: 0.06),#colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 0.18),#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 0.18)]
    
    var topColorArray = [#colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1),#colorLiteral(red: 0, green: 0.4156862745, blue: 0.9960784314, alpha: 1),#colorLiteral(red: 0.968627451, green: 0.4196078431, blue: 0.1098039216, alpha: 1),#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)]
    var bottomColorArray = [#colorLiteral(red: 1, green: 0.4509803922, blue: 0.5176470588, alpha: 1),#colorLiteral(red: 0, green: 0.6392156863, blue: 1, alpha: 1),#colorLiteral(red: 0.9803921569, green: 0.8509803922, blue: 0.3803921569, alpha: 1),#colorLiteral(red: 0.7960784314, green: 0.7960784314, blue: 0.7960784314, alpha: 1)]
    
    var dotcolorArray = [#colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1),#colorLiteral(red: 0.2196078431, green: 0.5176470588, blue: 0.9960784314, alpha: 1),#colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1),#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)]
    var newColorArray = ["#D0021B","#3884FE","#F5A623","#9B9B9B"]
    var dotColorImagesArray = ["icRedCircle", "icBlueCircle", "icYellowCircle", "icGreyCircle"]
    var showingTaskList = [saveTaskData]()
    var filterArray = [saveTaskData]()
    var selectTaskId = ""
    var categoryName = ""
    var homeFilter = Bool()
    let realm = try! Realm()
    var timer = Timer()
    var dataArray:Results<intruptionQuoteEntries>? = nil
    var intruptionTime = 0
    var renewalTime = 15
    var ohIntruptionCount = 0
    var recoveryTime = 5
    var renewalNotimeCount = 0
    var renewalScreenVcTime = 0
    var recoveryScreenVcTime = 0
    var stopTimeToTired = 0
    var toDifficultTime = 0
    var noTime = 0
    var sevenTimeUpdateRecovery = 0
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        UIApplication.shared.isIdleTimerDisabled = true
        //print(Realm.Configuration.defaultConfiguration.fileURL as Any)
        // Do any additional setup after loading the view.
    }
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationBarSetup()
        changeTextColor()
        userTotalPoint()
        showTaskAPI()
        checkDateandCallApi()
       // getDataFromLocalDB()
       // intruptionQuoteList()
        updateFCMToken(fcmToken: GlobalVariabel.firebase_token)
        
    }
    
    //MARK:- ViewWillLayoutSubView
    override func viewWillLayoutSubviews() {
        if UIScreen.main.bounds.size.height <= 736{
            navigationViewHeight?.constant = 64
            self.view.layoutIfNeeded()
        }
        else{
            navigationViewHeight?.constant = 90
            self.view.layoutIfNeeded()
        }
    }
    
//    //Mark:- Calling API's
//    func checkDateandCallApi(){
//
//        if UserDefaults.standard.value(forKey: K_todayTomorrowDate) != nil {
//
//            let today = Date()
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd-MM-yyyy"
//            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
//            let todayStr = dateFormatter.string(from: today)
//            //let dateToday = dateFormatter.date(from: todayStr)
//            let oldDatestr = UserDefaults.standard.value(forKey: K_todayTomorrowDate) as? String ?? ""
//            //let oldDate = dateFormatter.date(from: oldDatestr)
//
//            if oldDatestr == todayStr{
//                quoteBackGroundBlackView.isHidden = true
//                quoteBackView.isHidden = true
//            }else{
//                // let today = Date()
//                // let dateFormatter = DateFormatter()
//                // dateFormatter.dateFormat = "dd-MM-yyyy"
//                // dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
//                // let todayStr = dateFormatter.string(from: today)
//                //let dateToday = dateFormatter.date(from: todayStr)
//                UserDefaults.standard.setValue(todayStr, forKey: K_todayTomorrowDate)
//                UserDefaults.standard.removeObject(forKey: K_additional_Point)
//                UserDefaults.standard.set(self.intruptionTime, forKey: K_IntruptionCount)
//                UserDefaults.standard.set(self.renewalTime, forKey: K_renewal_Count)
//                UserDefaults.standard.set(self.ohIntruptionCount, forKey: K_ohohIntruption)
//                UserDefaults.standard.synchronize()
//                intruptionQuoteList()
//                quoteBackGroundBlackView.isHidden = false
//                quoteBackView.isHidden = false
//                getDataFromLocalDB()
//            }
//        }else{
//            let today = Date()
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd-MM-yyyy"
//            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
//            let todayStr = dateFormatter.string(from: today)
//            // let dateToday = dateFormatter.date(from: todayStr)
//            UserDefaults.standard.setValue(todayStr, forKey: K_todayTomorrowDate)
//            UserDefaults.standard.removeObject(forKey: K_additional_Point)
//            UserDefaults.standard.set(self.intruptionTime, forKey: K_IntruptionCount)
//            UserDefaults.standard.set(self.renewalTime, forKey: K_renewal_Count)
//            UserDefaults.standard.set(self.ohIntruptionCount, forKey: K_ohohIntruption)
//            UserDefaults.standard.synchronize()
//            intruptionQuoteList()
//            getDataFromLocalDB()
//            quoteBackGroundBlackView.isHidden = false
//            quoteBackView.isHidden = false
//
//        }
//    }
    
    
    //MARK:- Change TextColor
    func changeTextColor(){
        let string = NSMutableAttributedString(string: "There is no task added yet \n Tap + to add tasks")
        string.setColorForText("+", with: #colorLiteral(red: 0.9843137255, green: 0.4941176471, blue: 0.1294117647, alpha: 1))
        descriptionLbl.attributedText = string
    }
    
    
    //MARK:- SideMenu Setup
    private func setupSideMenu() {
        // Define the menus
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier:
                                                                                                        "menuLeftNavigationController") as? SideMenuNavigationController
    }
    
    //MARK:- HideUnhide or NavigationBar setup
    func navigationBarSetup(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "My Tasks"
    }
    
    //MARK:- UIButton Actions
    
    /*** Nav_Left_Button Action ***/
    @IBAction func navLeftButtonAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "menuLeftNavigationController") as! SideMenuNavigationController
        nextViewController.leftSide = true
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    
    /*** Nav_Right_Button Action ***/
    @IBAction func navRightButtonAction(_ sender: Any) {
        guard let myVC = self.storyboard?.instantiateViewController(withIdentifier: "FilterMyTaskViewController") as? FilterMyTaskViewController else { return }
        let navController = UINavigationController(rootViewController: myVC)
        myVC.filterDelegate = self
        myVC.dismissDelegate = self
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    
    /*** Plus_Button Action ***/
    @IBAction func plusButtonAction(_ sender: Any) {
        
        guard let myVC = self.storyboard?.instantiateViewController(withIdentifier: "NewTaskViewController") as? NewTaskViewController else { return }
        let navController = UINavigationController(rootViewController: myVC)
        myVC.dismissDelegate = self
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    
    @IBAction func myTaskSaveButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func myTaskCancelButtonAction(_ sender: Any) {
        
    }
    
    /*** Quote View Cross Button ***/
    @IBAction func quoteCrossButtonAction(_ sender: Any) {
        quoteBackGroundBlackView.isHidden = true
        quoteBackView.isHidden = true
    }
    
    
    //MARK:Save data realm
    func saveDataToRealm(intruptionQuote : intruptionQuoteEntries) {
        do {
            try self.realm.write {
                self.realm.add(intruptionQuote)
            }
        } catch {
            print("error saving data to realm \(error)")
        }
    }
    
    //MARK:- Get Data From Local DB
    func getDataFromLocalDB(){
        
        let dataArray = realm.objects(intruptionQuoteEntries.self)
        
        if dataArray.count > 0{
            
            for item in dataArray.choose(dataArray.count){
                
                print(item)
                
                if item.quote != "" {
                    quoteType.text = item.quotefocusTip
                    quoteLbl.text = item.quote
                    quoteBackGroundBlackView.isHidden = false
                    quoteBackView.isHidden = false
                    
                }
                else{
                    quoteBackGroundBlackView.isHidden = true
                    quoteBackView.isHidden = true
                }
                
            }

            
        }else{
            quoteBackGroundBlackView.isHidden = true
            quoteBackView.isHidden = true
            // onboardViewALLAPI()
        }
    }
    
    
}

//MARK:- UITableView Delegate & DataSource Method
extension HomeMyTaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filterArray.count == 0 {
            self.mytaskListTableViewBackGroundView.isHidden = true
            self.navigationView.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.07843137255, blue: 0.1137254902, alpha: 1)
            return 0
        }
        else{
            self.mytaskListTableViewBackGroundView.isHidden = false
            self.navigationView.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.07843137255, blue: 0.1137254902, alpha: 1)
            return filterArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTaskListTableViewCell") as! MyTaskListTableViewCell
        
        
        if filterArray[indexPath.row].showingTaskList == true {
            if filterArray[indexPath.row].taskcategory == "1" {
                cell.taskNameBackGroundView.backgroundColor = colorArray[0]
                // cell.taskDotView.backgroundColor = dotcolorArray[0]
                cell.taskNameLbl.text = "\(filterArray[indexPath.row].taskname)" //\("Urgent And Important")
                cell.taskDotImage.image = UIImage(named: dotColorImagesArray[0])
                // cell.taskDotView.insertHorizontalGradient(color1: topColorArray[0 % bottomColorArray.count] , color2: bottomColorArray[0 % topColorArray.count])
            }
            else if filterArray[indexPath.row].taskcategory == "2" {
                cell.taskNameBackGroundView.backgroundColor = colorArray[1]
                // cell.taskDotView.backgroundColor = dotcolorArray[1]
                cell.taskNameLbl.text = "\(filterArray[indexPath.row].taskname)" //\("Not Urgent & Important ")
                cell.taskDotImage.image = UIImage(named: dotColorImagesArray[1])
                // cell.taskDotView.insertHorizontalGradient(color1: topColorArray[1 % bottomColorArray.count] , color2: bottomColorArray[1 % topColorArray.count])
            }
            else if filterArray[indexPath.row].taskcategory == "3" {
                cell.taskNameBackGroundView.backgroundColor = colorArray[2]
                // cell.taskDotView.backgroundColor = dotcolorArray[2]
                cell.taskNameLbl.text = "\(filterArray[indexPath.row].taskname)" //\("Urgent & Not Important")
                cell.taskDotImage.image = UIImage(named: dotColorImagesArray[2])
                // cell.taskDotView.insertHorizontalGradient(color1: topColorArray[2 % bottomColorArray.count] , color2: bottomColorArray[2 % topColorArray.count])
            }
            else if filterArray[indexPath.row].taskcategory == "4" {
                cell.taskNameBackGroundView.backgroundColor = colorArray[3]
                //  cell.taskDotView.backgroundColor = dotcolorArray[3]
                cell.taskNameLbl.text = "\(filterArray[indexPath.row].taskname)"//\("Not Urgent & Not Important ")
                cell.taskDotImage.image = UIImage(named: dotColorImagesArray[3])
                // cell.taskDotView.insertHorizontalGradient(color1: topColorArray[3 % bottomColorArray.count] , color2: bottomColorArray[3 % topColorArray.count])
            }
        }
        else {
            
        }
        
        
        if filterArray[indexPath.row].task_status == "1"{
            cell.taskCompleteStatusCheckImage.isHidden = false
        }
        else{
            cell.taskCompleteStatusCheckImage.isHidden = true
        }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if filterArray[indexPath.row].task_status == "1" {
            let alert = UIAlertController(title: "", message: "Are you sure you want to uncheck this task?", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "Yes", style: .default, handler: { action in
                self.updateTaskStatus(taskId: self.filterArray[indexPath.row].taskid)
            })
            alert.addAction(ok)
            let cancel = UIAlertAction(title: "No", style: .default, handler: { action in
            })
            alert.addAction(cancel)
            DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
            })
            
        }
        else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ThinkFitFocusTimeViewController") as! ThinkFitFocusTimeViewController
            
            GlobalVariabel.taskName = filterArray[indexPath.row].taskname
            GlobalVariabel.taskID = filterArray[indexPath.row].taskid
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            filterArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            myTaskListTableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    } 
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            // delete the item here
            
            let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this task?", preferredStyle: .alert)
            let NoAction = UIAlertAction(title: "No", style: .cancel, handler: {
                _ in
                self.myTaskListTableView.reloadData()
            })
            let yesaction = UIAlertAction(title: "Yes", style: .default, handler: {_ in
                
                //  self.selectTaskId = self.filterArray[indexPath.row].taskid
                
                self.deleteTaskAPI(indexpath: indexPath.row , selectTaskId: self.filterArray[indexPath.row].taskid)
                completionHandler(true)
            })
            
            alertController.addAction(NoAction)
            alertController.addAction(yesaction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        deleteAction.image = UIImage(named: "icDeleteWhite")
        deleteAction.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.07843137255, blue: 0.1137254902, alpha: 1)
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}


//MARK:- Protocl Function
extension HomeMyTaskViewController : CallingShowingTaskAPI , CallingHomeScreen{
    func dismissController() {
        showTaskAPI()
    }
}


//MARK:- Protocol Function to Filter Tasks
extension HomeMyTaskViewController : FilterData {
    
    /*** This Function to Get Value to Help of Protocol ***/
    func filterData(filterCategory: String, checkView: String, filterValue: Bool) {
        categoryName = filterCategory
        homeFilter = filterValue
        //  filterArray.removeAll()
        filterData()
        
    }
    
    /*** This Function to sorting Value and Save Value ***/
    func filterData(){
        var filterpendingValue = [saveTaskData]()
        if categoryName != ""{
            filterArray.removeAll()
            for item in showingTaskList{
                if categoryName == item.taskcategory{
                    filterArray.append(item)
                }
                else{
                    filterpendingValue.append(item)
                }
            }
            filterArray = filterArray + filterpendingValue
            
        }
        
        myTaskListTableView.reloadData()
    }
}


//MARK:- API's Calling
extension HomeMyTaskViewController {
    
    /*** show Task API ****/
    func showTaskAPI(){
        
        self.showIndicator()
        
        DataService.sharedInstance.showTask(userId: GlobalVariabel.userId) { (resultDict, errorMsg) in
            
            self.hideIndicator()
            
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool {
                    
                    if status == true {
                        
                        self.filterArray.removeAll()
                        
                        if let result = resultDict?["result"] as? [NSDictionary] {
                            
                            self.showingTaskList.removeAll()
                            
                            for i in 0..<result.count{
                                
                                var taskid = ""
                                var taskname = ""
                                var taskneed = ""
                                var taskphysicalAction = ""
                                var taskcategory = ""
                                var task_createdAt = ""
                                var task_updatedAt = ""
                                var task_status = ""
                                
                                let data = result[i]
                                
                                if let task_id = data["id"] as? Int {
                                    taskid = "\(task_id)"
                                }
                                
                                if let task_name = data["task"] as? String {
                                    taskname = task_name
                                }
                                
                                if let task_need = data["need"] as? String {
                                    taskneed = task_need
                                }
                                
                                if let task_phy_action = data["physical_action"] as? String {
                                    taskphysicalAction = task_phy_action
                                }
                                
                                if let task_category = data["category"] as? String {
                                    taskcategory = task_category
                                }
                                
                                if let task_created_at = data["createdAt"] as? String {
                                    task_createdAt = task_created_at
                                }
                                
                                if let task_updated_at = data["updatedAt"] as? String {
                                    task_updatedAt = task_updated_at
                                }
                                
                                if let taskstatus = data["task_status"] as? String {
                                    task_status = taskstatus
                                }
                                
                                self.showingTaskList.append(saveTaskData.init(task_Id: taskid, task_name: taskname, task_need: taskneed, task_phy_action: taskphysicalAction, task_category: taskcategory, task_create_at: task_createdAt, task_update_at: task_updatedAt, task_status: task_status, showingTaskList: true))
                                
                                self.filterArray = self.showingTaskList
                            }
                            
                            self.filterData()
                            
                            // self.myTaskListTableView.reloadData()
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
    
    
    /*** Delete Task API ***/
    func deleteTaskAPI(indexpath: Int, selectTaskId: String){
        
        self.showIndicator()
        
        DataService.sharedInstance.deleteTask(userId: GlobalVariabel.userId, taskId: selectTaskId) { (resultDict, errorMsg) in
            
            self.hideIndicator()
            
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool {
                    
                    if status == true {
                        self.showTaskAPI()
                    }
                    else {
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
    
    
    /*** User Total Point ***/
    func userTotalPoint(){
        DataService.sharedInstance.userTotalPoint(userId: GlobalVariabel.userId) { (resultDict, errorMsg) in
            print(resultDict as Any)
            if errorMsg == nil {
                
                if let status =  resultDict?["status"] as? Bool{
                    if status == true {
                        
                        if let result = resultDict?["result"] as? NSDictionary{
                            
                            if let totalSum = result["points"] as? String {
                                let notistatus = result["notification_status"] as? String
                                let additionalPointValue = result["additional_point_sum"] as? String
                                
                                UserDefaults.standard.set(additionalPointValue, forKey: K_addNewPoint)
                                UserDefaults.standard.set(totalSum, forKey: K_TotalPoint)
                                UserDefaults.standard.synchronize()
                                
                                GlobalVariabel.totalPoint = totalSum
                                GlobalVariabel.additional_Point = additionalPointValue ?? "0"
                                GlobalVariabel.noti_status = notistatus ?? ""
                                
                            }
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
    
    
    //MARK:- Intruption_QuoteListAPI
    func intruptionQuoteList(){
        self.showIndicator()
        DataService.sharedInstance.intruptionBaseQuoteListing(userid: GlobalVariabel.userId) { (resultDict, errorMsg) in
            self.hideIndicator()
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool {
                    if status == true {
                        UserDefaults.standard.set("false", forKey: "callApi")
                        UserDefaults.standard.synchronize()
                        self.timer.invalidate()
                        if let result = resultDict?["result"] as? [NSDictionary]{
                            
                            print(result)
                            
                            for i in 0..<result.count {
                                
                                let data = result[i]
                                
                                let intruptionQuote = intruptionQuoteEntries()
                                
                                if let focus_tip = data["focus_tip"] as? String {
                                    intruptionQuote.quotefocusTip = focus_tip
                                }
                                
                                if let intruption_quotes = data["quotes"] as? String {
                                    intruptionQuote.quote = intruption_quotes
                                }
                                
                                if let intruption_description = data["description"] as? String {
                                    intruptionQuote.quoteDescription = intruption_description
                                }
                                
                                self.saveDataToRealm(intruptionQuote: intruptionQuote)
                                
                            }
                            self.getDataFromLocalDB()
                        }
                    }
                    else{
//                        if let message = resultDict?["message"] as? String {
//                            Toast.show(message: message, controller: self)
//                        }
                    }
                }
            }
            else{
                self.alert(message: "Something went wrong", title: "")
                //                if let message = resultDict?["message"] as? String {
                //                    Toast.show(message: message, controller: self)
                //                }
            }
        }
        
    }
    
    /*** Update FCM Token ***/
    public func updateFCMToken(fcmToken: String){
        DataService.sharedInstance.updateDevicetoken(userid: GlobalVariabel.userId, deviceToken: fcmToken) { (resultDict, errorMsg) in
            if errorMsg == nil {
                if let status = resultDict?["status"] as? Bool {
                    if status == true {
                        
                    }
                }
            }
            else {
                if let msg = resultDict?["message"] as? String{
                    Toast.show(message: msg, controller: self)
                }
            }
        }
    }
    
    /*** Update Task Status to Complete or Not ***/
    func updateTaskStatus(taskId : String ){
        
        self.showIndicator()
        DataService.sharedInstance.updateTaskStatus(userid: GlobalVariabel.userId, taskID: taskId) { (resulDict, errorMsg) in
            
            self.hideIndicator()
            
            print(resulDict as Any)
            
            if errorMsg == nil {
                
                if let status = resulDict?["status"] as? Bool {
                    if status == true {
                        self.showTaskAPI()
                    }
                    else{
                        print("Error")
                    }
                }
            }
            else{
                self.alert(message: "Something went wrong", title: "")
            }
        }
        
    }
}


//MARK:-This Function to Set a API's Calling Are Call Once in a Day
extension HomeMyTaskViewController {
    
    func checkDateandCallApi(){
        if UserDefaults.standard.value(forKey: K_todayTomorrowDate) != nil {
            let today = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            let todayStr = dateFormatter.string(from: today)
            let oldDatestr = UserDefaults.standard.value(forKey: K_todayTomorrowDate) as? String ?? ""
            
            if oldDatestr == todayStr{
                quoteBackGroundBlackView.isHidden = true
                quoteBackView.isHidden = true
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
                intruptionQuoteList()
//                quoteBackGroundBlackView.isHidden = false
//                quoteBackView.isHidden = false
//                getDataFromLocalDB()
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
            intruptionQuoteList()
//            getDataFromLocalDB()
//            quoteBackGroundBlackView.isHidden = false
//            quoteBackView.isHidden = false
            
        }
    }
    
}



