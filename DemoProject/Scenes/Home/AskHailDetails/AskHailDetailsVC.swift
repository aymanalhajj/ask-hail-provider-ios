//
//  AskHailDetailsVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/10/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import FirebaseDynamicLinks

class AskHailDetailsVC: UIViewController ,UITextViewDelegate {
    
    
    @IBOutlet weak var ScrollBackGround: UIView!
    @IBOutlet var MainBackRound: UIView!
    @IBOutlet weak var buttomView: UIView!
    
    @IBOutlet weak var tableviewhight: NSLayoutConstraint!
    @IBOutlet weak var MainView: UIScrollView!
    
    @IBOutlet weak var AskNumber: UILabel!
    @IBOutlet weak var AskNom: UILabel!
    
    
    @IBOutlet weak var OutheNam: UILabel!
    
    @IBOutlet weak var AskImageHight: NSLayoutConstraint!
    @IBOutlet weak var AskImage: UIImageView!
    @IBOutlet weak var DetailsView: UIView!
    @IBOutlet weak var AskTitle: UILabel!
    @IBOutlet weak var AskDate: UILabel!
    
    @IBOutlet weak var AskDistance: UILabel!
    
    @IBOutlet weak var CommemtView: UIView!
    @IBOutlet weak var AdvCommentCount: UILabel!
    @IBOutlet weak var CommentsTableView: UITableView!
    @IBOutlet weak var addCommentBtn: UIButton!
    @IBOutlet weak var ShowMoreBtn: UIButton!
    @IBOutlet weak var NoCommentLable: UILabel!
    
    @IBOutlet weak var EditView: UIView!
    
    @IBOutlet weak var orderNomberLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var deleteLbl: UILabel!
    @IBOutlet weak var editLbl: UILabel!
    
    
    var asker_id = ""
    var imageUrl = ""
    var ComentData = false
    
    var isActive = true
    var CommenstCount = 0
    
    var CurrentPage = 1
    var CommentArray : [Comments_data] = []
    var lastPage = 1
    
    
    var ask_id = ""
    var height = 200
    
    var AskData : Question_details?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        EditView.isHidden = true
        MainView.isHidden = true
        CurrentPage = 1
        lastPage = 1
        CommentArray.removeAll()
        getAskDetails()
        ShowComment()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ScrollBackGround.backgroundColor = UIColor(hexString: "E5F2F7")
        MainBackRound.backgroundColor = UIColor(hexString: "E5F2F7")
        
        NoCommentLable.text = "No Commentns".localized
        
        deleteLbl.text = "Delete".localized
        editLbl.text = "Edit".localized
        detailsLbl.text = "Description".localized
        commentLbl.text = "Comments".localized
        addCommentBtn.setTitle("Add comment".localized, for: .normal)
        ShowMoreBtn.setTitle("Show more".localized, for: .normal)
        AskNumber.text = "Ask Num.".localized
        
