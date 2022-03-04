//
//  SignUpModel.swift
//  ThinkFit
//
//  Created by apple on 22/10/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import Foundation

struct signUpModel {
    
    var emailVarified = ""
    var stepOne = ""
    var stepTwo = ""
    var stepThree = ""
    var stepFour = ""
    var stepFive = ""
    var stepSix = ""
    var userId = ""
    var userName = ""
    var userEmail = ""
    var userDeviceToken = ""
    var userCreateAt = ""
    var userUpdateAt = ""
    var userDob = ""
    var userGender = ""
    
    init(email_Varified: String , step_one: String, step_two: String, step_three: String, step_four: String, step_five: String, step_six: String, user_Id: String, user_name: String, user_email: String, user_device_token: String, user_create_at : String, user_update_at: String, user_Dob: String, user_gender: String) {
        
        self.emailVarified = email_Varified
        self.stepOne = step_one
        self.stepTwo = step_two
        self.stepThree = step_three
        self.stepFour = step_four
        self.stepFive = step_five
        self.stepSix = step_six
        self.userId = user_Id
        self.userName = user_name
        self.userEmail = user_email
        self.userDeviceToken = user_device_token
        self.userCreateAt = user_create_at
        self.userUpdateAt = user_update_at
        self.userDob = user_Dob
        self.userGender = user_gender
    }
}
