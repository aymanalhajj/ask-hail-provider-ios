//
//  JobCell.swift
//  AskHail
//
//  Created by Abdullah Tarek on 10/30/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class JobCell: UITableViewCell {
    
    @IBOutlet weak var JobTitle: UILabel!
    @IBOutlet weak var JobDescription: UILabel!
    @IBOutlet weak var JonLocation: UILabel!
    

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

              contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24))
          }
    
}
