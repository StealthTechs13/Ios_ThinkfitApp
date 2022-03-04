//
//  ShowAllCouponModel.swift
//  ThinkFit
//
//  Created by apple on 09/06/21.
//  Copyright © 2021 Harinder Rana. All rights reserved.
//

import Foundation

struct ShowAllCouponModel {
    
    var id : String
    var title : String
    var valid_from : String
    var valid_to : String
    var discount_type : String
    var discount_value : String
    var description : String
    var status : String
    var createdAt : String
    var updatedAt : String
    var coupon_logo: String
    var termsCondition : String
    var redeeminstructions : String
    var couponstatus : String
    var prize_fitness_point: Int
    
    init(id: String, title: String, validFrom: String, validTo: String, discountType: String, discountValue: String,description: String,status: String, createdAt: String, updatedAt: String, couponlogo: String, terms_condition: String, redeem_instructions: String, coupon_status: String, prize_fitness_point: Int) {
        
        self.id = id
        self.title = title
        self.valid_from = validFrom
        self.valid_to = validTo
        self.discount_type = discountType
        self.discount_value = discountValue
        self.description = description
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.coupon_logo = couponlogo
        self.termsCondition = terms_condition
        self.redeeminstructions = redeem_instructions
        self.couponstatus = coupon_status
        self.prize_fitness_point = prize_fitness_point
        
    }
}
