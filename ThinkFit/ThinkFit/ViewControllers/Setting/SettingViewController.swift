//
//  SettingViewController.swift
//  ThinkFit
//
//  Created by apple on 24/12/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit
import SideMenu

class SettingViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var settingTableView: UITableView!
    @IBOutlet weak var navbarViewHeight: NSLayoutConstraint!
    
    
    //MARK:- Define Array
    var settingNameArray = ["Edit Workstation","Motivational Quotes"]
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    
    //MARK:- UIButton Actions
    @IBAction func sideMenuButtonAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "menuLeftNavigationController") as! SideMenuNavigationController
        nextViewController.leftSide = true
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    
    //MARK:- ViewWillLayout Subview
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
    
}


//MARK:- UITableView Delegate & DataSource Method
extension SettingViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell") as! SettingTableViewCell
        cell.settingNameLbl.text = settingNameArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditWorkStationQuoteViewController") as! EditWorkStationQuoteViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MotivationalQuoteViewController") as! MotivationalQuoteViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
