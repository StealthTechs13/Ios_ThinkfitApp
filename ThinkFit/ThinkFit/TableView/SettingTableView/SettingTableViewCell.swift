//
//  SettingTableViewCell.swift
//  ThinkFit
//
//  Created by apple on 24/12/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    //MARK:- Cell Outlets
    @IBOutlet weak var settingNameLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
