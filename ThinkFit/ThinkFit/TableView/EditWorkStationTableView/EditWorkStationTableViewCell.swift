//
//  EditWorkStationTableViewCell.swift
//  ThinkFit
//
//  Created by apple on 24/12/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

class EditWorkStationTableViewCell: UITableViewCell {

    
    //MARK:- Cell Outlets
    @IBOutlet weak var equipmentLbl: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
