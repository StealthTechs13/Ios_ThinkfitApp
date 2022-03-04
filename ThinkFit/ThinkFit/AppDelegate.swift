//
//  AppDelegate.swift
//  ThinkFit
//
//  Created by stealth tech on 07/08/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SideMenu
import GoogleSignIn
import Firebase
import UserNotifications
import FirebaseMessaging
import RealmSwift


//@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UINavigationControllerDelegate, GIDSignInDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    
    //MARK:- Delegate Variables
    var window: UIWindow?
    var userDOB = ""
    var userGender = ""
    var intruptionTime = 0
    var recoveryTime = 5
    var renewalTime = 15
    var renewalNotimeCount = 0
    var renewalScreenVcTime = 0
    var ohIntruptionCount = 0
    var stopTimeToTired = 0
    var toDifficultTime = 0
    var noTime = 0
    var sevenTimeUpdateRecovery = 0
    var recoveryScreenVcTime = 0
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(Realm.Configuration.defaultConfiguration.fileURL as Any)
        
        UserDefaults.standard.removeObject(forKey: "invalidSavingTime")
        UserDefaults.standard.synchronize()
        
        //notificationAlertShow(message: "check Notification", type: "Notification")
        
        autoLoginHadling()
        //checkDateandCallApi()
        setupNavigationBar()
        FirebaseApp.configure()
        self.registerForPushNotifications() 
        Messaging.messaging().delegate = self
        
        
        //++++++++++Push Notifiacation++++++++++++++//
        if #available(iOS 13.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = result {
                GlobalVariabel.firebase_token = result.token
            }
        }
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        //++++++++++Push Notification++++++++++++//
        
        //MARK: IQKeyboard setup
        IQKeyboardManager.shared.enable = true
        GIDSignIn.sharedInstance().clientID = "289639096175-cn5r6jjsn9pg0hcmrqd6uskn56702gfo.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }
    
 
    func applicationDidBecomeActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
    }
    
    
    //MARK:- Notification Setup
    func registerForPushNotifications() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
                (granted, error) in
                print("Permission granted: \(granted)")
                
                guard granted else { return }
                self.getNotificationSettings()
            }
        } else {
            // Fallback on earlier versions
        }
        
        
    }
    
    func getNotificationSettings() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                print("Notification settings: \(settings)")
                guard settings.authorizationStatus == .authorized else { return }
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        GlobalVariabel.device_token = token
        Messaging.messaging().apnsToken = deviceToken as Data
            
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        GlobalVariabel.firebase_token = fcmToken
        UserDefaults.standard.set("\(fcmToken)", forKey: "token")
        UserDefaults.standard.synchronize()
        HomeMyTaskViewController().updateFCMToken(fcmToken: fcmToken)
    }
    
    @available(iOS 13.0, *)
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler( [.alert, .badge, .sound])
//
//        let userInfo = notification.request.content.userInfo
//
//        print("userInfo :--->",userInfo)
//
////        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertController.Style.alert)
////        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
////        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
//
//        notificationAlertShow(message: "check Notification", type: "Notification")
//
//
//    }
    
    // For push notification Delegate Method
    func userNotificationCenter( _ center: UNUserNotificationCenter,  willPresent notification: UNNotification, withCompletionHandler   completionHandler: @escaping (_ options:   UNNotificationPresentationOptions) -> Void) {
        
        
        let userInfo = notification.request.content.userInfo
        
        print("userInfo :--->",userInfo)
        
        completionHandler([.alert, .sound,.badge])
        
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        
        print("userInfo :--->",userInfo)

        if userInfo.count > 0 {
            
            if let getMsg = userInfo["alert"] as? NSDictionary{
                
                print(getMsg)
            }
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = mainStoryboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
            let nvc:UINavigationController = mainStoryboard.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
            nvc.viewControllers = [rootVC]
            UIApplication.shared.windows.first?.rootViewController = nvc
            
          //  notificationAlertShow(message: "Alert Show", type: "Notification")
            print("data come")
        }
        else{
            print("Data deint")
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
        print(userInfo)
        
      //  var type = String()
        
//        if application.applicationState == .active {
//            if let message = userInfo["title"] as? String {
//                if let type = userInfo["body"] as? String {
//                    notificationAlertShow(message: message, type: type)
//                }
//            }
//        }
//        else{
//            if userInfo.count > 0 {
//                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
//                let vc =  storyBoard.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
//                let navigationController = UINavigationController(rootViewController: vc!)
//                window?.rootViewController = navigationController
//                window?.makeKeyAndVisible()
//            }
//        }
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = mainStoryboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        let nvc:UINavigationController = mainStoryboard.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
        nvc.viewControllers = [rootVC]
        UIApplication.shared.windows.first?.rootViewController = nvc
        
        //        if let user = userInfo["type"]  as? String{
        //            type = user
        //        }
        
        //        if application.applicationState == .active {
        //
        //
        //            if type  == "SE" {
        //
        //                let title = userInfo["title"] as! String
        //                let message = userInfo["message"] as! String
        //
        //                notificationAlertShow(message: message, type: "SE")
        //
        //
        //
        //            }
        //            else if type  == "B"{
        //                UserDefaults.standard.set(true, forKey: "NotificationMark")
        //                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotificationMarkShow"), object: nil, userInfo: nil)
        //                let message = userInfo["message"] as! String
        //
        //                notificationAlertShow(message: message,type: "NO")
        //
        //
        //            }
        //            else if type  == "M"{
        //                UserDefaults.standard.set(true, forKey: "NotificationMark")
        //                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotificationMarkShow"), object: nil, userInfo: nil)
        //                let message = userInfo["message"] as! String
        //
        //                notificationAlertShow(message: message, type: "NO")
        //
        //            }
        //
        //
        //        }
        //        else {
        //
        //
        //            if type  == "SE" {
        //
        //                let title = userInfo["title"] as! String
        //                let message = userInfo["message"] as! String
        //
        //                notificationAlertShow(message: message, type: "SE")
        //
        //
        //
        //            }
        //            else if type  == "B"{
        //                UserDefaults.standard.set(true, forKey: "NotificationMark")
        //                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotificationMarkShow"), object: nil, userInfo: nil)
        //            }
        //            else if type  == "M"{
        //                UserDefaults.standard.set(true, forKey: "NotificationMark")
        //                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotificationMarkShow"), object: nil, userInfo: nil)
        //            }
        //
        //            UIApplication.shared.applicationIconBadgeNumber = 0
        //
        //        }
        
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func notificationAlertShow( message: String,  type: String){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let window = appDelegate?.window
        UserDefaults.standard.set(false, forKey: "userloginLang")
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc =  storyBoard.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
            let navigationController = UINavigationController(rootViewController: vc!)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
            
        }
        
        alertController.addAction(okAction)
        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        
    }
    
    
    //MARK:- Auth Login
    func autoLoginHadling(){
        
        if let userId = UserDefaults.standard.value(forKey: K_UserId){
            if let userEmail = UserDefaults.standard.value(forKey: K_UserEmail){
                GlobalVariabel.userId = userId as! String
                GlobalVariabel.userEmail = userEmail as! String
                
                if let email_verified = UserDefaults.standard.value(forKey: K_EmailVerified){
                    if email_verified as! String == "0" {
//                        DispatchQueue.main.async {
                            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let rootVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                            let nvc:UINavigationController = mainStoryboard.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
                            nvc.viewControllers = [rootVC]
                            UIApplication.shared.windows.first?.rootViewController = nvc
                        return
                        //}
                    }
                }
                
                if let step_one = UserDefaults.standard.value(forKey: K_StepOne) {
                    if step_one as! String == "0" {
//                        DispatchQueue.main.async {
                            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let rootVC = mainStoryboard.instantiateViewController(withIdentifier: "RegistrationSetTimeViewController") as! RegistrationSetTimeViewController
                            let nvc:UINavigationController = mainStoryboard.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
                            nvc.viewControllers = [rootVC]
                            UIApplication.shared.windows.first?.rootViewController = nvc
                        return
                        //}
                        
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
                        //}
                    }
                    
                }
                
                 if let step_three = UserDefaults.standard.value(forKey: K_StepThree){
                    if step_three as! String == "0"{
                        
//                        DispatchQueue.main.async {
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
                        //}
                        
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
                else {
//                    DispatchQueue.main.async {
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let rootVC = mainStoryboard.instantiateViewController(withIdentifier: "HomeMyTaskViewController") as! HomeMyTaskViewController
                        let nvc:UINavigationController = mainStoryboard.instantiateViewController(withIdentifier: "mainNav") as! UINavigationController
                        nvc.viewControllers = [rootVC]
                        UIApplication.shared.windows.first?.rootViewController = nvc
                    }
               // }
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
    }
    
    //MARK:- Google Login
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            
            return
        }
        
        let gplusapi = "https://www.googleapis.com/oauth2/v3/userinfo?access_token=\(user.authentication.accessToken!)"
        let url = NSURL(string: gplusapi)!
        
        
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        
        
        session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
            do {
                let userData = try JSONSerialization.jsonObject(with: data!, options:[]) as? [String:AnyObject]
                //  let picture = userData!["picture"] as? String
                let gender = userData!["gender"] as? String
                let dob = userData!["dob"] as? String
                
                self.userDOB = dob ?? ""
                self.userGender = gender ?? ""
            } catch {
                NSLog("Account Information could not be loaded")
            }
            
        }).resume()
        
        // Perform any operations on signed in user here.
        //        let userId = user.userID                  // For client-side use only!
        //        let idToken = user.authentication.idToken // Safe to send to the server
        //        let givenName = user.profile.givenName
        //        let familyName = user.profile.familyName
        //        let email = user.profile.email
        //        let fullName = user.profile.name
        
        let dataDict : [String: Any] = ["email" : user.profile.email ?? "", "name" : user.profile.name ?? "", "dob": userDOB, "gender": userGender]
        NotificationCenter.default.post(name: Notification.Name("GoogleSign"), object: nil, userInfo: dataDict)
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        
        print("User Disconect the Google Login")
        // Perform any operations when the user disconnects from app here.
        // ...
    } 
    
    
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        let state = application.applicationState
        switch state {
        case .inactive:
            print("Inactive")
            application.applicationIconBadgeNumber = application.applicationIconBadgeNumber + 1
            
        case .background:
            print("Background")
            // update badge count here
            application.applicationIconBadgeNumber = application.applicationIconBadgeNumber + 1
            
        case .active:
            print("Active")
            UIApplication.shared.applicationIconBadgeNumber = 0
            
        default:
            return
        }
    }
    
}