        setShadow(view: DetailsView, width: Int(0.1), height: Int(0.1), shadowRadius: 1, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        setShadow(view: CommemtView, width: Int(0.1), height: Int(0.1), shadowRadius: 1, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        setShadow(view: EditView, width: 1, height: 1, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        
        AskNom.text = "\(ask_id)"
        
        if DynamicLinkModel.isDynamic {
            self.ask_id = DynamicLinkModel.Product_id
        }
        tabBarController?.tabBar.isHidden = true
        
        CommentsTableView.delegate = self
        CommentsTableView.dataSource = self
        
        CommentsTableView.RegisterNib(cell: CommentWithReplayCell.self)
        
        CommentsTableView.RegisterNib(cell: CommentCellTableViewCell.self)
        
        CommentsTableView.RegisterNib(cell: ReplayCommentCell.self)
        
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        if DynamicLinkModel.isDynamic {
            DynamicLinkModel.isDynamic = false
            guard let window = UIApplication.shared.keyWindow else{return}
            let sb = UIStoryboard(name: Home, bundle: nil)
            var vc : UIViewController
            vc = sb.instantiateViewController(withIdentifier: "HomeVC")
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
            
        }
        
        tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func AddComment(_ sender: Any) {

        guard Helper.getapitoken() != nil else {
            alertSkipLogin()
            return
        }
        
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        
        let vc  = storyboard.instantiateViewController(withIdentifier: "CommentPopupVC") as! CommentPopupVC
        vc.Delegte = self
        vc.action = "comment"
        vc.modalPresentationStyle = .fullScreen
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
    @IBAction func ShareAds(_ sender: Any) {
        
        guard let link = URL(string: "https://askhail.page.link/question/\(ask_id)") else { return }
        let dynamicLinksDomainURIPrefix = "https://askHail.page.link"
        let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix)
        
        linkBuilder?.iOSParameters = DynamicLinkIOSParameters(bundleID: "com.wesal.askHail")
        linkBuilder?.iOSParameters?.appStoreID = "1542462594"
        linkBuilder?.iOSParameters?.minimumAppVersion = "1.1.0"
        
        linkBuilder?.navigationInfoParameters = DynamicLinkNavigationInfoParameters()
        linkBuilder?.navigationInfoParameters?.isForcedRedirectEnabled = true
        
        linkBuilder?.androidParameters = DynamicLinkAndroidParameters(packageName: "com.wesal.askhail")
        linkBuilder?.androidParameters?.minimumVersion = 1
        
        guard let longDynamicLink = linkBuilder?.url else {
            return
            
        }
        print(longDynamicLink)
        
        DynamicLinkComponents.shortenURL(longDynamicLink, options: nil) { url, warnings, error in
          guard let url = url, error == nil else { return }
          print("The short URL is: \(url)")
            
            let shareText = "\(self.AskTitle.text ?? "")" + "\n" + "\(url)"
            
            print(shareText)
            let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
            if(UIDevice.current.userInterfaceIdiom == .pad){
                vc.popoverPresentationController?.sourceView = self.view
            }else{
                self.present(vc, animated: true, completion: {})
            }
            
        }
        
    }
    
    @IBAction func openImageAction(_ sender: Any) {
        
        var imageV = UIImageView()
        imageV.loadImage(URL(string: AskData?.question_image ?? ""))
        Helper.openZoomAbleImage(image: imageV.image ?? UIImage(), vc: self)
        
    }
    @IBAction func ShoeMoreCommentAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "CommentVC") as! CommentVC
        vc.Adv_Id = "\(AskData?.question_id ?? 0)"
        vc.user_id = "\(AskData?.question_advertiser_id ?? 0)"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func EditAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: EditAsk_story, bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "EditMyAskPopupVC") as! EditMyAskPopupVC
        vc.modalPresentationStyle = .fullScreen
        vc.deleget = self
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
    @IBAction func DeletAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: EditAsk_story, bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "DeleteAskPopupVC") as! DeleteAskPopupVC
        vc.question_id = "\(AskData?.question_id ?? 0)"
        vc.modalPresentationStyle = .fullScreen
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
}

//MARK:- Protocol Controller

extension AskHailDetailsVC : AddComent{
    func addNewComment(comment_text: String, state: Int, comment_id: String) {
        if state == 1 {
            AddReplay(comment_id: comment_id, CommentText: comment_text)
        }else{
            NewComment(Ask_id: "\(AskData?.question_id ?? 0)", CommentText: comment_text)
        }
    }
}

