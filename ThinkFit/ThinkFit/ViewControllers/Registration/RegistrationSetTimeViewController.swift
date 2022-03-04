//
//  RegistrationSetTimeViewController.swift
//  ThinkFit
//
//  Created by apple on 27/08/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class RegistrationSetTimeViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var selfTypeCollectionView: UICollectionView!
    @IBOutlet weak var daysCollectionView: UICollectionView!
    @IBOutlet weak var enterTitleTextField: UITextField!
    @IBOutlet weak var setRegistrationTimerTableView: UITableView!
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var timeSuperView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var defaultTitleLbl: UILabel!
    
    
    //MARK:- Define Array
    var selfTypeArray = ["Student", "Self Employed", "Employed"]
    var DaysArray = ["S", "M", "T", "W", "TH", "F", "SA"]
    var AddTimeNameArray = ["Average Start Time"]
    var selectableIndexPath = [String]()
    let datePicker = UIDatePicker()
    var saveTime = ""
    var typeSaveValue = ""
    var changeFormatter = ""
    var timeZone = ""
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        timeSuperView.isHidden = true
        defaultTitleLbl.text = "Which of the following categories best represents your current situation?"
        defaultTitleLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let currentTimeZone = getCurrentTimeZone()
        timeZone = currentTimeZone
        print(currentTimeZone)
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- Get Current_Time_Zone
    func getCurrentTimeZone() -> String{
        return TimeZone.current.identifier
    }
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationSetup()
       // saveTime = Date.formatter.string(from: datePicker.date)
        saveTime = Date.changeFormatter.string(from: datePicker.date)
       // convertingRemaingTimeStringIntoInteger(time: saveTime)
        setRegistrationTimerTableView.reloadData()
        print(saveTime)
    }
    
    
    //MARK:- Navigation Setup
    func navigationSetup(){
          navigationController?.navigationBar.isHidden = false
          navigationController?.navigationBar.barStyle = .black
          self.navigationItem.setHidesBackButton(true, animated: true)
          title = "Registration"
          
      }
      
      //MARK:- Object Function Button Action
      @objc func icMenuButtonAction(){
          self.navigationController?.popViewController(animated: true)
      }
    
    
    //MARK:- UIButton Action
    /*** Continue Button Action ***/
    @IBAction func continueButtonAction(_ sender: Any) {
            
        let array = selectableIndexPath
        let datastring = array.joined(separator: ",")
        print(datastring)

        userdetailInfoAPI(focusDays: datastring)
      
    }
    
    
    /*** Show_Date_Picker function ***/
    func showDatePicker(){
        //Formate Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        datePicker.datePickerMode = .time
        //datePicker.center = timerView.center
        timerView.addSubview(datePicker)
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    /*** Timer Cancel Button Action ***/
    @IBAction func timerCancelButtonAction(_ sender: Any) {
        timeSuperView.isHidden = true
    }
    
    /*** Timer Done Button Action ***/
    @IBAction func timerDoneButtonAction(_ sender: Any) {
        //saveTime = Date.formatter.string(from: datePicker.date)
        saveTime = Date.changeFormatter.string(from: datePicker.date)
       // convertingRemaingTimeStringIntoInteger(time: saveTime)
        
        timeSuperView.isHidden = true
        setRegistrationTimerTableView.reloadData()
    }
    
    
    
    //MARK:- ConvertingStringValue to Time
    func convertingRemaingTimeStringIntoInteger(time: String){
        let remaingTimeString = time
        let getStringFirstVal = remaingTimeString.firstIndex(of: ":")!
        let getStringSecondVal = remaingTimeString.prefix(upTo: getStringFirstVal)
        let componentVal = remaingTimeString.components(separatedBy: ":")[1]
        let convertingIntegerVal = Int(getStringSecondVal) ?? 0
        let newTime = convertingIntegerVal*60
        let secondIntTime = Int(componentVal) ?? 0
        let newTimeToDisplay = newTime + secondIntTime
        print(newTimeToDisplay)
        print(newTime)
        
    }
    
        
}


