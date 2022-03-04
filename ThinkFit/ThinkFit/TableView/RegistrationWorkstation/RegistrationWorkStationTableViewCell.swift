//
//  RegistrationWorkStationTableViewCell.swift
//  ThinkFit
//
//  Created by apple on 29/12/20.
//  Copyright © 2020 Harinder Rana. All rights reserved.
//

import UIKit

//MARK:- Protocol
protocol YourCellDelegate : class {
    func didPressButton(_ tag: Int)
     func didnoPressButton(_ tag: Int)
    
}

class RegistrationWorkStationTableViewCell: UITableViewCell {

    //MARK:- Cell Outlets
    @IBOutlet weak var workstationNamelbl: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    
    //MARK:- Define Cell Protocol Delegate
    var cellDelegate: YourCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK:- UIButton Action
    /*** yes Button Action ***/
    @IBAction func yesButtonAction(_ sender: UIButton) {
        cellDelegate?.didPressButton(sender.tag)
    }
    
    /*** No Button Action ***/
    @IBAction func noButtonAction(_ sender: UIButton) {
        cellDelegate?.didnoPressButton(sender.tag)
    }
    
}
