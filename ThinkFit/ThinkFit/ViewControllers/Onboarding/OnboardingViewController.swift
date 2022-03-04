//
//  OnboardingViewController.swift
//  ThinkFit
//
//  Created by stealth tech on 17/08/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController{
    
    
    //MARK:- Outlets
    @IBOutlet weak var onbaordingCollectionView: UICollectionView!
    @IBOutlet weak var onbaordHeaderLbl: UILabel!
    @IBOutlet weak var onboardDescribetextView: UITextView!
    @IBOutlet weak var onboardingImageSuperView: UIView!
    
    @IBOutlet weak var pager: UIPageControl!
    
    //MARK:- Define Variable
    var testPVC:PagerVC!
    
    
    //MARK:- Define Array
    var sliderIMageArray = ["icIntroVectorImg","icIntroVectorImg","icIntroVectorImg"]
    var sliderHeader = ["Welcome to ThinkFit!","An integrated approach","Enjoy the rest of your life"]
    var sliderheaderDescription = ["The first integrated approach to productivity and wellness! You are going to access a productivity tool called Focus Time: an advanced timeboxing technique with a Virtual Coach to help you improve over time. Inspired by scientific studies and great Authors and Experts like David Allen (Gettings Thing Done), Rory Vaden (Procrastinate on Purpose), Stephen Covey ( The 7 Habits of Highly Effective People) and many, many others.","You are going to include physical movements into your daily routine with fewer efforts with Active Recovery periods, still challenging your limits to keep you motivated. Collect FitPoints and receive coupons, participate to challenges and receive personalized offers exclusive for “Think-Fitters” like you.","Have Renewal Periods replenish your mental energy during the day, reducing your stress and keeping you “all in” when needed, mastering your to-do list and still being able to enjoy your life at the end of the day."]
    var textColorChangeValue = ["Focus Time","Active Recovery","Renewal Periods"]
    
    
    //MARK:- Outlets:-
    @IBOutlet weak var pageContainerView: UIView!
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "PagerVC" {
//            if segue.destination.isKind(of: PagerVC.self) {
//                testPVC = segue.destination as? PagerVC
//            }
//        }
//    }
        
    //MARK:- ViewDidLOad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewRoundSetup()
        onbaordHeaderLbl.text = sliderHeader[0]
        onboardDescribetextView.text = sliderheaderDescription[0]
        
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            let statusBarFrame = window?.windowScene?.statusBarManager?.statusBarFrame
            let statusBarView = UIView(frame: statusBarFrame!)
            self.view.addSubview(statusBarView)
            statusBarView.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.07843137255, blue: 0.1137254902, alpha: 1)
            self.navigationController?.navigationBar.isTranslucent = false
        } else {
            //Below iOS13
            let statusBarFrame = UIApplication.shared.statusBarFrame
            let statusBarView = UIView(frame: statusBarFrame)
            self.view.addSubview(statusBarView)
            statusBarView.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.07843137255, blue: 0.1137254902, alpha: 1)
            
        }
       
       
        // Do any additional setup after loading the view.
        
    }
    
    //MARK:- ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
//        onbaordingCollectionView.delegate = self
//        onbaordingCollectionView.dataSource = self
//        onbaordingCollectionView.reloadData()
      // onbaordingCollectionView.reloadData()
        //onboardDescribetextView.isUserInteractionEnabled = false
        onboardDescribetextView.isEditable = false
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        onbaordingCollectionView.delegate = self
        onbaordingCollectionView.dataSource = self
        onbaordingCollectionView.reloadData()
        
    }
    
    
    //MARK:- View Round Setup
    func viewRoundSetup(){
        
        onboardingImageSuperView.layer.cornerRadius = 46
        onboardingImageSuperView.layer.masksToBounds = true
        onboardingImageSuperView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        //onboardingImageSuperView.layer.maskedCorners = [.layerMaxXMaxYCorner,.]
        
    }
    
    
    
    //MARK:- UIButton Actions:-
    @IBAction func skipBtnPressed(_ sender: Any) {
       let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateAccountViewController") as! CreateAccountViewController
       self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
       self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateAccountViewController") as! CreateAccountViewController
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        UserDefaults.standard.set("true", forKey: K_Onboarding_Screen)
        UserDefaults.standard.synchronize()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
 

//MARK:- CollectionView Delegate & DataSource Method
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: onbaordingCollectionView.bounds.width , height: 300)
    }
    
    // UIScreen.main.bounds.width
    func numberOfSections(in collectionView: UICollectionView) -> Int {
          return 1
      }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let count = sliderHeader.count //tutorial.ImgArray.count
        pager.numberOfPages = count
        pager.isHidden = !(count > 1)
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        
        cell.pageImage.image = UIImage(named: sliderIMageArray[indexPath.row])
        
        return cell
        
    }
    
    
     func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

         pager?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
     }

     func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

         pager?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
     }
     
    
     func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

         let visibleIndex = Int(targetContentOffset.pointee.x / onbaordingCollectionView.frame.width)
         print(visibleIndex)
         getIndex(visibleIndex)

     }
    
    //MARK:- getting IndexValue for array string
    func getIndex(_ Index:Int) {
        
        onbaordHeaderLbl.text = sliderHeader[Index]
        
        let longestWordRange = (sliderheaderDescription[Index] as NSString).range(of: textColorChangeValue[Index])
        let attributedString = NSMutableAttributedString(string: sliderheaderDescription[Index], attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)])
        attributedString.setAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor(cgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))], range: longestWordRange)
        
        let secondWordRange = (sliderheaderDescription[Index] as NSString).range(of: "Think-Fitters")
        let thirdWordRange = (sliderheaderDescription[Index] as NSString).range(of: "FitPoints")
        attributedString.setAttributes([NSAttributedString.Key.font : UIFont.italicSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor(cgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))], range: secondWordRange)
        attributedString.setAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor(cgColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))], range: thirdWordRange)
            
        onboardDescribetextView.attributedText = attributedString
        onboardDescribetextView.textAlignment = .center
//        onbaordingCollectionView.reloadData()
        
    }
    
}

extension UICollectionView {
    func scrollToNextItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x + self.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }
    func moveToFrame(contentOffset : CGFloat) {
        self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
    }
}


