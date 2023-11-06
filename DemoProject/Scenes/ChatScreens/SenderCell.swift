//
//  SenderCell.swift
//  AskHail
//
//  Created by Mohab on 11/17/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class SenderCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var CellMessge: UILabel!
    @IBOutlet weak var CellTime: UILabel!
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
