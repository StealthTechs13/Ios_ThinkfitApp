//
//  FilterMyTaskViewController.swift
//  ThinkFit
//
//  Created by apple on 01/12/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit
import SideMenu

//MARK:- Set Protocol & Function
protocol FilterData {
    func filterData(filterCategory: String, checkView: String, filterValue: Bool)
}

protocol CallingHomeScreen {
    func dismissController()
}


class FilterMyTaskViewController: UIViewController {

    //Define Outlets
    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var buttonHideView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    //MARK:- Define Array
    var taskTypeArray = ["Important and Urgent","Important but not Urgent","Not Important but Urgent","Not Important and Not Urgent"]
    var colorArray = [#colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 0.18),#colorLiteral(red: 0.2196078431, green: 0.5176470588, blue: 0.9960784314, alpha: 0.06),#colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 0.18),#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 0.18)]
    
    var topColorArray = [#colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1),#colorLiteral(red: 0, green: 0.4156862745, blue: 0.9960784314, alpha: 1),#colorLiteral(red: 0.968627451, green: 0.4196078431, blue: 0.1098039216, alpha: 1),#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)]
    var bottomColorArray = [#colorLiteral(red: 1, green: 0.4509803922, blue: 0.5176470588, alpha: 1),#colorLiteral(red: 0, green: 0.6392156863, blue: 1, alpha: 1),#colorLiteral(red: 0.9803921569, green: 0.8509803922, blue: 0.3803921569, alpha: 1),#colorLiteral(red: 0.7960784314, green: 0.7960784314, blue: 0.7960784314, alpha: 1)]
    
    var dotcolorArray = [#colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1),#colorLiteral(red: 0.2196078431, green: 0.5176470588, blue: 0.9960784314, alpha: 1),#colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1),#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)]
    var dotColorImagesArray = ["icRedCircle", "icBlueCircle", "icYellowCircle", "icGreyCircle"]
    
    
    //MARK:- Define Variable
    var filterDelegate : FilterData!
    var categoryType = ""
    var selectedIndex = IndexPath()
    var selectedIndexStr = String()
    var dismissDelegate : CallingHomeScreen!
    var getStringValue = String()
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        sortButton.isUserInteractionEnabled = false
        buttonHideView.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationBarSetup()
    }
    
    //MARK:- NavigationSetup
    func navigationBarSetup(){
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "My Tasks"
        
    }
        
    //MARK:- UIButton Action
    
    /*** Sort Button Action ***/
    @IBAction func sortButtonAction(_ sender: Any) {
        if selectedIndexStr == ""{
            Toast.show(message: "please select category", controller: self)
        }
        else{
            self.filterDelegate.filterData(filterCategory: selectedIndexStr, checkView: "FilterMyTaskViewController", filterValue: true)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    /*** Cancel Button Action ***/
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismissDelegate.dismissController()
        self.dismiss(animated: true, completion: nil)
    }
}



//MARK:- UITableView Delegate & DataSource Method
extension FilterMyTaskViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskTypeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterMyTaskTableViewCell") as! FilterMyTaskTableViewCell
        cell.filterCategoryLabel.text = taskTypeArray[indexPath.row]
        cell.filterCategoryView.backgroundColor = colorArray[indexPath.row % colorArray.count]
        cell.filterDotImageView.image = UIImage(named: dotColorImagesArray[indexPath.row % dotColorImagesArray.count])
      
        
        if selectedIndex == indexPath {
            
            cell.filterCategoryView.insertHorizontalGradient(color1: bottomColorArray[indexPath.row % bottomColorArray.count], color2: topColorArray[indexPath.row % topColorArray.count])
            
            cell.filterCategoryView.clipsToBounds = true
            
        }
        else{
            
            cell.filterCategoryView.layer.sublayers = cell.filterCategoryView.layer.sublayers?.filter { theLayer in
                !theLayer.isKind(of: CAGradientLayer.classForCoder())
            }
            
            cell.filterCategoryView.backgroundColor = colorArray[indexPath.row % colorArray.count]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        print (selectedIndex.row+1)
        selectedIndexStr = String(selectedIndex.row+1)
        sortButton.isUserInteractionEnabled = true
        buttonHideView.isHidden = true
        filterTableView.reloadData()
        
    }
    
}
