//
//  RegistrationQuestionWorkstationViewController.swift
//  ThinkFit
//
//  Created by apple on 28/08/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit
import DropDown

class RegistrationQuestionWorkstationViewController: UIViewController {
    
    
    //MARK:- Outlets
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var wearingNameLbl: UILabel!
    @IBOutlet weak var registerWorkstationTableView: UITableView!
    
    
    //MARK:- Define Variable
    var spaceAvailable = ""
    var matAvailable = ""
    var statiesAvailable = ""
    var resistanceAvailable = ""
    var wearningsAvailable = ""
    let wearningdropDown = DropDown()
    var wearningNameArray = [String]()
    var data = [NSDictionary]()
    var equipmentList = [RegistrationWorkstationEquipment]()
    var getRespone = [[String:Any]]()
    var getDict = [String: Any]()
    var getdemoRespone = [[String:Any]]()
    var yesIndexValue = Int()
    var noIndexValue = Int()
    var subjectselectedIndex = NSMutableArray()
    var noselectedIndex = NSMutableArray()
    var finalDataArry = [[String:Any]]()
    var atLeaseOneSelect = Bool()
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        showWearningList()
        workstationEquipments()
        getRespone.removeAll()
        finalDataArry.removeAll()
        subjectselectedIndex.removeAllObjects()
        noselectedIndex.removeAllObjects()
        wearingNameLbl.text = "Fitbit"
        atLeaseOneSelect = false
        
    }
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationbarSetup()
    }
    
    
    /*** Json Convert function ***/
    func jsonConvert(){
        
        for i in  0..<equipmentList.count {
            
           let yesnoValue = equipmentList[i].selectYesNoValue
            if yesnoValue == false {
                let QueId = equipmentList[i].equipment_Id
                var dict = [String:Any]()
                dict["q_id"] = QueId
                dict["response"] = "No"
                finalDataArry.append(dict)
            }
            else{
                let QueId = equipmentList[i].equipment_Id
                var dict = [String:Any]()
                dict["q_id"] = QueId
                dict["response"] = "Yes"
                finalDataArry.append(dict)
            }

        }
        
        let jsonData: Data? = try? JSONSerialization.data(withJSONObject: finalDataArry)
        if let jsonString = String(data: jsonData!, encoding: .utf8){
            print(jsonString)
            userWorkstationSurvey(questionData: jsonString, wearningType: "Fitbit")
        }
    }
    
    //MARK:- Navigation Bar Setup
    func navigationbarSetup(){
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .black
        self.navigationItem.setHidesBackButton(true, animated: true)
        title = "Registration"
        
    }
    
    @objc func navBackButtonAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    /*** Continue Button Tapped Action ***/
    @IBAction func continueButtonActions(_ sender: Any) {
        // workstationAvailableAPI()
        if atLeaseOneSelect == false {
            alert(message: "Please select all the required fields", title: "")
        }
        else{
            jsonConvert()
        }
        
        
    }
    
    /*** Drop Down Open Button Action ***/
    @IBAction func dropDownButtonAction(_ sender: Any) {
        wearningdropDown.show()
        setupTravelersDropDown()
    }
    
    
    //MARK:- DropDownMenuSetup
    func setupTravelersDropDown(){
        wearningdropDown.anchorView = wearingNameLbl
        wearningdropDown.dataSource = wearningNameArray
        wearningdropDown.width = 300//musicchatlbl.frame.width
        wearningdropDown.direction = .any
        wearningdropDown.bottomOffset = CGPoint(x: 0, y:(wearningdropDown.anchorView?.plainView.bounds.height)!)
        
        wearningdropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.wearingNameLbl.text = item
            
        }
    }

}


