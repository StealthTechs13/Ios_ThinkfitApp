//
//  Pager.swift
//  ThinkFit
//
//  Created by stealth tech on 17/08/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import Foundation
import UIKit

class PagerVC: UIPageViewController, UIScrollViewDelegate{

    lazy var subViewControllers:[UIViewController] = {
        return [
         UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OnboardDescriptionFistViewController") as!
         OnboardDescriptionFistViewController,UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OnboardDescriptionSecondViewController") as!
         OnboardDescriptionSecondViewController,UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OnboardDescriptionThirdViewController") as! OnboardDescriptionThirdViewController
        ]
    }()
    
    //MARK:- Define Variable:-
    var pagecontroller = UIPageControl()
    let scrollView = UIScrollView()
    
    //MARK:- ViewDidLoad:-
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        setViewControllerFromIndex(index: 0)
        self.delegate = self
        configurePageControll()
    }
    
    
    //MARK:- Configuration Controll:-
    func configurePageControll(){
        pagecontroller = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width, height: 20))
        pagecontroller.numberOfPages = subViewControllers.count
        pagecontroller.currentPage = 0
        pagecontroller.tintColor = UIColor.white
        pagecontroller.currentPageIndicatorTintColor = UIColor.white
        self.view.addSubview(pagecontroller)
    }

    func setViewControllerFromIndex(index:Int) {
        self.setViewControllers([subViewControllers[index]], direction: .forward, animated: true, completion: nil)
    }
    
}

//MARK:- PageViewController Delegate & DataSource Methods:-
extension PagerVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex:Int = subViewControllers.firstIndex(of: viewController)!
        if currentIndex <= 0 {
            return nil
        }
        return subViewControllers[currentIndex-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex:Int = subViewControllers.firstIndex(of: viewController)!
        if currentIndex >= subViewControllers.count-1 {
            return nil
        }
        return subViewControllers[currentIndex+1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pagecontroller = pageViewController.viewControllers![0]
        self.pagecontroller.currentPage = subViewControllers.firstIndex(of: pagecontroller)!
    }
    
}

