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
    
    @IBOutlet weak var EditView: UIView!
    
    @IBOutlet weak var TableView: UITableView!
    
    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var NoCommentLable: UILabel!
    @IBOutlet weak var MainView: UIScrollView!
    @IBOutlet weak var askId: UILabel!
    @IBOutlet weak var askImage: UIImageView!
    @IBOutlet weak var OtherName: UILabel!
    @IBOutlet weak var askTitle: UILabel!
    @IBOutlet weak var askDate: UILabel!
    @IBOutlet weak var askDes: UILabel!
    @IBOutlet weak var ShowMoreBtn: UIButton!
    
    @IBOutlet weak var CommentBtn: UIButton!
    @IBOutlet weak var DetailsView: UIView!
    
    @IBOutlet weak var topView: NSLayoutConstraint!
    @IBOutlet weak var CommentCount: UILabel!
    @IBOutlet weak var ScrollView: NSLayoutConstraint!
    @IBOutlet weak var titleHight: NSLayoutConstraint!
    
    var CommentArray : [Comments_data] = []
    
    @IBOutlet weak var AddCommentTV: UITextView!
    
    @IBOutlet weak var CommentView: UIView!
    @IBOutlet weak var CommentViewHeight: NSLayoutConstraint!
    
    var asker_id = ""
    var imageUrl = ""
    var CommentState = false
    
    var isActive = true
    var CommenstCount = 0
    
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
    
    
    var ask_id = ""
    var height = 200
    var isMyAsks = 0
    
    var AskData : Question_details?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NoCommentLable.text = "No Commentns".localized
        askId.text = ask_id
        
        if DynamicLinkModel.isDynamic {
            self.ask_id = DynamicLinkModel.Product_id
        }
        
        tabBarController?.tabBar.isHidden = true
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: EditView, width: 1, height: 1, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        
        CommentView.alpha = 0
        CommentViewHeight.constant = 0
        
        TableView.dataSource = self
        TableView.delegate = self
        TableView.RegisterNib(cell: ReplayCommentCell.self)
        TableView.RegisterNib(cell: CommentWithReplayCell.self)
        TableView.RegisterNib(cell: CommentCellTableViewCell.self)
        
        AddCommentTV.delegate = self
        
        
        self.TableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.askDes.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.askTitle.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.askImage.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
        if L102Language.currentAppleLanguage() == "en" {
            AddCommentTV.text = "Your awnser"
            AddCommentTV.font = UIFont(name: "Tajawal-Regular", size: 16)
        }else {
            AddCommentTV.font = UIFont(name: "Tajawal-Regular", size: 16)
            AddCommentTV.text = "اجباتك"
        }
        
        AddCommentTV.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAskDetails()
        ShowComment()
        EditView.isHidden = true
        MainView.isHidden = true
        
        if isMyAsks == 1 {
            
        }else{
            
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        
        
        TableView.layer.removeAllAnimations()
        askDes.layer.removeAllAnimations()
        askTitle.layer.removeAllAnimations()
        
        
        
        if imageUrl == "" {
            imageHeight.constant = 0
            titleHight.constant = askTitle.intrinsicContentSize.height
            topView.constant = askDes.intrinsicContentSize.height + titleHight.constant + 240
        }else{
            imageHeight.constant = 200
            titleHight.constant = askTitle.intrinsicContentSize.height
            topView.constant = askDes.intrinsicContentSize.height + titleHight.constant + 440
        }
        
        ScrollView.constant = TableView.contentSize.height + topView.constant + 190 + CommentViewHeight.constant
        
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
            self.loadViewIfNeeded()
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if AddCommentTV.textColor == #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5) {
            AddCommentTV.text = ""
            AddCommentTV.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 1)
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        
        
        if DynamicLinkModel.isDynamic {
            DynamicLinkModel.isDynamic = false
            guard let window = UIApplication.shared.keyWindow else{return}
            let sb = UIStoryboard(name: Home, bundle: nil)
            var vc : UIViewController
            vc = sb.instantiateViewController(withIdentifier: "HomeVC")
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
            
        }
        
        navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
        
    }
    
    @IBAction func ImageAction(_ sender: Any) {
    
        Helper.openZoomAbleImage(image: askImage.image ?? UIImage(), vc: self)
        
    }
    
    @IBAction func shareAction(_ sender: Any) {
        let longLinkUrl = "https://askHail.page.link/?link=4\(self.ask_id)"
        
        DynamicLinkComponents.shortenURL(URL(string: longLinkUrl)!, options: nil) { shortUrl, warnings, error in
            if error != nil{
                let shareText = "\(self.askTitle.text ?? "")" + "\n" + longLinkUrl
                let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
                if(UIDevice.current.userInterfaceIdiom == .pad){
                    vc.popoverPresentationController?.sourceView = self.view
                }else{
                    self.present(vc, animated: true, completion: {})
                }
            }
            guard let url = shortUrl, error == nil else { return }
            print("The short URL is: \(shortUrl)")
            let shareText = "See the product on the AskHail store" + "\n" + "\(shortUrl!)"
            let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
            if(UIDevice.current.userInterfaceIdiom == .pad){
                vc.popoverPresentationController?.sourceView = self.view
            }else{
                self.present(vc, animated: true, completion: {})
            }
        }
        
        print("Share")
    }
    
    
    
    @IBAction func AddComment(_ sender: Any) {
        
        guard Helper.getapitoken() != nil else {
            
            alertSkipLogin()
            return
        }
        
        if CommentState == false{
            CommentState = true
            
            if L102Language.currentAppleLanguage() == "en" {
                AddCommentTV.text = "Add New Comment"
                AddCommentTV.font = UIFont(name: "Tajawal-Regular", size: 16)
            }else {
                AddCommentTV.text = "اضافة تعليق جديد"
                AddCommentTV.font = UIFont(name: "Tajawal-Regular", size: 16)
            }
            AddCommentTV.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5)
            
            UIView.animate(withDuration: 0.6, animations: {
                
                self.CommentViewHeight.constant = 172
                self.CommentView.alpha = 1
                self.TableView.reloadData()
                
            }, completion: { _ in
                
                UIView.animate(withDuration: 0.3, animations: {
                    
                }, completion: { _ in
                    
                })
            })
            
            CommentBtn.setTitle("Cancel".localized, for: .normal)
        }else{
            
            CommentState = false
            UIView.animate(withDuration: 0.3, animations: {
                self.CommentViewHeight.constant = 0
                self.CommentView.alpha = 0
                self.TableView.reloadData()
                
                
            }, completion: { _ in
                UIView.animate(withDuration: 0.3, animations: {
                    
                }, completion: { _ in
                    
                    
                })
            })
            CommentBtn.setTitle("Add comment".localized.localized, for: .normal)
            
        }
    }
    
    @IBAction func AddNewComment(_ sender: Any) {
        
        if AddCommentTV.text == "اضافة تعليق جديد" || AddCommentTV.text == "" || AddCommentTV.text == "" {
            self.navigationController?.view.makeToast( "enter comment first".localized)

        }else {
            NewComment()
        }
        
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
    
    @IBAction func ShoeMoreCommentAction(_ sender: Any) {
        
        
        if isActive {
            print("Done")
            isActive = false
            
            
            if CurrentPage < lastPage {
                
                CurrentPage = CurrentPage + 1
                
                self.getAskDetails()
                
            }
            self.TableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        }
    }
    
}

