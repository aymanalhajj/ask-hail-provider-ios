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
    @IBOutlet weak var AddCommentTV: UITextView!
    @IBOutlet weak var CommentView: UIView!
    @IBOutlet weak var CommentViewHeight: NSLayoutConstraint!
        
    var replayTapOpen = false
    
    var ShowReplay : (()->())?
    var AddReplay : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        CommentViewHeight.constant = 0
        CommentView.alpha = 0
        AddCommentTV.delegate = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func ShowReplayAction(_ sender: Any) {
        if replayTapOpen == false {
            ShowReplayPlace()
            replayTapOpen = true
        } else {
            HideReplayPlace()
            replayTapOpen = false
        }
        
        ShowReplay?()
    }
    
    @IBAction func AddReplayAction(_ sender: Any) {
        HideReplayPlace()
        AddReplay?()
    }
    
    func ShowReplayPlace() {
        
        if L102Language.currentAppleLanguage() == "en" {
            AddCommentTV.text = "Add your replay"
            
        }else {
            
            AddCommentTV.text = "اضافة الرد هنا "
        }
        
        AddCommentTV.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5)
        
        UIView.animate(withDuration: 0.6, animations: {
            
            self.CommentViewHeight.constant = 172
            self.CommentView.alpha = 1
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.3, animations: {
                
            }, completion: { _ in
                
            })
        })
        
    }
    
    func HideReplayPlace() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.CommentViewHeight.constant = 0
            self.CommentView.alpha = 0            
        }, completion: { _ in
            UIView.animate(withDuration: 0.3, animations: {
                
            }, completion: { _ in
                
                
            })
        })
        
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if AddCommentTV.textColor == #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5) {
            AddCommentTV.text = ""
            AddCommentTV.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 1)
        }
    }
    
}
