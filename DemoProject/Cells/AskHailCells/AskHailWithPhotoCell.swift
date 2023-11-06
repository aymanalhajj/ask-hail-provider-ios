//
//  AskHailWithPhotoCell.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/10/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class AskHailWithPhotoCell: UITableViewCell {


    @IBOutlet weak var askImage: UIImageView!
    @IBOutlet weak var ImageHight: NSLayoutConstraint!
    @IBOutlet weak var CellName: UILabel!
    @IBOutlet weak var CellTime: UILabel!
    @IBOutlet weak var CellTitle: UILabel!
    @IBOutlet weak var cellHaveComment: UILabel!
    @IBOutlet weak var IsNewView: UIView!
    
    
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
