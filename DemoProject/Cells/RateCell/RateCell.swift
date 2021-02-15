//
//  RateCell.swift
//  AskHailBusiness
//
//  Created by bodaa on 14/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit
import Cosmos

class RateCell: UITableViewCell {
    
    @IBOutlet weak var CellName: UILabel!
    @IBOutlet weak var CellTime: UILabel!
    @IBOutlet weak var CellRate: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