extension AskHailDetailsVC : EditAsk {
    func openEditPopUp(state: Int) {
        if state == 1 {
            
            let storyboard = UIStoryboard(name: EditAsk_story, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "EditAskDetailVC") as!EditAskDetailVC
            vc.AskData = self.AskData
            navigationController?.pushViewController(vc, animated: true)
            
        }else if state == 2{
            let storyboard = UIStoryboard(name: EditAsk_story, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "EditAskImageVC") as!EditAskImageVC
            vc.AskData = self.AskData
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK:-API
extension AskHailDetailsVC {
    
    func getAskDetails() {
        
        self.view.lock()

        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)show-question/\(ask_id)") { (data : ShowAskDetailsModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.AskData = data.data?.question_details
                
                self.CheckIfMyAsk()
                self.ComentData = true
                
                self.AskNom.text = "\(data.data?.question_details?.question_id ?? 0)"
                
                self.AskImage.loadImage(URL(string: data.data?.question_details?.question_image ?? ""))
                
                self.imageUrl = data.data?.question_details?.question_image ?? ""
                print(self.imageUrl)
                
                self.OutheNam.text = data.data?.question_details?.question_advertiser_name
                                
                self.OutheNam.isHidden = true
                
                if data.data?.question_details?.question_show_name_status == "active" {
                    self.OutheNam.isHidden = false
                }
                
                
                self.AskTitle.text = data.data?.question_details?.question_title ?? ""
                
                self.AskDate.text = "published ".localized + "\(data.data?.question_details?.question_custom_published_date ?? "") | " + "Modified ".localized + "\( data.data?.question_details?.question_custom_last_update_date ?? "")"
                
                self.AskDistance.text = data.data?.question_details?.question_description ?? ""
                self.AdvCommentCount.text = "( \(data.data?.comments_count ?? "") )"
                self.CommenstCount = Int(data.data?.comments_count ?? "") ?? 0
                
                self.CurrentPage = data.data?.comments_pagination?.last_page ?? 0
                self.lastPage = data.data?.comments_pagination?.current_page ?? 0
                
                
                if data.data?.comments_pagination?.has_more_pages == false {
                    
                    self.ShowMoreBtn.isHidden = true
                    
                }
                
                if self.imageUrl == "" {
                    self.AskImageHight.constant = 0
                }else{
                    self.AskImageHight.constant = 200
                }
                
                DispatchQueue.main.async {
                    self.CommentsTableView.reloadData()
                    self.tableviewhight.constant = self.CommentsTableView.contentSize.height
                    self.MainView.layoutIfNeeded()
                }
                self.CommentsTableView.reloadData()
                self.MainView.layoutIfNeeded()
                self.isActive = true
                
                self.MainView.isHidden = false
            }
        }
    }
    
    func ShowComment() {
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)show-question-comments/\(ask_id)?page=\(CurrentPage)") { (data : AllCommentModel?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                print(String!)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                self.CurrentPage = data.data?.pagination?.current_page ?? 1
                self.lastPage = data.data?.pagination?.last_page ?? 1
                
                for item in data.data?.data ?? [] {
                    self.CommentArray.append(item)
                }
                
                if data.data?.pagination?.has_more_pages == false {
                    self.ShowMoreBtn.isHidden = true
                }else{
                    self.ShowMoreBtn.isHidden = false
                }
                
                if self.CommentArray.count > 0 {
                    self.CommentsTableView.reloadData()
                    self.CommentsTableView.isHidden = false
                    self.tableviewhight.constant = self.CommentsTableView.contentSize.height
                    self.NoCommentLable.isHidden = true
                }else {
                    self.CommentsTableView.reloadData()
                    self.CommentsTableView.isHidden = true
                    self.NoCommentLable.isHidden = false
                    self.tableviewhight.constant = 50
                   
                }
                
               
                DispatchQueue.main.async {
                    self.CommentsTableView.reloadData()
                    self.tableviewhight.constant = self.CommentsTableView.contentSize.height
                    self.MainView.layoutIfNeeded()
                }
                self.CommentsTableView.reloadData()
                self.MainView.layoutIfNeeded()
                
                self.isActive = true
                
                print(data)
            }
        }
    }
    
    func NewComment(Ask_id : String , CommentText : String) {
        
        let Parameters = [
            "question_id" : Ask_id,
            "comment" : CommentText ?? ""
        ] as [String : Any]
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)question-operations/add-comment") { (data : SingleCommentModel?, String) in
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            } else {
                
                guard let data = data else {
                    return
                }
                self.CommenstCount += 1
                self.AdvCommentCount.text = "( \(self.CommenstCount) )"
                
                self.NoCommentLable.isHidden = true
                self.CommentsTableView.isHidden = false
                
                self.CurrentPage = 1
                self.CommentArray.removeAll()
                
                self.ShowComment()
                
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
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                self.CommenstCount -= 1
                self.AdvCommentCount.text = "( \(self.CommenstCount) )"
                
                if self.CommentArray.count == 0 {
                    self.CommentsTableView.isHidden = true
                    self.NoCommentLable.isHidden = false
                }else{
                    self.CommentsTableView.isHidden = false
                    self.NoCommentLable.isHidden = true
                }
                
                self.CurrentPage = 1
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
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)business/question-add-or-update-reply-on-comment") { (data : Level_6_Model?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.CurrentPage = 1
                self.CommentArray.removeAll()
                
                self.ShowComment()
                
                print(data)
            }
        }
    }
    
}
