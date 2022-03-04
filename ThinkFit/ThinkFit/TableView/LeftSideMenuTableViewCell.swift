//
//  LeftSideMenuTableViewCell.swift
//  ThinkFit
//
//  Created by apple on 10/09/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class LeftSideMenuTableViewCell: UITableViewCell {

    //MARK:- Cell Outlets 
    @IBOutlet weak var cellIconImage: UIImageView!
    @IBOutlet weak var cellMenuLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