//MARK:- UITableView Delegate & DataSource Methods
extension RegistrationQuestionWorkstationViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return equipmentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationWorkStationTableViewCell") as! RegistrationWorkStationTableViewCell
        cell.yesButton.addTarget(self, action: #selector(yesTapped(_:)), for: .touchUpInside)
        cell.noButton.addTarget(self, action: #selector(noTapped(_:)), for: .touchUpInside)
        cell.workstationNamelbl.text = equipmentList[indexPath.row].equipmentTypeName
        
        //cell.cellDelegate = self
        cell.yesButton.tag = indexPath.row
        cell.noButton.tag = indexPath.row
        
        //IMAGE CHANGE:-
        if subjectselectedIndex.contains(indexPath.row){
            cell.yesButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
        }else{
            cell.yesButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
        }
        if noselectedIndex.contains(indexPath.row){
            cell.noButton.setImage(#imageLiteral(resourceName: "icSelectedRadioButton"), for: .normal)
        }else{
            cell.noButton.setImage(#imageLiteral(resourceName: "icUnselectedRadioButton"), for: .normal)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    
    /*** Cell Yes Button Tapped Action ***/
    @objc func yesTapped(_ sender: UIButton){
        let touchPoint = sender.convert(CGPoint.zero, to: self.registerWorkstationTableView)
        
        let clickedButtonIndexPath = registerWorkstationTableView.indexPathForRow(at: touchPoint)
        // print("index path.section = %d", (clickedButtonIndexPath?.section))
        
        sender.tag = clickedButtonIndexPath?.row ?? 0
        yesIndexValue = sender.tag
        equipmentList[sender.tag].selectYesNoValue =  true
        atLeaseOneSelect = true
        print(getRespone)
        
        if self.subjectselectedIndex.contains(yesIndexValue){
            self.subjectselectedIndex.remove(yesIndexValue)
            self.subjectselectedIndex.add(yesIndexValue)
            
        }else{
            self.subjectselectedIndex.add(yesIndexValue)
        }
        if self.noselectedIndex.contains(yesIndexValue){
            self.noselectedIndex.remove(yesIndexValue)
            self.subjectselectedIndex.add(yesIndexValue)
        }else{
            self.subjectselectedIndex.add(yesIndexValue)
        }
        
        registerWorkstationTableView.reloadData()
        
    }
    
    /*** Cell No Button Tapped Action ***/
    @objc func noTapped(_ sender: UIButton){
        let touchPoint = sender.convert(CGPoint.zero, to: self.registerWorkstationTableView)
        
        let clickedButtonIndexPath = registerWorkstationTableView.indexPathForRow(at: touchPoint)
        // print("index path.section = %d", (clickedButtonIndexPath?.section))
        
        sender.tag = clickedButtonIndexPath?.row ?? 0
        noIndexValue = sender.tag
        atLeaseOneSelect = true
        
        equipmentList[sender.tag].selectYesNoValue =  false
        
        print(getRespone)
        
        if self.subjectselectedIndex.contains(noIndexValue){
            self.subjectselectedIndex.remove(noIndexValue)
            self.noselectedIndex.add(noIndexValue)
        }else{
            self.noselectedIndex.add(noIndexValue)
        }
        
        if self.noselectedIndex.contains(noIndexValue){
            self.noselectedIndex.remove(noIndexValue)
            self.noselectedIndex.add(noIndexValue)
        }else{
            self.noselectedIndex.add(noIndexValue)
        }
        
        registerWorkstationTableView.reloadData()
        
    }
    
}


//MARK:- Calling API'S
extension RegistrationQuestionWorkstationViewController {
    
    /*** Work_Station_Equipment ***/
    func workstationEquipments(){
        self.showIndicator()
        
        DataService.sharedInstance.registrationEquipments(userid: GlobalVariabel.userId) { (resultDict, errorMsg) in
            
            self.hideIndicator()
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool {
                    if status == true {
                        
                        if let result = resultDict?["result"] as? [NSDictionary]{
                            print(result)
                            
                            for i in 0..<result.count {
                                
                                let data = result[i]
                                
                                if let equipment_Id = data["id"] as? Int {
                                    let equipment_type = data ["equipment_type"] as? String
                                    let equipment_status = data["status"] as? String
                                    let equipment_create_at  = data["createdAt"] as? String
                                    let equipment_update_at = data["updatedAt"] as? String
                                    
                                    
                                    self.equipmentList.append(RegistrationWorkstationEquipment.init(equipment_Id: equipment_Id, equipmentTypeName: equipment_type ?? "", workStatus: equipment_status ?? "", workCreatedAt: equipment_create_at ?? "", workUpdatedAt: equipment_update_at ?? "", selectYesNoValue: false))
                                }
                                self.registerWorkstationTableView.reloadData()
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
    
    
    /*** user_workStation_Survey ***/
    func userWorkstationSurvey(questionData : String, wearningType: String){
        
        self.showIndicator()
        DataService.sharedInstance.userWorkStationSurvey(userid: GlobalVariabel.userId, question_id: questionData, wearning_type: wearningType) { (resultDict, errorMsg) in
            self.hideIndicator()
            
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool {
                    
                    if status == true {
                        
                        UserDefaults.standard.removeObject(forKey: K_StepSix)
                        UserDefaults.standard.synchronize()
                        if let result = resultDict?["result"] as? Int {
                            
                            GlobalVariabel.totalPoint = String(result)
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationSuperFitUnfitViewController") as! RegistrationSuperFitUnfitViewController
                            vc.totalPoint = String(result)
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        
                    }
                    else {
                        UserDefaults.standard.set("0", forKey: K_StepSix)
                        UserDefaults.standard.synchronize()
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
    
    
    /*** Wearning_List API ***/
    func showWearningList(){
        
        DataService.sharedInstance.wearningList { (resultDict, errorMsg) in
            print(resultDict as Any)
            if let dic =  resultDict{
                self.data = dic["result"] as? [NSDictionary] ?? []
                self.wearningNameArray.removeAll()
                for category in self.data{
                    let wearingType = category["type"] as! String
                    print(wearingType)
                    self.wearningNameArray.append(wearingType)
                }
            }
            
        }
    }
    
}
