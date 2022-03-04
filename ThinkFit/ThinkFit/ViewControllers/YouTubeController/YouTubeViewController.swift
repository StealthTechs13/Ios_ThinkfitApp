//
//  YouTubeViewController.swift
//  ThinkFit
//
//  Created by apple on 25/01/21.
//  Copyright © 2021 Harinder Rana. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView
import WebKit

class YouTubeViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var myPlayerView: WKWebView!
    @IBOutlet weak var navbarViewHeight: NSLayoutConstraint!
    
    
    //MARK:- Define Variable
    var youtubeId = ""
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = verifyUrl(urlString: youtubeId)
        print(url)
        let fileUrl = URL(string: youtubeId)!
        if url == true {
            let request:URLRequest = URLRequest(url: fileUrl)
            myPlayerView.load(request)
        }
        else{
            alert(message: "This url is not Valid", title: "")
        }
       
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil)
        //  Do any additional setup after loading the view.
    }
    
    
    //MARK:- Verifiy string into URL
    func verifyUrl (urlString: String?) -> Bool {
       if let urlString = urlString {
           if let url = NSURL(string: urlString) {
               return UIApplication.shared.canOpenURL(url as URL)
           }
           
       }
       return false
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
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        
        //MARK:- Navigation LeftBar Button
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "icCross"), style: .done, target: self, action: #selector(self.icMenuButtonAction))
        self.navigationItem.leftBarButtonItem = leftBarButton
        
    }
    
    //MARK:- UIButton Actions
    @objc func icMenuButtonAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func icCrossButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
 
