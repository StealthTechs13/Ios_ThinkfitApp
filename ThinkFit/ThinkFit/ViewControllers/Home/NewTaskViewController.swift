//
// NewTaskViewController.swift
// ThinkFit
//
// Created by apple on 11/09/20.
// Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit


protocol CallingShowingTaskAPI {
    func dismissController()
}

class NewTaskViewController: UIViewController {
    
    //MARK:- Outltes
    @IBOutlet var superView: UIView!
    @IBOutlet weak var childView: UIView!
    @IBOutlet weak var bottomNoticeView: UIView!
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var enterNeedTextField: UITextField!
    @IBOutlet weak var physicalActionTextfield: UITextField!
    @IBOutlet weak var categoryTypeTableView: UITableView!
    @IBOutlet weak var bottomNoticeLbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var taskNameTextView: UITextView!
    @IBOutlet weak var enterNeedTextView: UITextView!
    @IBOutlet weak var physicalActionTextView: UITextView!
    
    
    //MARK:- Define Outlets
    var categoryType = ""
    var selectedIndex = IndexPath()
    var selectedIndexStr = String()
    var colorHexaValue = String()
    var showingTaskList = [saveTaskData]()
    var dismissDelegate : CallingShowingTaskAPI!
    let gradient = CAGradientLayer()
    var taskTypeArray = ["Important and Urgent","Important but not Urgent","Not Important but Urgent","Not Important and Not Urgent"]
    var colorArray = [#colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 0.18),#colorLiteral(red: 0.2196078431, green: 0.5176470588, blue: 0.9960784314, alpha: 0.06),#colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 0.18),#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 0.18)]
    var hexaColor = ["D0021B","3884FE","F5A623","9B9B9B"]
    var topColorArray = [#colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1),#colorLiteral(red: 0, green: 0.4156862745, blue: 0.9960784314, alpha: 1),#colorLiteral(red: 0.968627451, green: 0.4196078431, blue: 0.1098039216, alpha: 1),#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)]
    var bottomColorArray = [#colorLiteral(red: 1, green: 0.4509803922, blue: 0.5176470588, alpha: 1),#colorLiteral(red: 0, green: 0.6392156863, blue: 1, alpha: 1),#colorLiteral(red: 0.9803921569, green: 0.8509803922, blue: 0.3803921569, alpha: 1),#colorLiteral(red: 0.7960784314, green: 0.7960784314, blue: 0.7960784314, alpha: 1)]
    
    var dotcolorArray = [#colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1),#colorLiteral(red: 0.2196078431, green: 0.5176470588, blue: 0.9960784314, alpha: 1),#colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1),#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)]
    var dotColorImagesArray = ["icRedCircle", "icBlueCircle", "icYellowCircle", "icGreyCircle"]
    var selectedColor = Int()
    var colourValue = String()
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomView.isHidden = true
        bottomNoticeView.isHidden = true
        taskNameTextView.delegate = self
        enterNeedTextView.delegate = self
        physicalActionTextView.delegate = self
        taskNameTextView.text = "Enter Task Name"
        taskNameTextView.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)
        enterNeedTextView.text = "Enter Description"
        enterNeedTextView.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)
        physicalActionTextView.text = "Enter Description"
        physicalActionTextView.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)
       // taskNameTextField.delegate = self
       // enterNeedTextField.delegate = self
       // physicalActionTextfield.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationBarSetup()
        bottomSheetLblSetUp()
        
    }
    
    
    //MARK:- Bottom_Sheet Label Specific Color Setup
    func bottomSheetLblSetUp(){
        let string = NSMutableAttributedString(string: "The matrix, also known as Eisenhower’s Urgent-Important Principle, distinguishes between importance and urgency: \n \n Important responsibilities contribute to the achievement of your goals. \n \n Urgent responsibilities require immediate attention. These activities are often tightly linked to the accomplishment of someone else’s goal. Not dealing with these issues will cause immediate consequences. \n \n More info here \n \n http://www.planetofsuccess.com/blog/2015/stephen-coveys-time-management-matrix-explained/")
        string.setColorForText("The matrix, also known as Eisenhower’s Urgent-Important Principle, distinguishes between importance and urgency: \n \n Important responsibilities contribute to the achievement of your goals. \n \n Urgent responsibilities require immediate attention. These activities are often tightly linked to the accomplishment of someone else’s goal. Not dealing with these issues will cause immediate consequences. \n \n More info here \n \n", with: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6))
        string.setColorForText("http://www.planetofsuccess.com/blog/2015/stephen-coveys-time-management-matrix-explained/", with: #colorLiteral(red: 0.02745098039, green: 0.3176470588, blue: 0.6980392157, alpha: 1))
        bottomNoticeLbl.attributedText = string
    }
    
