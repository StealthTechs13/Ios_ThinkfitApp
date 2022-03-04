//
//  NetworkManager.swift
//  ThinkFit
//
//  Created by apple on 22/10/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import Foundation
import Alamofire

typealias CompletionBlock           = (Bool, String?) -> Void
typealias CompletionBlockWithDict   = ([String:Any]?, String?) -> Void
typealias CompletionBlockWithArray  = ([Any]?, String?) -> Void
typealias CompletionBlockWithStatus  = (Bool?, String?) -> Void

class DataService: NSObject {
    
    static let sharedInstance = DataService()
    
    //MARK:- Create_Account
    func signUp(name: String, dob: String, emailId: String,deviceToken: String,password: String,gender: String,completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.SIGN_UP
        
        let params : Parameters = [
            
            "name": name,
            "dob": dob,
            "email":emailId,
            "device_token":deviceToken,
            "password": password,
            "gender": gender,
            "device_type" : "iOS"
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
        
    }
    
    //MARK:- Send_active_link
    func sendActiveLink(userID: String, emailId: String, completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.SEND_ACTIVE_LINK
        
        let params : Parameters = [
            
            "email":emailId,
            "user_id" : userID
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
        
    }
    
    //MARK:- Login
    func Login(emailId: String, password: String,devToken: String,completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.LOGIN
        
        let params : Parameters = [
            
            "email":emailId,
            "password" : password,
            "dev_token" : devToken
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    //MARK:- User_Detail_info
    func userDetailInfo(userId: String, occupation: String, focusDays: String,setTime: String, timeZone: String, completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.USER_DETAILED_INFO
        
        let params : Parameters = [
            
            "user_id": userId,
            "occupation": occupation,
            "focus_days": focusDays,
            "set_time": setTime,
            "time_zone" : timeZone
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    //MARK:- Question_One
    func questionOne(userId: String, questionOne: String, completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.QUESTION_ONE
        
        let params : Parameters = [
            
            "user_id": userId,
            "qn1_answer": questionOne,
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    //MARK:- Question_Two
    func questionTwo(userId: String, question: String, completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.QUESTION_TWO
        
        let params : Parameters = [
            
            "user_id": userId,
            "qn2_answer": question,
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    //MARK:- Question_Three
    func questionThree(userId: String, question: String, completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.QUESTION_THREE
        
        let params : Parameters = [
            
            "user_id": userId,
            "qn3_answer": question,
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    //MARK:- Question_Four
    func questionFour(userId: String, question: String, completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.QUESTION_FOUR
        
        let params : Parameters = [
            
            "user_id": userId,
            "qn4_answer": question,
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    //MARK:- WorkStationInfo
    func workstationInfo(userId: String, spaceavailable: String, matavailable: String, stairs: String, resistanceband: String, wearings: String ,completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.WORKSTATION_INFO
        
        let params : Parameters = [
            
            "user_id": userId,
            "space_available": spaceavailable,
            "mat_available":matavailable ,
            "stairs": stairs,
            "resistance_band": resistanceband,
            "wearings": wearings
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    //MARK:- WearningList
    func wearningList( completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.WEARNING_LIST
        
        
        AF.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    //MARK:- Save_task
    func saveTask(userId: String, task: String, need: String, physicalAction: String, category: String, colorCode: String,completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.SAVE_TASK
        
        let params : Parameters = [
            
            
            "user_id": userId,
            "task": task,
            "need": need,
            "physical_action": physicalAction,
            "category": category,
            "color_code" : colorCode
            
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    //MARK:- Delete_task
    func deleteTask(userId: String, taskId: String, completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.DELETE_TASK
        
        let params : Parameters = [
            
            "user_id": userId,
            "task_id": taskId
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    //MARK:- Show_task
    func showTask(userId: String, completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.SHOW_TASK
        
        let params : Parameters = [
            
            "user_id": userId
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    //MARK:- About_Us
    func aboutUs( completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.ABOUT_US_APP
        
        
        AF.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    //MARK:- Privacy_policy
    func privacyPolicy( completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.PRIVACY_POLICY
        
        
        AF.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    //MARK:- Social_login
    func socialLogin(email: String, login_type: String,device_type: String,devToken: String,dob: String, name: String, gender: String,completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.SOCIAL_LOGIN
        
        let params : Parameters = [
            
            "email": email,
            "login_type": login_type,
            "device_type": device_type,
            "dev_token" : devToken,
            "dob":dob,
            "name":name,
            "gender":gender
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    
    //MARK:- Social_login Apple
    func socialLoginApple(email: String, login_type: String,device_type: String,devToken: String,name: String, apple_Token:String,completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.SOCIAL_LOGIN_APPLE
        
        let params : Parameters = [
            
            "email": email,
            "login_type": login_type,
            "device_type": device_type,
            "dev_token" : devToken,
            "dob":"",
            "name":name,
            "gender":"",
            "apple_token":apple_Token
            
        ]
     
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    
    
    //MARK:- Contact_Us_Enquiry
    func contactUSEnquiry(userId: String, comment: String,name: String ,email: String,completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.CONTACT_US_ENQUIRY
        
        let params : Parameters = [
            
            "user_id": userId,
            "comment":comment,
            "name" : name,
            "email" : email
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    //MARK:- User_Total_Point
    func userTotalPoint(userId: String, completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.USER_TOTAL_POINT
        
        let params : Parameters = [
            
            "user_id": userId,
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    //MARK:- Focus_Days
    func focusDays(userId: String, description: String, type: String ,completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.FOCUS_DAYS
        
        let params : Parameters = [
            
            "user_id": userId,
            "description": description,
            "type": type
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    //MARK:- Notification History
    func notificationHistory(userId: String ,completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.NOTIFICATION_HISTORY
        
        let params : Parameters = [
            "user_id": userId,
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    //MARK:- Single_Delete_Notification
    func singleDeleteNotification(userId: String , notification_id : String, completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.SINGLE_DELETE_NOTIFICATION
        
        let params : Parameters = [
            "user_id": userId,
            "notification_id" : notification_id
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    //MARK:- Multiple_Delete_Notification
    func multipleDeleteNotification(userId: String , completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.MULTIPLE_DELETE_NOTIFICATION
        
        let params : Parameters = [
            "user_id": userId,
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    //MARK:- Update_notification_Status
    func updateNotificationStatus(userId: String, notification_status : String , completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.UPDATE_NOTIFICATION_STATUS
        
        let params : Parameters = [
            
            "user_id": userId,
            "notification_status" : notification_status
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    //MARK:- Update_additional_point
    func additionalPoint(userId: String, exercise : String , point: String, completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.ADDITIONAL_POINT
        
        let params : Parameters = [
            
            "user_id": userId,
            "exercise": exercise,
            "points": point
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    //MARK:- Forgot Password
    func forgotPassword(emailID : String, completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.FORGOT_PASSWORD
        
        let params : Parameters = [
            
            "email": emailID
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    //MARK:- Intruption_Other_feedback
    func intruptionOtherFeedback(userid : String, otherdescription: String, completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.INTRUPTION_OTHER_FEEDBACK
        
        let params : Parameters = [
            
            "user_id": userid,
            "description" : otherdescription
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    //MARK:- Renewal_Period_exersice 
    func showRenewalPeriodExersise(userid : String, completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.RENEWAL_PERIOD_EXERSICES
        
        let params : Parameters = [
            
            "user_id": userid,
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    //MARK:- ReCovery-SitPushUp
    func sitPushUp(userid : String, completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.RECOVERY_SIT_PUSHUP
        
        let params : Parameters = [
            
            "user_id": userid,
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    //MARK:- Show_All_Equipment
    func showAllEquipment(userid : String, completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.SHOW_ALL_EQUIPMENT
        
        let params : Parameters = [
            
            "user_id": userid
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    //MARK:- User_WorkStation_survey
    func userWorkStationSurvey(userid : String, question_id : String, wearning_type : String , completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.USER_WORKSTATION_SURVEY
        
        let params : Parameters = [
            
            "user_id": userid,
            "question_id" : question_id,
            "wearing_type" : wearning_type
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    //MARK:- Registration_Equipments
    func registrationEquipments(userid : String, completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.REGISTRATION_WORKSTATION_EQUIPMENTS
        
        let params : Parameters = [
            
            "user_id": userid,
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    //MARK:- Intruption_type
    func intruption_type(userid : String, completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.INTRUPTION_TYPE
        
        let params : Parameters = [
            
            "user_id": userid,
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    //MARK:- new_workStation_Survey
    func new_workStation_survey(userid : String, completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.NEW_WORKSTATION_SURVEY
        
        let params : Parameters = [
            
            "user_id": userid,
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    
    //MARK:- FitnessLevelUpdate
    func fitnessLevelUpdate(userid : String, fitnessLevel: String, completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.FITNESS_LEVEL_UPDATE
        
        let params : Parameters = [
            
            "user_id": userid,
            "fitness_level" : fitnessLevel
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    //MARK:- IntruptionBaseQuoteListing
    func intruptionBaseQuoteListing(userid : String, completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.INTRUPTION_BASED_MOTIVATION_QUOTE_LIST
        
        let params : Parameters = [
            
            "user_id": userid,
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    //MARK:- User_Task_Complition_Status
    func userTaskComplitionStatus(userid : String,taskId: String ,completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.USER_TASK_COMPLITION_STATUS
        
        let params : Parameters = [
            
            "user_id": userid,
            "task_id" : taskId
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    //MARK:- recovry_exercise_List_User_Based
    func recoveryExcersiceListUserBased(userid : String ,completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.RECOVERY_USER_BASED_EXERCISE_LIST
        
        let params : Parameters = [
            
            "user_id": userid,
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    //MARK:- Motivation_Intruption_list
    func motivationIntruptionList(userid : String ,completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.MOTIVATION_INTRUPTION_LIST
        
        let params : Parameters = [
            
            "user_id": userid,
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    //MARK:- Submit_Motivation_Intruption
    func submitMotivationIntruption(userid : String, exerciseId : String, interruptionTypes : String ,completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.SUBMIT_MOTIVATION_INTRUPTION
        
        let params : Parameters = [
            
            "user_id": userid,
            "exercise_id" : exerciseId,
            "interruption_types" : interruptionTypes
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    //MARK:- Update_Intruption_Status
    func updateIntruptionStatus(userid : String, interruptionName : String ,completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.UPDATE_INTRUPTION_STATUS
        
        let params : Parameters = [
            
            "user_id": userid,
            "interruption_name" : interruptionName,
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    //MARK:- Update_device_token
    func updateDevicetoken(userid : String, deviceToken : String ,completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.DEVICE_TOKEN_UPDATE
        
        let params : Parameters = [
            
            "user_id": userid,
            "dev_token" : deviceToken
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    //MARK:- update_task_status
    func updateTaskStatus(userid : String, taskID : String ,completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.TASK_STATUS_UPDATE
        
        let params : Parameters = [
            
            "user_id": userid,
            "task_id" : taskID
            
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    //MARK:- Show_all_Coupon
    func showAllCoupon(completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.SHOW_ALL_COUPON
        
        AF.request(url, method: .post, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
    //MARK:- Purchase_Coupon
    func purchaseCoupon(userid : String, couponid : String ,buyPrize: String ,completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.PURCHASE_COUPON
        
        let params : Parameters = [
            "user_id": userid,
            "coupon_id" : couponid,
            "buy_prize" : buyPrize
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    //MARK:- Show_Purchase_coupon_list
    func showPurchaseCoupon(userid : String ,completionHandler: @escaping CompletionBlockWithDict) {
        
        let url = API.SHOW_ALL_PURCHASE_COUPON
        
        let params : Parameters = [
            "user_id": userid
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            debugPrint(response)
            
            switch response.result {
                
            case .success(let value):
                
                if let successItem = value as? [String: Any] {
                    completionHandler(successItem,nil)
                }
                break
            case .failure(let error):
                
                completionHandler(nil,error.localizedDescription)
                
                break
            }
        }
    }
    
    
}
