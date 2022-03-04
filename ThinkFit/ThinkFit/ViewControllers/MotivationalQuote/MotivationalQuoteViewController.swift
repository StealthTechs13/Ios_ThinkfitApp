//
//  MotivationalQuoteViewController.swift
//  ThinkFit
//
//  Created by apple on 24/12/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class MotivationalQuoteViewController: UIViewController {
    
    
    //MARK:- Outlets
    @IBOutlet weak var navbarViewHeight: NSLayoutConstraint!
    @IBOutlet weak var motivationQuoteTableView: UITableView!
    
    
    //MARK:- Define Variable
    var intruptionList = [intruptionModel]()
    var getSelectedValue = [String]()
    var selectIntruptionData = [[String: Any]]()
    var selectIntrupDict = [String: Any]()
    var finalDataArry = [[String:Any]]()
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        selectIntruptionData.removeAll()
        // Do any additional setup after loading the view.
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
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        motivaitonIntruption()
    }
    
    
    //MARK:- UIButton Actions
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        jsonConvert()
    }
    
    
    //MARK:- Json Converter Fuction
    func jsonConvert(){
        
        if intruptionList.count > 0 {
            for i in 0..<intruptionList.count{
                var dict = [String:Any]()
                let intrupId = intruptionList[i].intruptionId
                let intrupName = intruptionList[i].intruptionFocusTip
                let intrupSelectStatus = intruptionList[i].intruptionSelectedStatus
                dict["interruption_id"] = intrupId
                dict["interruption_name"] = intrupName
                dict["interruption_status"] = intrupSelectStatus
                selectIntruptionData.append(dict)
                
            }
            let jsonData: Data? = try? JSONSerialization.data(withJSONObject: selectIntruptionData)
            if let jsonString = String(data: jsonData!, encoding: .utf8){
                print(jsonString)
                submitMotivationAPI(intruptionData: jsonString)
            }
        }
    }
    
}

//MARK:- UITableView Delegate & DataSource Method
extension MotivationalQuoteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return intruptionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MotivationQuoteTableViewCell") as! MotivationQuoteTableViewCell
        cell.intruptionLbl.text = intruptionList[indexPath.row].intruptionFocusTip
        cell.checkUncheckButton.tag = indexPath.row
        cell.checkUncheckButton.addTarget(self, action: #selector(checkBoxButtonTapped(sender:)), for: .touchUpInside)
        
        if intruptionList[indexPath.row].intruptionSelectedValue == true {
            cell.checkUncheckButton.setImage(#imageLiteral(resourceName: "icSelectedCheckbox"), for: .normal)
            cell.intruptionLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        else{
            cell.checkUncheckButton.setImage(#imageLiteral(resourceName: "icUnselectedCheckbox"), for: .normal)
            cell.intruptionLbl.textColor = #colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6470588235, alpha: 1)
        }
        return cell
    }
    
    
    //MARK:- CheckBox Button Object Function
    @objc func checkBoxButtonTapped(sender: UIButton){
     
        if intruptionList[sender.tag].intruptionSelectedValue == false {
            intruptionList[sender.tag].intruptionSelectedValue = true
            intruptionList[sender.tag].intruptionSelectedStatus = 1
        }
        else {
            intruptionList[sender.tag].intruptionSelectedValue = false
            intruptionList[sender.tag].intruptionSelectedStatus = 0
        }
        motivationQuoteTableView.reloadData()
    }
}


//MARK:- Calling API's
extension MotivationalQuoteViewController {
    
    func motivaitonIntruption(){
        
        self.showIndicator()
        
        DataService.sharedInstance.motivationIntruptionList(userid: GlobalVariabel.userId) { (resultDict, errorMsg) in
            
            self.hideIndicator()
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool {
                    if status == true {
                        
                        if let result = resultDict?["result"] as? [NSDictionary] {
                            
                            print(result)
                            self.intruptionList.removeAll()
                            
                            for i in 0..<result.count {
                                
                                let dict = result[i]
                                let intruption = dict["All_Interruption_listing"] as? [NSDictionary]
                                
                                if intruption?.count ?? 0 > 0{
                                    for i in 0..<intruption!.count {
                                        
                                        let intruptionObjc = intruption?[i]
                                        
                                        if let id = intruptionObjc?["id"] as? Int {
                                            let focus_tip = intruptionObjc?["focus_tip"] as? String
                                           // let intStatus = intruptionObjc?["status"] as? String
                                            let createdAt = intruptionObjc?["createdAt"] as? String
                                            let updateat = intruptionObjc?["updatedAt"] as? String
                                            
                                            self.intruptionList.append(intruptionModel.init(intruptionId: id, intruptionFocusTip: focus_tip ?? "", intruptionStatus: 0, intruptionCreateAt: createdAt ?? "", intruptionUpdateAt: updateat ?? "", intruptionSelectedValue: false, intruptionSelectedStatus: 0))
                                        }
                                    }
                                    
                                }
                                
                                let selected = dict["User_selected_interruption"] as? [NSDictionary]
                                
                                if selected?.count ?? 0 > 0 {
                                    
                                    self.intruptionList.removeAll()
                                
                                    for i in 0..<selected!.count {
                                        
                                        let selectedData = selected?[i]
                                        
                                   //     if let id = selectedData?["id"] as? Int {
                                           // let user_id = selectedData?["user_id"] as? Int
                                           // let exercise_id = selectedData?["exercise_id"] as? String
                                            let interruption_id = selectedData?["interruption_id"] as? Int
                                            let interruption_status = selectedData?["interruption_status"] as? Int
                                            let interruption_name = selectedData?["interruption_name"] as? String
                                           // let status = selectedData?["status"] as? String
                                            let createdAt = selectedData?["createdAt"] as? String
                                            let updatedAt = selectedData?["updatedAt"] as? String
                                            
                                            var checkNewStatus = Bool()
                                            if interruption_status == 1{
                                                checkNewStatus = true
                                            }
                                            else{
                                                checkNewStatus = false
                                            }
                                            
                                            self.intruptionList.append(intruptionModel.init(intruptionId: interruption_id ?? 0, intruptionFocusTip: interruption_name ?? "", intruptionStatus: interruption_status ?? 0, intruptionCreateAt: createdAt ?? "", intruptionUpdateAt: updatedAt ?? "", intruptionSelectedValue: checkNewStatus, intruptionSelectedStatus: interruption_status ?? 0))
                                    
                                    //    }
                                        
                                    }
                                }
                            }
                            
                            self.motivationQuoteTableView.reloadData()

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
    
    
    
    func submitMotivationAPI(intruptionData: String){
        
        self.showIndicator()
        
        DataService.sharedInstance.submitMotivationIntruption(userid: GlobalVariabel.userId, exerciseId: "Na", interruptionTypes: intruptionData) { (resultDict, errorMsg) in
            
            self.hideIndicator()
            
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool {
                    if status == true {
                        
                        if let message = resultDict?["message"] as? String {
                            Toast.show(message: message, controller: self)
                        }
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                    else{
                        if let message = resultDict?["message"] as? String{
                            Toast.show(message: message, controller: self)
                        }
                    }
                }
            }
            else{
                self.alert(message: "Something went wrong", title: "")
                if let message = resultDict?["message"] as? String{
                    Toast.show(message: message, controller: self)
                }
            }
        }
    }
}