//MARK:Popup Protocol

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

//MARK: Comment TableView Controller

extension AskHailDetailsVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Model = CommentArray[indexPath.row]
        if Model.comment_if_advertiser_reply_yet == true {
            
            let cell = tableView.dequeue() as CommentWithReplayCell
            
            cell.CommentName.text = Model.comment_voter_name ?? "" + "say".localized
            cell.CommentTime.text = Model.comment_text_custom_date ?? ""
            cell.CommentText.text = Model.comment_text ?? ""
            
            cell.CommentReplayName.text = "Advertiser's answer".localized
            cell.CommentReplayText.text = Model.comment_advertiser_reply ?? ""
            cell.CommentReplayTime.text = Model.comment_advertiser_reply_custom_date ?? ""
            
            cell.DeleteHight.constant = 0
            
            if "\(AskData?.question_advertiser_id ?? 0)" == Helper.getaUser_id(){
                cell.DeleteHight.constant = 0
                cell.Deletbtn.isHidden = true
                
            }else{
                if "\(Model.comment_voter_id ?? 0)" == Helper.getaUser_id() {
                    cell.Deletbtn.isHidden = true
                    cell.DeleteHight.constant = 0
                }else{
                    cell.Deletbtn.isHidden = false
                    cell.DeleteHight.constant = 24
                }
            }
            
            cell.DeletComment = {
                self.RemoveComment(id: Model.comment_id ?? 0)
                self.CommentArray.remove(at: indexPath.row)
                self.TableView.reloadData()
            }
            
            return cell
            
        }else{
            
            if asker_id == Helper.getaUser_id() {
                
                let cell = tableView.dequeue() as ReplayCommentCell
                
                cell.CommentName.text = Model.comment_voter_name ?? ""
                cell.CommentText.text = Model.comment_text ?? ""
                cell.CommentTime.text = Model.comment_text_custom_date ?? ""
                
                cell.ShowReplay = {
                    self.TableView.reloadData()
                }
                
                cell.AddReplay = {
                    self.AddReplay(text: cell.AddCommentTV.text, id: "\(self.CommentArray[indexPath.row].comment_id ?? 0)", index: indexPath.row)
                    self.TableView.reloadData()
                }
                
                return cell
                
            }else{
                
                let cell = tableView.dequeue() as CommentCellTableViewCell
                
                cell.CommentName.text = Model.comment_voter_name ?? ""
                cell.CommentText.text = Model.comment_text ?? ""
                cell.CommentTime.text = Model.comment_text_custom_date ?? ""
                

                
               
                    if "\(Model.comment_voter_id ?? 0)" == Helper.getaUser_id() {
                        cell.Deletbtn.isHidden = false
                        cell.DeleteBtnHight.constant = 24
                    }else{
                        cell.Deletbtn.isHidden = true
                        cell.DeleteBtnHight.constant = 0
                    }
                
                cell.DeletComment = {
                    self.RemoveComment(id: Model.comment_id ?? 0)
                    self.CommentArray.remove(at: indexPath.row)
                    self.TableView.reloadData()
                    
                }
                
                return cell
            }
            
        }
    }
    
    
}


