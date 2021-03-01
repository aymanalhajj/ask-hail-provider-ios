//
//  CommentWithReplayCell.swift
//  AskHail
//
//  Created by bodaa on 21/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//


import UIKit

class CommentWithReplayCell: UITableViewCell {
    
    @IBOutlet weak var CommentName: UILabel!
    @IBOutlet weak var CommentText: UILabel!
    @IBOutlet weak var CommentTime: UILabel!
    
    
    @IBOutlet weak var CommentReplayName: UILabel!
    @IBOutlet weak var CommentReplayText: UILabel!
    @IBOutlet weak var CommentReplayTime: UILabel!
    
    
    @IBOutlet weak var Deletbtn: UIButton!
    @IBOutlet weak var DeleteHight: NSLayoutConstraint!
    
    var DeletComment : (()->())?

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func DeleteAction(_ sender: Any) {
        DeletComment?()
    }
}