//MARK:- UICollectionView Delegate & DataSource Method
extension RegistrationSetTimeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.selfTypeCollectionView {
            return CGSize(width: selfTypeCollectionView.bounds.width, height: 80)
        }
        return CGSize(width: 42, height: 42)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.selfTypeCollectionView {
            return 10.0
        }
        
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.selfTypeCollectionView {
            return selfTypeArray.count
        }else {
            return DaysArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.selfTypeCollectionView{
            let selfTypeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegistrationSelfTypeCollectionViewCell", for: indexPath) as! RegistrationSelfTypeCollectionViewCell
            selfTypeCell.TypeLbl.text = selfTypeArray[indexPath.row]
            
            
            if typeSaveValue == selfTypeArray[indexPath.row] {
                selfTypeCell.cellChildView.backgroundColor = #colorLiteral(red: 0, green: 0.6392156863, blue: 1, alpha: 1)
                selfTypeCell.cellChildView.borderColor = .clear
                selfTypeCell.TypeLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else{
                selfTypeCell.cellChildView.backgroundColor = .clear
                selfTypeCell.TypeLbl.textColor = #colorLiteral(red: 0.5607843137, green: 0.5607843137, blue: 0.5607843137, alpha: 1)
                selfTypeCell.cellChildView.borderColor = #colorLiteral(red: 0.5607843137, green: 0.5607843137, blue: 0.5607843137, alpha: 1)
            }
            
            return selfTypeCell
        }
        else {
            let daysCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegistrationDayCollectionViewCell", for: indexPath) as! RegistrationDayCollectionViewCell
            daysCell.dayLbl.text = DaysArray[indexPath.row]
            
            //set select cell color
            if selectableIndexPath.contains(String(indexPath.row)) {
                daysCell.cellChildView.borderColor = #colorLiteral(red: 0.9843137255, green: 0.4941176471, blue: 0.1294117647, alpha: 1)
                daysCell.dayLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else{
                daysCell.cellChildView.borderColor = .clear
                daysCell.dayLbl.textColor = #colorLiteral(red: 0.5607843137, green: 0.5607843137, blue: 0.5607843137, alpha: 1)
            }
            
            return daysCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.selfTypeCollectionView {
            
            typeSaveValue = selfTypeArray[indexPath.row]
            selfTypeCollectionView.reloadData()
            print(typeSaveValue)
            
        }
        else {
            
            if selectableIndexPath.contains(String(indexPath.row)){
                let imageindex = selectableIndexPath.firstIndex(where: {$0 == String(indexPath.row)})
                selectableIndexPath.remove(at: imageindex!)
            }
            else{
                let selectindex = DaysArray.firstIndex(where: {$0 == DaysArray[indexPath.row]})
                selectableIndexPath.append(String(selectindex!))
            }
            print(selectableIndexPath)
            daysCollectionView.reloadData()
        }
    }
}

//MARK:- UITableView Delegate & DataSource Method
extension RegistrationSetTimeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AddTimeNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "registrationAddTimeTableViewCell") as! registrationAddTimeTableViewCell
        cell.nameLbl.text = AddTimeNameArray[indexPath.row]
        cell.timeLbl.text = saveTime
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.timeSuperView.isHidden = false
    }
}


//MARK:- Date Picker
extension Date {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
       
        return formatter
        
    }()
    var formatted: String {
        return Date.formatter.string(from: self)
    }
    
    /*** Change Date Formatter ***/
    static let changeFormatter: DateFormatter = {
        let Changeformatter = DateFormatter()
        Changeformatter.dateFormat = "h:mm a"
        Changeformatter.amSymbol = "AM"
        Changeformatter.pmSymbol = "PM"
        return Changeformatter
    }()
    var changeformatted : String {
        return Date.changeFormatter.string(from: self)
    }

}



//MARK:- Call API
extension RegistrationSetTimeViewController {
    
    /*** UserDetail Info API ***/
    func userdetailInfoAPI(focusDays: String){
        self.showIndicator()
        DataService.sharedInstance.userDetailInfo(userId: GlobalVariabel.userId, occupation: typeSaveValue, focusDays: focusDays, setTime: saveTime, timeZone: timeZone) { (resultDict, errorMsg) in
            
            self.hideIndicator()
            
            print(resultDict as Any)
            
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool {
                    if status == true {
                        
                        UserDefaults.standard.removeObject(forKey: K_StepOne)
                        UserDefaults.standard.synchronize()
                        if let message = resultDict?["message"] as? String {
                            Toast.show(message: message, controller: self)
                        }
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationDescriptionViewController") as! RegistrationDescriptionViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else{
                         UserDefaults.standard.set("0", forKey: K_StepOne)
                        UserDefaults.standard.synchronize()
                        if let message = resultDict?["message"] as? String {
                            Toast.show(message: message, controller: self)
                        }
                    }
                }
            }
            else{
                UserDefaults.standard.set("0", forKey: K_StepOne)
                UserDefaults.standard.synchronize()
                self.alert(message: "Something went wrong", title: "")
                if let message = resultDict?["message"] as? String {
                    Toast.show(message: message, controller: self)
                }
            }
            
        }
    }
}
