//
//  API.swift
//  ThinkFit
//
//  Created by apple on 22/10/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import Foundation

//MARK:- API's URL
struct API {
    
    static let BASE_URL = "http://18.219.104.111:3000/api/"
    static let IMAGE_BASE_URL = "http://18.219.104.111/api/src/public/coupon_logo/"
   
    
    //MARK:- All API's Attached URL
    
    static let SIGN_UP = API.BASE_URL+"signup"
    static let SEND_ACTIVE_LINK = API.BASE_URL+"active-link"
    static let LOGIN = API.BASE_URL+"login"
    static let USER_DETAILED_INFO = API.BASE_URL+"user-detailed-info"
    static let QUESTION_ONE = API.BASE_URL+"question-status1"
    static let QUESTION_TWO = API.BASE_URL+"question-status2"
    static let QUESTION_THREE = API.BASE_URL+"question-status3"
    static let QUESTION_FOUR = API.BASE_URL+"question-status4"
    static let WORKSTATION_INFO = API.BASE_URL+"workstation-info5"
    static let WEARNING_LIST = API.BASE_URL+"wearing-list"
    static let SAVE_TASK = API.BASE_URL+"save_tasks"
    static let DELETE_TASK = API.BASE_URL+"deleteTask"
    static let SHOW_TASK = API.BASE_URL+"show_task"
    static let ABOUT_US_APP = API.BASE_URL+"show_about_us"
    static let PRIVACY_POLICY = API.BASE_URL+"show_policy"
    static let SOCIAL_LOGIN = API.BASE_URL+"social_login"
    static let SOCIAL_LOGIN_APPLE = API.BASE_URL+"Apple_login"
    static let CONTACT_US_ENQUIRY = API.BASE_URL+"user_enquiry"
    static let USER_TOTAL_POINT = API.BASE_URL+"point_sum"
    static let FOCUS_DAYS = API.BASE_URL+"focus_days"
    static let NOTIFICATION_HISTORY = API.BASE_URL+"notification_history"
    static let SINGLE_DELETE_NOTIFICATION = API.BASE_URL+"deleteSingleNotification"
    static let MULTIPLE_DELETE_NOTIFICATION = API.BASE_URL+"deleteMultipleNotification"
    static let UPDATE_NOTIFICATION_STATUS = API.BASE_URL+"update_notification_status"
    static let ADDITIONAL_POINT = API.BASE_URL+"additional_points"
    static let FORGOT_PASSWORD = API.BASE_URL+"forgot-password"
    static let INTRUPTION_OTHER_FEEDBACK = API.BASE_URL+"interruption_feedback_other"
    static let RENEWAL_PERIOD_EXERSICES = API.BASE_URL+"showAllRenewalExercises"
    static let RECOVERY_SIT_PUSHUP = API.BASE_URL+"user_sit_push_ups"
    static let SHOW_ALL_EQUIPMENT = API.BASE_URL+"showAllEquipment"
    static let USER_WORKSTATION_SURVEY = API.BASE_URL+"user_workstation_survey"
    static let REGISTRATION_WORKSTATION_EQUIPMENTS = API.BASE_URL+"showAllEquipment"
    static let INTRUPTION_TYPE = API.BASE_URL+"ShowAllInterruptionTypes"
    static let NEW_WORKSTATION_SURVEY = API.BASE_URL+"new_workstation_survey"
    
    
    
    static let FITNESS_LEVEL_UPDATE = API.BASE_URL+"user_fitness_level_update"
    static let INTRUPTION_BASED_MOTIVATION_QUOTE_LIST = API.BASE_URL+"user_interruption_based_motivational_listing"
    static let USER_TASK_COMPLITION_STATUS = API.BASE_URL+"user_task_completion_status"
    static let RECOVERY_USER_BASED_EXERCISE_LIST = API.BASE_URL+"user_equipment_based_exercise_listing"
    static let MOTIVATION_INTRUPTION_LIST = API.BASE_URL+"ShowUserSelected_Interruption_with_all_Interruptions"
    static let SUBMIT_MOTIVATION_INTRUPTION = API.BASE_URL+"user_exercise_interruption_types"
    
    static let UPDATE_INTRUPTION_STATUS = API.BASE_URL+"update_interruption_status"
    
    static let DEVICE_TOKEN_UPDATE = API.BASE_URL+"device_token_update"
    static let TASK_STATUS_UPDATE = API.BASE_URL+"task_status_update"
    
    static let SHOW_ALL_COUPON = API.BASE_URL+"Show_all_coupons"
    static let PURCHASE_COUPON = API.BASE_URL+"user_purchase_coupon"
    static let SHOW_ALL_PURCHASE_COUPON = API.BASE_URL+"Show_all_purchaged_coupons"
    
}


//http://18.219.104.111:3000/api/signup
//http://18.219.104.111:3000/api/active-link
//http://18.219.104.111:3000/api/login
//http://18.219.104.111:3000/api/user-detailed-info
//http://18.219.104.111:3000/api/question-status1
//http://18.219.104.111:3000/api/question-status2
//http://18.219.104.111:3000/api/question-status3
//http://18.219.104.111:3000/api/question-status4
//http://18.219.104.111:3000/api/workstation-info5
//http://18.219.104.111:3000/api/wearing-list
//http://18.219.104.111:3000/api/save_tasks
//http://18.219.104.111:3000/api/deleteTask
//http://18.219.104.111:3000/api/show_task
//http://18.219.104.111:3000/api/show_about_us
//http://18.219.104.111:3000/api/show_policy
//http://18.219.104.111:3000/api/social_login
//http://18.219.104.111:3000/api/user_enquiry
//http://18.219.104.111:3000/api/point_sum
//http://18.219.104.111:3000/api/focus_days
//http://18.219.104.111:3000/api/notification_history
//http://18.219.104.111:3000/api/deleteSingleNotification
//http://18.219.104.111:3000/api/deleteMultipleNotification
//http://18.219.104.111:3000/api/update_notification_status
//http://18.219.104.111:3000/api/additional_points
//http://18.219.104.111:3000/api/forgot-password
//http://18.219.104.111:3000/api/interruption_feedback_other
//http://18.219.104.111:3000/api/showAllRenewalExercises
//http://18.219.104.111:3000/api/user_sit_push_ups
//http://18.219.104.111:3000/api/showAllEquipment
//http://18.219.104.111:3000/api/user_workstation_survey
//http://18.219.104.111:3000/api/showAllEquipment
//http://18.219.104.111:3000/api/user_workstation_survey
//http://18.219.104.111:3000/api/ShowAllInterruptionTypes
//http://18.219.104.111:3000/api/new_workstation_survey
//http://18.219.104.111:3000/api/user_fitness_level_update
//http://18.219.104.111:3000/api/user_interruption_based_motivational_listing
//http://18.219.104.111:3000/api/user_task_completion_status
//http://18.219.104.111:3000/api/user_equipment_based_exercise_listing
//http://18.219.104.111:3000/api/ShowUserSelected_Interruption_with_all_Interruptions
//http://18.219.104.111:3000/api/user_exercise_interruption_types
//http://18.219.104.111:3000/api/update_interruption_status
//http://18.219.104.111:3000/api/device_token_update
//http://18.219.104.111:3000/api/task_status_update
//http://18.219.104.111:3000/api/Show_all_coupons
//http://18.219.104.111:3000/api/user_purchase_coupon
//http://18.219.104.111:3000/api/Show_all_purchaged_coupons
