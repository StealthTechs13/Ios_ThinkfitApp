//
//  AboutTheAppViewController.swift
//  ThinkFit
//
//  Created by apple on 21/09/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit
//import MMDrawerController
import SideMenu

class AboutTheAppViewController: UIViewController {
    
    //MARK:- Outltes
    @IBOutlet weak var aboutUsAppLbl: UILabel!
    
    
    //MARK:- Define Variables
    var comingSignUpScreen = true
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationSetup()
        aboutApplication()
    }
    
    //MARK:- SideMenu Setup
    private func setupSideMenu() {
        // Define the menus
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier:
            "menuLeftNavigationController") as? SideMenuNavigationController
    }
    
    
    //MARK:- Navigation Setup
    func navigationSetup(){
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = .clear
        
        title = "About The App"
        
        if comingSignUpScreen == true {
            /*** Navigation LeftBar Button ***/
            let leftBarButton = UIBarButtonItem(image: UIImage(named: "icBackArrowWhite"), style: .done, target: self, action: #selector(self.icMenuButtonAction))
            self.navigationItem.leftBarButtonItem  = leftBarButton
        }
        else{
            /*** Navigation LeftBar Button ***/
            let leftBarButton = UIBarButtonItem(image: UIImage(named: "icMenu"), style: .done, target: self, action: #selector(self.icMenuButtonAction))
            self.navigationItem.leftBarButtonItem  = leftBarButton
        }
        
        
    }
    
    //MARK:- Object Function Button Action
    @objc func icMenuButtonAction(){
        
        if comingSignUpScreen == true {
            self.navigationController?.popViewController(animated: true)
        }
        else{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "menuLeftNavigationController") as! SideMenuNavigationController
            nextViewController.leftSide = true
            self.present(nextViewController, animated:true, completion:nil)
        }
        
        
    }
    
}


//MARK:- Calling API'S
extension AboutTheAppViewController {
    
    /*** About Application API ***/
    func aboutApplication(){
        self.showIndicator()
        DataService.sharedInstance.aboutUs { (resulDict, errorMsg) in
            
            self.hideIndicator()
            
            print(resulDict as Any)
            
            if errorMsg == nil{
                if let status = resulDict?["status"] as? Bool{
                    if status == true {
                        if let result = resulDict?["result"] as? [NSDictionary]{
                            for aboutDetail in result {
                                if let content = aboutDetail["description"] as? String {
                                    let value = content.convertHtmlToAttributedStringWithCSS(font: UIFont(name: "Montserrat-Regular", size: 16), csscolor: "White", lineheight: 2, csstextalign: "Top")
                                    self.aboutUsAppLbl.attributedText = value
                                }
                            }
                        }
                    } else{
                        if let message = resulDict?["message"] as? String{
                            Toast.show(message: message, controller: self)
                        }
                    }
                }
            } else{
                self.alert(message: "Something went wrong", title: "")
               // Toast.show(message: "Something went wrong", controller: self)
            }
            
        }
    }
}
