//
//  CommentCellTableViewCell.swift
//  AskHail
//
//  Created by bodaa on 02/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class CommentCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var CommentName: UILabel!
    @IBOutlet weak var CommentText: UILabel!
    @IBOutlet weak var CommentTime: UILabel!
    @IBOutlet weak var Deletbtn: UIButton!
    
    @IBOutlet weak var DeletedView: UIView!
    @IBOutlet weak var DeleteText: UILabel!
    
    @IBOutlet weak var DeleteBtnHight: NSLayoutConstraint!
    
    var DeletComment : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func DeleteAction(_ sender: Any) {
        DeletComment?()
    }
    
}