//MARK:API
extension AskHailDetailsVC {
    
    func getAskDetails() {
        
        self.view.lock()

        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)show-question/\(ask_id)") { [self] (data : ShowAskDetailsModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                                
                self.AskData = data.data?.question_details
                
                self.asker_id = "\(data.data?.question_details?.question_advertiser_id ?? 0)"
                
                if "\(AskData?.question_advertiser_id ?? 0)" == Helper.getaUser_id() {
                    self.EditView.isHidden = false
                    self.CommentBtn.isHidden = true
                }else{
                    if self.isMyAsks == 1 {
                        self.EditView.isHidden = false
                        self.isMyAsks = 0
                    }else{
                        self.EditView.isHidden = false
                    }
                }
                
                self.askId.text = "\(data.data?.question_details?.question_id ?? 0)"
                
                self.askImage.loadImage(URL(string: data.data?.question_details?.question_image ?? ""))
                self.imageUrl = data.data?.question_details?.question_image ?? ""
                print(self.imageUrl)
                
                self.OtherName.text = data.data?.question_details?.question_advertiser_name
                
                self.OtherName.isHidden = true
                
                if data.data?.question_details?.question_show_name_status == "active" {
                    self.OtherName.isHidden = false
                }
                
                
                self.askTitle.text = data.data?.question_details?.question_title ?? ""
                