    //MARK:- Navigation Bar Setup
    func navigationBarSetup(){
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "New Task"
    }


    //MARK:- UIButton Action
    
    /*** Save Button Action ***/
    @IBAction func saveButtonAction(_ sender: Any) {
        
        if taskNameTextView.text == "Enter Task Name" {
            Toast.show(message: "Please enter your task", controller: self)
        }
        else if enterNeedTextView.text == "Enter Description" {
            Toast.show(message: "please enter valid description", controller: self)
        }
        else if physicalActionTextView.text == "Enter Description"{
            Toast.show(message: "Please enter physical action", controller: self)
        }
        else if selectedIndex.count == 0 {
            Toast.show(message: "Please select your work catogery", controller: self)
        }
        else{
            addTaskAPI()
        }
    }
    
    /*** Cancel Button Action ***/
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*** Show Bottom Sheet Button Action ***/
    @IBAction func bottomNoticeContinueButton(_ sender: Any) {
        bottomNoticeView.isHidden = true
        bottomView.isHidden = true
    }
    
    /*** Bottom Sheet Link Button Action ***/
    @IBAction func bottomSheetLinkButtonAction(_ sender: Any) {
        if let url = URL(string: "http://www.planetofsuccess.com/blog/2015/stephen-coveys-time-management-matrix-explained/") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    /*** Information Button Action ***/
    @IBAction func informationButtonAction(_ sender: Any) {
        bottomView.isHidden = false
        bottomNoticeView.isHidden = false
        taskNameTextView.resignFirstResponder()
        enterNeedTextView.resignFirstResponder()
        physicalActionTextView.resignFirstResponder()
       // physicalActionTextfield.resignFirstResponder()
    }
    
    
}


//MARK:- UITableView Delegate & DataSource Method
extension NewTaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskTypeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewTaskTableViewCell") as! NewTaskTableViewCell
        cell.taskTypeLbl.text = taskTypeArray[indexPath.row]
        if selectedColor == indexPath.row{
            checkColourCode(hexaColor[indexPath.row])
        }
        cell.taskTypeBackgroundView.backgroundColor = colorArray[indexPath.row % colorArray.count]
        cell.taskDotImageView.image = UIImage(named: dotColorImagesArray[indexPath.row % dotColorImagesArray.count])
      
        
        if selectedIndex == indexPath {
            
            cell.taskTypeBackgroundView.insertHorizontalGradient(color1: bottomColorArray[indexPath.row % bottomColorArray.count], color2: topColorArray[indexPath.row % topColorArray.count])
            
            cell.taskTypeBackgroundView.clipsToBounds = true
            
        }
        else{
            //cell.taskTypeBackgroundView.layer.sublayers = nil
            
            cell.taskTypeBackgroundView.layer.sublayers = cell.taskTypeBackgroundView.layer.sublayers?.filter { theLayer in
                !theLayer.isKind(of: CAGradientLayer.classForCoder())
            }
            
            cell.taskTypeBackgroundView.backgroundColor = colorArray[indexPath.row % colorArray.count]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndex = indexPath
        selectedColor = indexPath.row
        print (selectedIndex.row+1)
        selectedIndexStr = String(selectedIndex.row+1)
        
        categoryTypeTableView.reloadData()
    }
    
    
    func checkColourCode(_ colourLiteral : String){
        print(colourLiteral)
        colourValue = colourLiteral
       
    }
    
    
}


