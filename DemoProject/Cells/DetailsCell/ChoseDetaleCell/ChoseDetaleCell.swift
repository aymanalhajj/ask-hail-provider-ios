//
//  ChoseDetailsCell.swift
//  AskHail
//
//  Created by bodaa on 16/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit

class ChoseDetailsCell: UITableViewCell {

    @IBOutlet weak var CellTitle: UILabel!
    @IBOutlet weak var CellBtn: UIButton!
    
    var ChoseCell : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func ChoseFeatureAction(_ sender: Any) {
        ChoseCell?()
    }
    
}