                self.askDate.text = "published ".localized + "\(data.data?.question_details?.question_custom_published_date ?? "") | " + "Modified ".localized + "\( data.data?.question_details?.question_custom_last_update_date ?? "")"
                
                self.askDes.text = data.data?.question_details?.question_description ?? ""
                self.CommentCount.text = "( \(data.data?.comments_count ?? "") )"
                self.CommenstCount = Int(data.data?.comments_count ?? "") ?? 0
                
                self.CurrentPage = data.data?.comments_pagination?.last_page ?? 0
                self.lastPage = data.data?.comments_pagination?.current_page ?? 0
                
                
                if data.data?.comments_pagination?.has_more_pages == false {
                    
                    self.ShowMoreBtn.isHidden = true
                    
                }
                
                self.TableView.layer.removeAllAnimations()
                self.askDes.layer.removeAllAnimations()
                self.askTitle.layer.removeAllAnimations()
                
                
                
                if self.imageUrl == "" {
                    self.imageHeight.constant = 0
                    self.titleHight.constant = self.askTitle.intrinsicContentSize.height
                    self.topView.constant = self.askDes.intrinsicContentSize.height + self.titleHight.constant + 240
                }else{
                    self.imageHeight.constant = 200
                    self.titleHight.constant = self.askTitle.intrinsicContentSize.height
                    self.topView.constant = self.askDes.intrinsicContentSize.height + self.titleHight.constant + 440
                }
                
                self.ScrollView.constant = self.TableView.contentSize.height + self.topView.constant + 190 + self.CommentViewHeight.constant
                
                UIView.animate(withDuration: 0.5) {
                    self.updateViewConstraints()
                    self.loadViewIfNeeded()
                }

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
                    
                }
                
                if data.data?.data?.count ?? 0 == 0 {
                    self.NoCommentLable.isHidden = false
                    self.TableView.isHidden = true
                }else{
                    self.NoCommentLable.isHidden = true
                    self.TableView.isHidden = false
                }
                
                self.TableView.reloadData()
                self.isActive = true
                
                print(data)
            }
        }
    }
    
    func NewComment() {
        
        let Parameters = [
            "question_id" : ask_id,
            "comment" : AddCommentTV.text ?? ""
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
                
                
                
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.CommentViewHeight.constant = 0
                    self.CommentView.alpha = 0
                    self.TableView.reloadData()
                    
                    
                }, completion: { _ in
                    UIView.animate(withDuration: 0.3, animations: {
                        
                    }, completion: { _ in
                        
                        
                    })
                })
                
                
                guard let model = data.data?.comment else {
                    return
                }
                
                self.CommentArray.insert(model, at: 0)
                
                self.CommenstCount += 1
                self.CommentCount.text = "( \(self.CommenstCount) )"
                self.NoCommentLable.isHidden = true
                self.TableView.isHidden = false
                
                self.CommentBtn.setTitle("Add comment".localized.localized, for: .normal)
                
                
                self.NoCommentLable.isHidden = true
                self.TableView.reloadData()
                
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
                self.CommentCount.text = "( \(self.CommenstCount) )"
                
                if self.CommentArray.count == 0 {
                    self.TableView.isHidden = true
                    self.NoCommentLable.isHidden = false
                }else{
                    self.TableView.isHidden = false
                    self.NoCommentLable.isHidden = true
                }
                
                self.TableView.reloadData()
                
                print(data)
                
            }
        }
    }
    
    func AddReplay(text : String , id : String , index : Int) {
        
        let Parameters = [
            "comment_id" : id,
            "reply" : text
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)business/question-add-or-update-reply-on-comment") { (data : Level_6_Model?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                self.CommentArray[index].comment_if_advertiser_reply_yet = true
                self.CommentArray[index].comment_advertiser_reply = text
                self.TableView.reloadData()
                
                
                print(data)
            }
        }
    }
    
}