//MARK:- API's Calling
extension NewTaskViewController {
    
    /*** Add Task API ***/
    func addTaskAPI(){
        self.showIndicator()
        DataService.sharedInstance.saveTask(userId: GlobalVariabel.userId, task: taskNameTextView.text ?? "", need: enterNeedTextView.text ?? "", physicalAction: physicalActionTextView.text ?? "", category: selectedIndexStr, colorCode: colourValue) { (resultDict, errorMsg) in
            self.hideIndicator()
            
            if errorMsg == nil {
                
                if let status = resultDict?["status"] as? Bool {
                    if status == true {
                        if let message = resultDict?["message"] as? String{
                            Toast.show(message: message, controller: self)
                        }
                        
                        self.dismissDelegate?.dismissController()
                        self.dismiss(animated: true, completion: nil)
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
                if let message = resultDict?["message"] as? String {
                    Toast.show(message: message, controller: self)
                }
            }
        }
    }
}


//MARK:- TextView Delegate Method
extension NewTaskViewController: UITextViewDelegate {
    
    /*** TextView Did Begin Editing ***/
    func textViewDidBeginEditing(_ textView: UITextView) {
        if taskNameTextView.text == "Enter Task Name"{
            taskNameTextView.text = ""
            taskNameTextView.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            taskNameTextView.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
           
        }
        if enterNeedTextView.text == "Enter Description"{
            enterNeedTextView.text = ""
            enterNeedTextView.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            enterNeedTextView.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
           
        }
        if physicalActionTextView.text == "Enter Description"{
            physicalActionTextView.text = ""
            physicalActionTextView.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            physicalActionTextView.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
           
        }
    }
    
    /*** Should Change Character ***/
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
      //  let characterSet = CharacterSet.letters
        
        if range.location == 0 && textView == taskNameTextView {
            
            if text == " " { // prevent space on first character
                return false
            }
            if text == " " { return true } // now allowing space between name
            
            if textView.text?.last == " " && text == " " { // allowed only single space
                return false
            }
//            if text.rangeOfCharacter(from: characterSet.inverted) != nil {
//                return false
//            }
            return range.location < 100
            
            
        }
         
        if range.location == 0 && textView == enterNeedTextView {
            
            if text == " " { // prevent space on first character
                return false
            }
            if text == " " { return true } // now allowing space between name
            
            if textView.text?.last == " " && text == " " { // allowed only single space
                return false
            }
//            if text.rangeOfCharacter(from: characterSet.inverted) != nil {
//                return false
//            }
            
             return range.location < 100
            
            
        }
        
        if range.location == 0 &&  textView == physicalActionTextView {
            
            if text == " " { // prevent space on first character
                return false
            }
            if text == " " { return true } // now allowing space between name
            
            if textView.text?.last == " " && text == " " { // allowed only single space
                return false
            }
//            if text.rangeOfCharacter(from: characterSet.inverted) != nil {
//                return false
//            }
            
            return range.location < 100
        }
        if (textView.textInputMode?.primaryLanguage == "emoji"){
            return true
        }
        
        return true
    }
    
    /*** TextView Did End Editing ***/
    func textViewDidEndEditing(_ textView: UITextView) {

        if taskNameTextView.text == ""{
            taskNameTextView.text = "Enter Task Name"
            taskNameTextView.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)
            taskNameTextView.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)

        }
        if enterNeedTextView.text == ""{
            enterNeedTextView.text = "Enter Description"
            enterNeedTextView.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)
            enterNeedTextView.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)

        }
        if physicalActionTextView.text == ""{
            physicalActionTextView.text = "Enter Description"
            physicalActionTextView.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)
            physicalActionTextView.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4)
        }

    }
}
