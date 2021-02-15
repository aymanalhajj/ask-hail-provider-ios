//
//  SpecialDetailsCell.swift
//  AskHail
//
//  Created by bodaa on 24/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit

class SpecialDetailsCell: UITableViewCell {

    @IBOutlet weak var CellTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
              super.layoutSubviews()

              contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
          }
    
}
