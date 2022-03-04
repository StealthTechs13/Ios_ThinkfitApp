//
//  UserInfoDataModel.swift
//  ThinkFit
//
//  Created by apple on 27/11/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import Foundation

struct UserInfoDatailModel {
    
    var id = Int()
    var status = Int()
    var name = ""
    var email = ""
    var gender = ""
    var dob = ""
    var loginType = ""
    var deviceType = ""
    var intruption = ""
    var defaultTime = 0
    var devtoken = ""
    var token = ""
    var forgetToken = ""
    var createAt = ""
    var updateAt = ""
    var emailVerified = ""
    var stepOne = ""
    var stepTwo = ""
    var stepThree = ""
    var stepFour = ""
    var stepFive = ""
    var stepSix = ""
    
    init(u_id: Int, status : Int, u_name : String, u_email : String , u_gender : String, u_dob : String, u_login_type : String, u_device_type : String, u_intruption : String, u_default_time : Int, u_dev_token: String, u_token: String, u_foget_token: String, u_create_at : String, u_update_at: String, u_email_verified: String, u_stepOne: String, u_stepTwo: String, u_stepThree: String, u_stepFour: String, u_stepFive: String, u_stepsix: String) {
        
        self.id = u_id
        self.status = status
        self.name = u_name
        self.email = u_email
        self.gender = u_gender
        self.dob = u_dob
        self.loginType = u_login_type
        self.deviceType = u_device_type
        self.intruption = u_intruption
        self.defaultTime = u_default_time
        self.devtoken = u_dev_token
        self.token = u_token
        self.forgetToken = u_foget_token
        self.createAt = u_create_at
        self.updateAt = u_update_at
        self.emailVerified = u_email_verified
        self.stepOne = u_stepOne
        self.stepTwo = u_stepTwo
        self.stepThree = u_stepThree
        self.stepFour = u_stepFour
        self.stepFive = u_stepFive
        self.stepSix = u_stepsix
    
    }
}
