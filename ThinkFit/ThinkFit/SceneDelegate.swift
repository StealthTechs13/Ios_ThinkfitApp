//
//  SceneDelegate.swift
//  ThinkFit
//
//  Created by stealth tech on 07/08/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        if let userId = UserDefaults.standard.value(forKey: K_UserId){
            if let userEmail = UserDefaults.standard.value(forKey: K_UserEmail){
                GlobalVariabel.userId = userId as! String
                GlobalVariabel.userEmail = userEmail as! String
                
                if let email_verified = UserDefaults.standard.value(forKey: K_EmailVerified){
                    if email_verified as! String == "0" {
                        //DispatchQueue.main.async {
                            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let rootVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                            let nvc:UINavigationController = mainStoryboard.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
                            nvc.viewControllers = [rootVC]
                            UIApplication.shared.windows.first?.rootViewController = nvc
                        //}
                        return
                    }
                    
                }
                
              if let step_one = UserDefaults.standard.value(forKey: K_StepOne){
                    
                    if step_one as! String == "0" {
                        //DispatchQueue.main.async {
                            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let rootVC = mainStoryboard.instantiateViewController(withIdentifier: "RegistrationSetTimeViewController") as! RegistrationSetTimeViewController
                            let nvc:UINavigationController = mainStoryboard.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
                            nvc.viewControllers = [rootVC]
                            UIApplication.shared.windows.first?.rootViewController = nvc
                        //}
                        return
                    }
                    
                }
                 if let step_two = UserDefaults.standard.value(forKey: K_StepTwo) {
                    if step_two as! String == "0"{
//                        DispatchQueue.main.async {
                            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let rootVC = mainStoryboard.instantiateViewController(withIdentifier: "RegistrationDepartmentViewController") as! RegistrationDepartmentViewController
                            let nvc:UINavigationController = mainStoryboard.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
                            nvc.viewControllers = [rootVC]
                            UIApplication.shared.windows.first?.rootViewController = nvc
                        return
                        }
                    //}
                    
                }
                 if let step_three = UserDefaults.standard.value(forKey: K_StepThree){
                    if step_three as! String == "0"{
                        
                        //DispatchQueue.main.async {
                            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let rootVC = mainStoryboard.instantiateViewController(withIdentifier: "RegistrationStrengthenQuestionViewController") as! RegistrationStrengthenQuestionViewController
                            let nvc:UINavigationController = mainStoryboard.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
                            nvc.viewControllers = [rootVC]
                            UIApplication.shared.windows.first?.rootViewController = nvc
                        return
                        //}
                        
                    }
                }
                
                if let step_four = UserDefaults.standard.value(forKey: K_StepFour){
                    if step_four as! String == "0"{
                        
//                        DispatchQueue.main.async {
                            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let rootVC = mainStoryboard.instantiateViewController(withIdentifier: "RegistrationQuestionClimbingViewController") as! RegistrationQuestionClimbingViewController
                            let nvc:UINavigationController = mainStoryboard.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
                            nvc.viewControllers = [rootVC]
                            UIApplication.shared.windows.first?.rootViewController = nvc
                        return
//                        }
                        
                    }
                }
                
                if let step_five = UserDefaults.standard.value(forKey: K_StepFive){
                    if step_five as! String == "0"{
                        
//                        DispatchQueue.main.async {
                            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let rootVC = mainStoryboard.instantiateViewController(withIdentifier: "RegistrationQuestionPushUpViewController") as! RegistrationQuestionPushUpViewController
                            let nvc:UINavigationController = mainStoryboard.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
                            nvc.viewControllers = [rootVC]
                            UIApplication.shared.windows.first?.rootViewController = nvc
                        return
                        //}
                        
                    }
                }
                
                if let step_six = UserDefaults.standard.value(forKey: K_StepSix){
                    if step_six as! String == "0"{
//                        DispatchQueue.main.async {
                            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let rootVC = mainStoryboard.instantiateViewController(withIdentifier: "RegistrationQuestionWorkstationViewController") as! RegistrationQuestionWorkstationViewController
                            let nvc:UINavigationController = mainStoryboard.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
                            nvc.viewControllers = [rootVC]
                            UIApplication.shared.windows.first?.rootViewController = nvc
                        return
                        //}
                        
                    }
                    else{
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let rootVC = mainStoryboard.instantiateViewController(withIdentifier: "HomeMyTaskViewController") as! HomeMyTaskViewController
                        let nvc:UINavigationController = mainStoryboard.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
                        nvc.viewControllers = [rootVC]
                        UIApplication.shared.windows.first?.rootViewController = nvc
                    }
                }
                else
                {
                   // DispatchQueue.main.async {
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let rootVC = mainStoryboard.instantiateViewController(withIdentifier: "HomeMyTaskViewController") as! HomeMyTaskViewController
                        let nvc:UINavigationController = mainStoryboard.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
                        nvc.viewControllers = [rootVC]
                        UIApplication.shared.windows.first?.rootViewController = nvc
                   // }
                }
            }
        }
        else{
            DispatchQueue.main.async {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let rootVC = mainStoryboard.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
                let nvc:UINavigationController = mainStoryboard.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
                nvc.viewControllers = [rootVC]
                UIApplication.shared.windows.first?.rootViewController = nvc
            }
        }
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {

        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

