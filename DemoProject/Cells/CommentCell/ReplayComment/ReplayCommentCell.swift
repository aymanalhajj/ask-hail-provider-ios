//
//  ReplayCommentCell.swift
//  AskHail
//
//  Created by bodaa on 21/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class ReplayCommentCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var CommentName: UILabel!
    @IBOutlet weak var CommentText: UILabel!
    @IBOutlet weak var CommentTime: UILabel!
    @IBOutlet weak var ReplayBtn: UIButton!
    @IBOutlet weak var Deletbtn: UIButton!
    @IBOutlet weak var DeleteHight: NSLayoutConstraint!
    
    var AddReplay : (()->())?
    var DeletComment : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

    }
    
    @IBAction func AddReplayAction(_ sender: Any) {
        AddReplay?()
    }
    
    @IBAction func DeleteAction(_ sender: Any) {
        DeletComment?()
    }
    
}


