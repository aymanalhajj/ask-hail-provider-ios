//
//  CommentVC.swift
//  AskHailBusiness
//
//  Created by Abdullah Tarek on 01/03/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit

import UIKit

class CommentVC: UIViewController {
    
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var CommentsTableView: UITableView!
    
    
    var CommentArray : [Comments_data] = []
    
    var Adv_Id = ""
    var user_id = ""
    
    var isActive = true
    
    private func createSpinnerFooter() -> UIView {
        let FooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        FooterView.backgroundColor = .clear
        let spinner = UIActivityIndicatorView()
        
        spinner.style = .large
        spinner.color = #colorLiteral(red: 0, green: 0.2846388221, blue: 0.497141242, alpha: 1)
        
        spinner.center = FooterView.center
        FooterView.addSubview(spinner)
        spinner.startAnimating()
        
        return FooterView
        
    }
    
    var CurrentPage = 1
    var lastPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ShowComment()
        
        CommentsTableView.delegate = self
        CommentsTableView.dataSource = self
        
        CommentsTableView.RegisterNib(cell: CommentWithReplayCell.self)
        
        CommentsTableView.RegisterNib(cell: CommentCellTableViewCell.self)
        
        CommentsTableView.RegisterNib(cell: ReplayCommentCell.self)
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        CommentsTableView.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
    }
    
    @IBAction func BackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
}


//MARK:- TableView Controller

extension CommentVC : UITableViewDelegate , UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let ContentHeight = scrollView.contentSize.height
        if isActive {
            if position > ContentHeight - scrollView.frame.height {
                
                print("Done")
                isActive = false
                
                //numberofitem
                
                if CurrentPage < lastPage {
                    CurrentPage = CurrentPage + 1
                    
                    ShowComment()
                    
                }
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Model = CommentArray[indexPath.row]
        
        
        if user_id == Helper.getaUser_id() {
            //if My Adv
            
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

//MARK:- Protocol Controller

extension CommentVC : AddComent{
    func addNewComment(comment_text: String, state: Int, comment_id: String) {
        if state == 1 {
            AddReplay(comment_id: comment_id, CommentText: comment_text)
        }
    }
}

//MARK:-Api

extension CommentVC {
    
    func ShowComment() {

        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)show-question-comments/\(Adv_Id)?page=\(CurrentPage)") { (data : AllCommentModel?, String) in
            
            if String != nil {
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.CurrentPage = data.data?.pagination?.current_page ?? 1
                self.lastPage = data.data?.pagination?.last_page ?? 1
                
                for item in data.data?.data ?? [] {
                    self.CommentArray.append(item)
                }
                
                
                
                DispatchQueue.main.async {
                    self.CommentsTableView.reloadData()
                }
                self.isActive = true

                print(data)
            }
        }
    }
    
    func RemoveComment(id : Int) {
        self.view.lock()
        
        
        let Parameters = [
            "comment_id" : "\(id)",
        ]
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)question-operations/remove-comment") { (data : Level_6_Model?, String) in
            
            self.view.unlock()
            
            if String != nil {

                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.CommentArray.removeAll()
                self.ShowComment()
                
                print(data)
                
            }
        }
    }
    
    func AddReplay(comment_id : String , CommentText : String) {
        
        let Parameters = [
            "comment_id" : comment_id,
            "reply" : CommentText
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)business/add-or-update-reply-on-comment") { (data : Level_6_Model?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.CommentArray.removeAll()
                self.ShowComment()

                print(data)
            }
        }
    }
    
}
