//
//  OrderCell.swift
//  AskHail
//
//  Created by bodaa on 11/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {
    
    @IBOutlet weak var OrderName: UILabel!
    @IBOutlet weak var OrderTime: UILabel!
    @IBOutlet weak var OrderTitle: UILabel!
    @IBOutlet weak var IsNewView: UIView!
    @IBOutlet weak var OrderPrice: UILabel!
    

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
