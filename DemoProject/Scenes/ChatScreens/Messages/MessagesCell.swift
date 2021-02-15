//
//  MessagesCell.swift
//  AskHail
//
//  Created by Mohab on 11/17/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class MessagesCell: UITableViewCell {
    
    @IBOutlet weak var CellImage: UIImageView!
    @IBOutlet weak var CellTitle: UILabel!
    @IBOutlet weak var CellLastMessege: UILabel!
    @IBOutlet weak var CellLastTime: UILabel!
    @IBOutlet weak var CellUnreadMessge: UILabel!
    @IBOutlet weak var ImageWideth: NSLayoutConstraint!

    

    override func layoutSubviews() {
              super.layoutSubviews()

              contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
          }
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
        
    }
    
}
