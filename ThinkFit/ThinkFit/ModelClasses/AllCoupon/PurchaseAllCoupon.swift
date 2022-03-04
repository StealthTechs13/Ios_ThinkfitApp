//
//  PurchaseAllCoupon.swift
//  ThinkFit
//
//  Created by apple on 18/06/21.
//  Copyright © 2021 Harinder Rana. All rights reserved.
//

import Foundation

struct PurchaseAllCouponModel {
    
    var id : Int
    var user_id : String
    var coupon_id : String
    var buy_prize : String
    var code_id : String
    var status : String
    var code : String
    var created_At: String
    var updated_At: String
    var coupon_logo : String
    var coupon_status : String
    var description : String
    var discount_type : String
    var discount_value : String
    var prize_in_fitness_point : String
    var redeem_instructions : String
    var terms_condition : String
    var title : String
    var valid_from : String
    var valid_to : String
    
    
    init(id: Int, userid: String, couponid: String, buyprize: String, codeid: String, status: String, code: String, createat: String, updateat: String,couponlogo : String, couponstatus: String, description : String, discounttype: String, discountvalue: String, prize_in_fitness_point: String,redeeminstructions: String, termscondition: String, title: String, valid_from: String,valid_to: String) {
        
        self.id = id
        self.user_id = userid
        self.coupon_id = couponid
        self.buy_prize = buyprize
        self.code_id = codeid
        self.status = status
        self.code = code
        self.created_At = createat
        self.updated_At = updateat
        self.coupon_logo = couponlogo
        self.coupon_status = couponstatus
        self.description = description
        self.discount_type = discounttype
        self.discount_value = discountvalue
        self.prize_in_fitness_point = prize_in_fitness_point
        self.redeem_instructions = redeeminstructions
        self.terms_condition = termscondition
        self.title = title
        self.valid_from = valid_from
        self.valid_to = valid_to
        
    }
}