@available(iOS 13.0, *)
extension AppDelegate{
    func setupNavigationBar(){
        
        let navigationBarAppearace = UINavigationBar.appearance()
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        // Sets shadow (line below the bar) to a blank image
        UINavigationBar.appearance().shadowImage = UIImage()
        // Sets the translucent background color
        UINavigationBar.appearance().backgroundColor = .clear
        // Set translucent. (Default value is already true, so this can be removed if desired.)
        UINavigationBar.appearance().isTranslucent = true
        
        navigationBarAppearace.barTintColor = #colorLiteral(red: 0.03921568627, green: 0.07843137255, blue: 0.1137254902, alpha: 1)
        navigationBarAppearace.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 1)]
    }
    
}



@available(iOS 13.0, *)
extension AppDelegate {
    
    //Mark:- Calling API's
    func checkDateandCallApi(){
        
        if UserDefaults.standard.value(forKey: K_todayTomorrowDate) != nil {
            
            let today = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            let todayStr = dateFormatter.string(from: today)
            let oldDatestr = UserDefaults.standard.value(forKey: K_todayTomorrowDate) as? String ?? ""
            
            if oldDatestr == todayStr{
               //Do something here...
            }
            else{
                //UserDefaults.standard.setValue(todayStr, forKey: K_todayTomorrowDate)
                UserDefaults.standard.set(todayStr, forKey: K_todayTomorrowDate)
                UserDefaults.standard.removeObject(forKey: K_additional_Point)
                UserDefaults.standard.set(self.intruptionTime, forKey: K_IntruptionCount)
                UserDefaults.standard.setValue(renewalTime, forKey: K_Renewal_UpdateTime)
                UserDefaults.standard.set(recoveryTime, forKey: K_recoveryTimeUpdate)
                UserDefaults.standard.set(renewalNotimeCount, forKey: k_renewalNoTimeCount)
                UserDefaults.standard.set(self.renewalScreenVcTime, forKey: K_renewal_Count)
                UserDefaults.standard.set(self.recoveryScreenVcTime, forKey: K_Recovery_Count)
                UserDefaults.standard.set(self.ohIntruptionCount, forKey: K_ohohIntruption)
                UserDefaults.standard.set(0, forKey: k_Update_Intruption_Status_count)
                UserDefaults.standard.removeObject(forKey: k_Update_Intruption_Status_Name)
                UserDefaults.standard.set(stopTimeToTired, forKey: "stopTimeToTired")
                UserDefaults.standard.set(noTime, forKey: "noTime")
                UserDefaults.standard.set(toDifficultTime, forKey: "toDifficult")
                UserDefaults.standard.set(sevenTimeUpdateRecovery, forKey: k_sevenTime_Update_Recovery)
                UserDefaults.standard.synchronize()
            }
        }else{
            let today = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            let todayStr = dateFormatter.string(from: today)
            // let dateToday = dateFormatter.date(from: todayStr)
            //UserDefaults.standard.setValue(todayStr, forKey: K_todayTomorrowDate)
            UserDefaults.standard.set(todayStr, forKey: K_todayTomorrowDate)
            UserDefaults.standard.removeObject(forKey: K_additional_Point)
            UserDefaults.standard.set(self.intruptionTime, forKey: K_IntruptionCount)
            UserDefaults.standard.setValue(renewalTime, forKey: K_Renewal_UpdateTime)
            UserDefaults.standard.set(recoveryTime, forKey: K_recoveryTimeUpdate)
            UserDefaults.standard.set(renewalNotimeCount, forKey: k_renewalNoTimeCount)
            UserDefaults.standard.set(self.renewalScreenVcTime, forKey: K_renewal_Count)
            UserDefaults.standard.set(self.recoveryScreenVcTime, forKey: K_Recovery_Count)
            UserDefaults.standard.set(self.ohIntruptionCount, forKey: K_ohohIntruption)
            UserDefaults.standard.set(0, forKey: k_Update_Intruption_Status_count)
            UserDefaults.standard.removeObject(forKey: k_Update_Intruption_Status_Name)
            UserDefaults.standard.set(stopTimeToTired, forKey: "stopTimeToTired")
            UserDefaults.standard.set(noTime, forKey: "noTime")
            UserDefaults.standard.set(toDifficultTime, forKey: "toDifficult")
            UserDefaults.standard.set(sevenTimeUpdateRecovery, forKey: k_sevenTime_Update_Recovery)
            UserDefaults.standard.synchronize()
            
        }
    }
    
}
