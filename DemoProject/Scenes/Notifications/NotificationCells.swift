//
//  NotificationCells.swift
//  AskHail
//
//  Created by Mohab on 11/14/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//


import UIKit

class NotificationCells: UITableViewCell {

    @IBOutlet weak var CellTitle: UILabel!
    @IBOutlet weak var CellDec: UILabel!
    @IBOutlet weak var CellTime: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

