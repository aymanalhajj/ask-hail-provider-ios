//
//  CommentPopupVC.swift
//  AskHailBusiness
//
//  Created by Abdullah Tarek on 01/03/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit

protocol AddComent {
    func addNewComment(comment_text : String, state : Int , comment_id : String)
}

class CommentPopupVC: UIViewController, UITextViewDelegate {
    
    var Delegte : AddComent?
    var action = ""
    var commet_id = ""
    @IBOutlet weak var Addbtn: UIButton!
    
    @IBOutlet weak var commentTv: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        commentTv.delegate = self
        
        if action == "replay" {
            
            if L102Language.currentAppleLanguage() == "en" {
                commentTv.text = "Add Replay"
                Addbtn.setTitle("Add Replay", for: .normal)
                commentTv.font = UIFont(name: "Tajawal-Regular", size: 16)
                commentTv.textAlignment = .left

            }else {
                Addbtn.setTitle("اضف ردك", for: .normal)
                commentTv.text = "اضف ردك"
                commentTv.font = UIFont(name: "Tajawal-Regular", size: 16)
                commentTv.textAlignment = .right
            }
            commentTv.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5)
            
        }else{
            
            if L102Language.currentAppleLanguage() == "en" {
                commentTv.text = "Add New Comment"
                Addbtn.setTitle("Add New Comment", for: .normal)

                commentTv.font = UIFont(name: "Tajawal-Regular", size: 16)
                commentTv.textAlignment = .left

            }else {
                Addbtn.setTitle("اضافة تعليق جديد", for: .normal)
                commentTv.text = "اضافة تعليق جديد"
                commentTv.font = UIFont(name: "Tajawal-Regular", size: 16)
                commentTv.textAlignment = .right
            }

            commentTv.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5)
            
        }
        
        
        showAnimate()

    }
    
    @IBAction func AddComentAction(_ sender: Any) {
        
        if commentTv.text.isEmpty == true {
            self.navigationController?.view.makeToast("enter comment first".localized)
        }else{
            if action == "replay" {
                Delegte?.addNewComment(comment_text:  commentTv.text , state : 1 , comment_id: commet_id)
            }else{
                Delegte?.addNewComment(comment_text:  commentTv.text , state : 2, comment_id: commet_id)
            }
            
            action = ""
            removeAnimate()
            
        }
    }
    
    @IBAction func CancelAction(_ sender: Any) {
        action = ""
        removeAnimate()
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        if commentTv.textColor == #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5) {
            commentTv.text = ""
            commentTv.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 1)
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""{
            if action == "replay" {
                if L102Language.currentAppleLanguage() == "en" {
                    commentTv.text = "Add Replay"
                    commentTv.font = UIFont(name: "Tajawal-Regular", size: 16)
                    commentTv.textAlignment = .left
                    
                }else {
                    
                    commentTv.text = "اضف ردك"
                    commentTv.font = UIFont(name: "Tajawal-Regular", size: 16)
                    commentTv.textAlignment = .right
                }
                commentTv.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5)
            }else{
                if L102Language.currentAppleLanguage() == "en" {
                    commentTv.text = "Add New Comment"
                    commentTv.font = UIFont(name: "Tajawal-Regular", size: 16)
                    commentTv.textAlignment = .left
                    
                }else {
                    
                    commentTv.text = "اضافة تعليق جديد"
                    commentTv.font = UIFont(name: "Tajawal-Regular", size: 16)
                    commentTv.textAlignment = .right
                }
                
                commentTv.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5)
                
            }
        }
    }
}
