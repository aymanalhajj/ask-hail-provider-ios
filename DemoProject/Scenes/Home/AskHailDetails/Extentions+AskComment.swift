//
//  Extentions+AskComment.swift
//  AskHailBusiness
//
//  Created by Abdullah Tarek on 01/03/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import Foundation
import UIKit

extension AskHailDetailsVC : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Model = CommentArray[indexPath.row]
        
        
        if "\(AskData?.question_advertiser_id ?? 0)" == Helper.getaUser_id() {
            //if My Ask
            
            if Model.comment_if_advertiser_reply_yet == false {
                let cell = tableView.dequeue() as ReplayCommentCell
                
                cell.CommentName.text = Model.comment_voter_name ?? "" + "say".localized
                cell.CommentTime.text = Model.comment_text_custom_date ?? ""
                cell.CommentText.text = Model.comment_text ?? ""
                
                
                if Model.comment_voter_name == Helper.getaUser_name() {
                    cell.Deletbtn.isHidden = false
                    cell.DeleteHight.constant = 24
                }else{
                    cell.Deletbtn.isHidden = true
                    cell.DeleteHight.constant = 0
                }
                
                cell.DeletComment = {
                    self.RemoveComment(id: Model.comment_id ?? 0)
                }
                
                cell.AddReplay = {
                    let storyboard = UIStoryboard(name: Home, bundle: nil)
                    let vc  = storyboard.instantiateViewController(withIdentifier: "CommentPopupVC") as! CommentPopupVC
                    vc.action = "replay"
                    vc.commet_id = "\(Model.comment_id ?? 0)"
                    vc.Delegte = self
                    vc.modalPresentationStyle = .fullScreen
                    self.addChild(vc)
                    vc.view.frame = self.view.frame
                    self.view.addSubview(vc.view)
                    vc.didMove(toParent: self)
                }
                
                return cell
                
            }else{
                let cell = tableView.dequeue() as CommentWithReplayCell
                
                cell.CommentName.text = Model.comment_voter_name ?? "" + "say".localized
                cell.CommentTime.text = Model.comment_text_custom_date ?? ""
                cell.CommentText.text = Model.comment_text ?? ""
                
                cell.CommentReplayName.text = "Advertiser's answer".localized
                cell.CommentReplayText.text = Model.comment_advertiser_reply ?? ""
                cell.CommentReplayTime.text = Model.comment_advertiser_reply_custom_date ?? ""
                
                
                if Model.comment_voter_name == Helper.getaUser_name() {
                    cell.Deletbtn.isHidden = false
                    cell.DeleteHight.constant = 24
                }else{
                    cell.Deletbtn.isHidden = true
                    cell.DeleteHight.constant = 0
                }
                
                cell.DeletComment = {
                    self.RemoveComment(id: Model.comment_id ?? 0)
                }
                
                return cell
            }
            
            
        }else{
            //if Normal Adv
            print("Not My ads")
            
            if Model.comment_if_advertiser_reply_yet == false {
                
                let cell = tableView.dequeue() as CommentCellTableViewCell
                
                cell.CommentName.text = Model.comment_voter_name ?? "" + "say".localized
                cell.CommentTime.text = Model.comment_text_custom_date ?? ""
                cell.CommentText.text = Model.comment_text ?? ""
                
                if Model.comment_voter_name == Helper.getaUser_name() {
                    cell.Deletbtn.isHidden = false
                    cell.DeleteBtnHight.constant = 24
                }else{
                    cell.Deletbtn.isHidden = true
                    cell.DeleteBtnHight.constant = 0
                }
                
                cell.DeletComment = {
                    self.RemoveComment(id: Model.comment_id ?? 0)
                }
                
                return cell
                
            }else{
                
                let cell = tableView.dequeue() as CommentWithReplayCell
                
                cell.CommentName.text = Model.comment_voter_name ?? "" + "say".localized
                cell.CommentTime.text = Model.comment_text_custom_date ?? ""
                cell.CommentText.text = Model.comment_text ?? ""
                
                cell.CommentReplayName.text = "Advertiser's answer".localized
                cell.CommentReplayText.text = Model.comment_advertiser_reply ?? ""
                cell.CommentReplayTime.text = Model.comment_advertiser_reply_custom_date ?? ""
                
                
                if Model.comment_voter_name == Helper.getaUser_name() {
                    cell.Deletbtn.isHidden = false
                    cell.DeleteHight.constant = 24
                }else{
                    cell.Deletbtn.isHidden = true
                    cell.DeleteHight.constant = 0
                }
                
                cell.DeletComment = {
                    self.RemoveComment(id: Model.comment_id ?? 0)
                }
                
                return cell
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


