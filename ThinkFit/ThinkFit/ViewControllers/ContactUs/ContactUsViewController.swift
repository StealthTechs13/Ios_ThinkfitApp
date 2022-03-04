//
//  ContactUsViewController.swift
//  ThinkFit
//
//  Created by apple on 21/09/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit
import SideMenu

class ContactUsViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var navigationBarViewHeight: NSLayoutConstraint!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var navigationLeftButton: UIButton!
    @IBOutlet weak var textViewHeightConstraints: NSLayoutConstraint!
    
    
    //MARK:- Define Variable
    var previousPosition:CGRect = CGRect.zero
    
    
    //MARK:- Define ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        commentTextView.delegate = self
        commentTextView.text = "Type here your comments"
        commentTextView.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Setup SideMenu
    private func setupSideMenu() {
        // Define the menus
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier:
                                                                                                        "menuLeftNavigationController") as? SideMenuNavigationController
    }
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationSetup()
    }
    
    
    //MARK:- Navigation Setup
    func navigationSetup(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.isTranslucent = true
        title = "Contact Us"
        
        /*** Navigation LeftBar Button ***/
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "icMenu"), style: .done, target: self, action: #selector(self.icMenuButtonAction))
        self.navigationItem.leftBarButtonItem  = leftBarButton
    }
    
    //MARK:- View_Will_Layout_SubView
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
    
    //MARK:- Object Function Button Action
    @objc func icMenuButtonAction(){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "menuLeftNavigationController") as! SideMenuNavigationController
        nextViewController.leftSide = true
        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    
    //MARK:- UIButton Actions
    
    /*** Navigation Left Button Action ***/
    @IBAction func navigationLeftButtonAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "menuLeftNavigationController") as! SideMenuNavigationController
        nextViewController.leftSide = true
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    /*** Submit Button Action ***/
    @IBAction func submitButtonAction(_ sender: Any) {
        if commentTextView.text == "Type here your comments" {
            Toast.show(message: "Please add comments", controller: self)
        }
        else{
            contactUsEnquiry()
        }
        
    }
    
}


//MARK:- UITextView Delegate Method
extension ContactUsViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Type here your comments"{
            textView.text = ""
            
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""{
            commentTextView.text = "Type here your comments"
        }
    }
    
  
    func textViewDidChange(_ textView: UITextView) {
        textViewHeightConstraints.constant = self.commentTextView.contentSize.height
    }
}



//MARK:- API's Calling
extension ContactUsViewController {
    
    /*** Contact Us API ***/
    func contactUsEnquiry(){
        
        self.showIndicator()
        DataService.sharedInstance.contactUSEnquiry(userId: GlobalVariabel.userId,comment: commentTextView.text!, name: GlobalVariabel.userName , email: GlobalVariabel.userEmail ) { (resultDict, errorMsg) in
            
            self.hideIndicator()
            
            if errorMsg == nil{
                
                if let status = resultDict?["status"] as? Bool {
                    if status == true {
                        if let message = resultDict?["message"] as? String {
                            Toast.show(message: message, controller: self)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.800) {
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeMyTaskViewController") as! HomeMyTaskViewController
                                self.navigationController?.pushViewController(vc, animated: true)
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
                if let message = resultDict?["message"] as? String{
                    Toast.show(message: message, controller: self)
                }
            }
            
        }
    }
}
