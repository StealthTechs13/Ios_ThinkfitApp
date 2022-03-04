//
//  FitPointCouponDetailTableViewCell.swift
//  ThinkFit
//
//  Created by apple on 24/05/21.
//  Copyright © 2021 Harinder Rana. All rights reserved.
//

import UIKit

class FitPointCouponDetailTableViewCell: UITableViewCell {

    //MARK:- Cell Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var dotViewWidth: NSLayoutConstraint!
    @IBOutlet weak var termsConditionButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
