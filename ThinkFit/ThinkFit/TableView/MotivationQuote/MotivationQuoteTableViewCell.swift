//
//  MotivationQuoteTableViewCell.swift
//  ThinkFit
//
//  Created by apple on 05/01/21.
//  Copyright © 2021 Harinder Rana. All rights reserved.
//

import UIKit

class MotivationQuoteTableViewCell: UITableViewCell {

    //MARK:-Outlets
    @IBOutlet weak var checkUncheckButton: UIButton!
    @IBOutlet weak var intruptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
