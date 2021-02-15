//
//  MyAdsDetailsVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/12/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import FSPagerView

class MyAdsDetailsVC: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate, UITextViewDelegate {
    
    var isSaved = false
    
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var WhatsBtn: UIButton!
    @IBOutlet weak var MapView: UIView!
    
    @IBOutlet weak var ScrollView: NSLayoutConstraint!
    
    @IBOutlet weak var PagerView: FSPagerView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var DetailsView: UIView!
    
    @IBOutlet weak var AddNumber: UILabel!
    @IBOutlet weak var StarAdsView: UIView!
    
    @IBOutlet weak var SaveBtn: UIButton!
    
    @IBOutlet weak var AdsTitle: UILabel!
    @IBOutlet weak var AdsPrice: UILabel!
    @IBOutlet weak var AdsDistance: UILabel!
    @IBOutlet weak var AdsViewNumber: UILabel!
    @IBOutlet weak var AdsDateAndTime: UILabel!
    @IBOutlet weak var AdNumber: UILabel!
    
    @IBOutlet weak var checkBoxBtn: UIButton!

    @IBOutlet weak var AdsDescribe: UILabel!
    @IBOutlet weak var PlaceSpace: UILabel!
    @IBOutlet weak var Elmostah: UILabel!
    @IBOutlet weak var Direction: UILabel!
    @IBOutlet weak var Floors: UILabel!
    @IBOutlet weak var Rooms: UILabel!
    @IBOutlet weak var bathrooms: UILabel!
    
    @IBOutlet weak var Address: UILabel!
    
    @IBOutlet weak var CommentView: UIView!
    @IBOutlet weak var CommentViewHeight: NSLayoutConstraint!

    
    @IBOutlet weak var OtherName: UILabel!
    @IBOutlet weak var NuberOfAds: UILabel!
    
    @IBOutlet weak var NumberOfComment: UILabel!
    
    @IBOutlet weak var CommentTableView: UITableView!
    @IBOutlet weak var AddCommentTV: UITextView!

    var phoneNumber = ""
    var whatsNumber = ""
    
    var AdData : ShowAdData?
    var media = [Adv_media]()
    var ComentData = false
    
    var AdId = ""
    var CommentArray : [Comments_data] = []
    var checkBox = false
    
    var lang = ""
    var lat = ""
    
    var WhatsApp = ""
    
    var whatsState = ""
    var callState = ""
    
    var User_id = 0
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
        
        
        
        lang = AdData?.advertisement_details?.adv_latitude ?? ""
        lat = AdData?.advertisement_details?.adv_latitude ?? ""
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = media.count
        
        CommentViewHeight.constant = 0
        CommentView.alpha = 0
        
        CommentTableView.delegate = self
        CommentTableView.dataSource = self
        
        CommentTableView.RegisterNib(cell: ReplayCommentCell.self)
        CommentTableView.RegisterNib(cell: CommentWithReplayCell.self)
        
        PagerView.dataSource = self
        PagerView.delegate = self
        AddCommentTV.delegate = self
        PagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        
        
        PagerView.isInfinite = true
        PagerView.addSubview(pageControl)
        PagerView.addSubview(StarAdsView)
        PagerView.itemSize = CGSize(width: PagerView.frame.size.width, height: PagerView.frame.size.height)
        PagerView.transformer = FSPagerViewTransformer(type: .linear)
        
        PagerView.automaticSlidingInterval = 3.0
        
        print(DetailsView.frame.height)
        
        self.CommentTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
        if L102Language.currentAppleLanguage() == "en" {
            AddCommentTV.text = "Add New Comment"
            
        }else {
            
            AddCommentTV.text = "اضافة تعليق جديد"
        }
        
        AddCommentTV.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAdData()
        ShowComment()
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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        CommentTableView.layer.removeAllAnimations()
        ScrollView.constant = CommentTableView.contentSize.height + DetailsView.frame.height + 1200
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
            self.loadViewIfNeeded()
        }
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return media.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        pageControl.currentPage = index
        
        cell.imageView?.loadImage(URL(string: media[index].media_image ?? ""))
        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
        if media[index].media_video != "" {
            
            let storyboard = UIStoryboard(name: Home, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "OpenViewVC") as! OpenViewVC
            vc.videoUrl = media[index].media_video
            present(vc, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        guard let window = UIApplication.shared.keyWindow else{return}
        let sb = UIStoryboard(name: Home, bundle: nil)
        var vc : UIViewController
        vc = sb.instantiateViewController(withIdentifier: "HomeVC")
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        
    }
    
    @IBAction func SaveAction(_ sender: Any) {
        
        AddToFavourite(advertisement_id: AdId)
        
        if isSaved == false{
            SaveBtn.setImage(#imageLiteral(resourceName: "save_white-1"), for: .normal)
            isSaved = true
        }else{
            SaveBtn.setImage(#imageLiteral(resourceName: "save"), for: .normal)
            isSaved = false
        }
        
    }
    
    @IBAction func ShareAdsAction(_ sender: Any) {
        
        print("Share")
        
    }
    
    @IBAction func PromotionalPhotoAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: BusinessAds, bundle: nil)
        
        let vc  = storyboard.instantiateViewController(withIdentifier: "BusinessAdsPopUpVC") as! BusinessAdsPopUpVC
        print(AdData?.advertisement_details?.adv_promotional_image ?? "")
        
        vc.image = AdData?.advertisement_details?.adv_promotional_image ?? ""
        vc.modalPresentationStyle = .fullScreen
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
    @IBAction func GoNowAction(_ sender: Any) {
        
    }
    
    @IBAction func PhoneCallAcion(_ sender: Any) {
                
        if callState == "active"{
            MakeCall(number: phoneNumber)
        }else{
            self.showAlertWithTitle(title: "Not Allaw", message: "It is not possible to communicate with him via phone call", type: .warning)
        }
        
    }
    
    @IBAction func WhatsAppAction(_ sender: Any) {
        
        if whatsState == "active"{
            OpenWhatsApp(number: whatsNumber)
        }else{
            self.showAlertWithTitle(title: "Not Allaw", message: "It is not possible to communicate with him via WhatsApp", type: .warning)
        }
        
        
    }
    
    @IBAction func ChatAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Chat, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "chatVC") as! chatVC
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func OtherProfileAction(_ sender: Any) {
        
    }
    
    @IBAction func SeeMoreCommentAction(_ sender: Any) {
        
        if isActive {
                print("Done")
                isActive = false
             
            
                if CurrentPage < lastPage {
                    
                    CurrentPage = CurrentPage + 1
                    
                    self.ShowComment()
                    
                }
            self.CommentTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        }
        
    }
    
    @IBAction func StarAdsAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: StarAds, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "StarAdsVC") as! StarAdsVC
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func EditAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: EditAds_Story , bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "EditAdsPopUpVC") as! EditAdsPopUpVC
        vc.deleget = self
        vc.modalPresentationStyle = .fullScreen
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
    @IBAction func DisableAdsAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: EditAds_Story , bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "DisableAdsPopUpVC") as! DisableAdsPopUpVC
        vc.Ad_id = AdData?.advertisement_details?.adv_id ?? 0
        vc.modalPresentationStyle = .fullScreen
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
    
    @IBAction func DeletAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: MyProfile , bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "DeletePopUpVC") as! DeletePopUpVC
        vc.Ad_Id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
        //vc.deleget = self
        vc.modalPresentationStyle = .fullScreen
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
    
    @IBAction func AddComment(_ sender: Any) {
        
        if L102Language.currentAppleLanguage() == "en" {
            AddCommentTV.text = "Add New Comment"
            
        }else {
            
            AddCommentTV.text = "اضافة تعليق جديد"
        }
        
        AddCommentTV.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5)
        
        UIView.animate(withDuration: 0.6, animations: {
            
            self.CommentViewHeight.constant = 172
            self.CommentView.alpha = 1
            self.CommentTableView.reloadData()
            
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.3, animations: {
                
            }, completion: { _ in
                
            })
        })
    }
    
    
    @IBAction func AddNewComment(_ sender: Any) {
        
        //NewComment()
        
    }
    
    
}

//MARK:-TableView Contol

extension MyAdsDetailsVC : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Model = CommentArray[indexPath.row]
        
        if Model.comment_if_advertiser_reply_yet == true {
            
            let cell_2 = tableView.dequeue() as CommentWithReplayCell
            cell_2.CommentName.text = Model.comment_voter_name ?? ""
            cell_2.CommentText.text = Model.comment_text ?? ""
            cell_2.CommentTime.text = Model.comment_text_custom_date ?? ""
            cell_2.CommentReplayText.text = Model.comment_advertiser_reply ?? ""
            cell_2.CommentReplayTime.text = Model.comment_advertiser_reply_custom_date ?? ""
            cell_2.DeleteHight.constant = 0
            cell_2.Deletbtn.isHidden = true
            print(Model.comment_id)
            
            return cell_2
            
        } else {
            
            let cell = tableView.dequeue() as ReplayCommentCell
            cell.CommentName.text = Model.comment_voter_name ?? ""
            cell.CommentText.text = Model.comment_text ?? ""
            cell.CommentTime.text = Model.comment_text_custom_date ?? ""
            
            cell.ShowReplay = {
                
                self.CommentTableView.reloadData()
            }
            
            cell.AddReplay = {
                self.AddReplay(text: cell.AddCommentTV.text, id: "\(self.CommentArray[indexPath.row].comment_id ?? 0)", index: indexPath.row)
                self.CommentTableView.reloadData()
            }
            
            return cell
            
        }
    }
    
    
}

//MARK:-Edit Section

extension MyAdsDetailsVC : selectEditSection {
    func SelectEdit(select: Int) {
        
        if select == 0 {
            
            let storyboard = UIStoryboard(name: EditAds_Story , bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "EditCategoryVC") as! EditCategoryVC
            vc.Ad_id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
            navigationController?.pushViewController(vc, animated: true)
            
        }else if select == 1 {
            
            let storyboard = UIStoryboard(name: EditAds_Story , bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "EditImageVC") as! EditImageVC
                  vc.Ad_id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
            navigationController?.pushViewController(vc, animated: true)
            
            
        }
        else if select == 2 {
            
            let storyboard = UIStoryboard(name: EditAds_Story , bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "EditDetailsVD") as! EditDetailsVD
            vc.Ad_id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
            vc.CurrentFeatureArray = AdData?.advertisement_details?.adv_specifications ?? []
            navigationController?.pushViewController(vc, animated: true)
            
        }else if select == 3 {
            
            let storyboard = UIStoryboard(name: EditAds_Story , bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "EditContactWayVC") as! EditContactWayVC
            vc.Ad_id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
            navigationController?.pushViewController(vc, animated: true)
            
            
        }
    }
}


//MARK:-API

extension MyAdsDetailsVC {
    
    func getAdData() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)show-advertisement/\(AdId)") { (data : ShowAdModel?, String) in
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            } else {
                
                guard let data = data else {
                    return
                }
                
                self.AdData = data.data
                self.media = data.data?.advertisement_details?.adv_media ?? []
                
                self.isSaved = data.data?.advertisement_details?.adv_is_favorite ?? false
                self.AdNumber.text = "  \(data.data?.advertisement_details?.adv_id ?? 0)".localized
                self.AdsTitle.text = data.data?.advertisement_details?.adv_title ?? ""
                self.AdsPrice.text = data.data?.advertisement_details?.adv_price ?? ""
                self.AdsDescribe.text = data.data?.advertisement_details?.adv_distance ?? ""
                self.AdsViewNumber.text = data.data?.advertisement_details?.adv_views ?? ""
                self.AdsDateAndTime.text = "\(data.data?.advertisement_details?.adv_custom_published_date ?? "") \( data.data?.advertisement_details?.adv_custom_last_update_date ?? "")"
                self.AdsDescribe.font = UIFont(name: "Tajawal-Regular", size: 16)
                self.AdsDescribe.text = data.data?.advertisement_details?.adv_description ?? ""
                self.Address.text = data.data?.advertisement_details?.adv_location ?? ""
                self.OtherName.text = data.data?.advertisement_details?.adv_advertiser_name ?? ""
                self.NuberOfAds.text = data.data?.advertisement_details?.adv_advertiser_advs_count ?? ""
                self.NumberOfComment.text = "( \(data.data?.comments_count ?? "") )"

                
                self.phoneNumber = data.data?.advertisement_details?.adv_call_number ?? ""
                self.whatsNumber = data.data?.advertisement_details?.adv_whatsapp_number ?? ""
                
                self.callState = data.data?.advertisement_details?.adv_call_number_status ?? ""
                self.whatsState = data.data?.advertisement_details?.adv_whatsapp_number_status ?? ""
                                
                self.checkBoxBtn.setImage(#imageLiteral(resourceName: "save"), for: .normal)
                
                if data.data?.advertisement_details?.adv_is_favorite == true {
                    
                    self.checkBoxBtn.setImage(#imageLiteral(resourceName: "save_white-1"), for: .normal)
                    self.isSaved = true
                    
                } else {
                    
                    self.checkBoxBtn.setImage(#imageLiteral(resourceName: "save"), for: .normal)
                    self.isSaved = false
                    
                }
                
                
                self.StarAdsView.isHidden = true
                if data.data?.advertisement_details?.adv_special_status == "مميز" || data.data?.advertisement_details?.adv_special_status == "special" {
                    self.StarAdsView.isHidden = false
                } else {
                    self.StarAdsView.isHidden = true
                }
                
                self.ComentData = true
                self.PagerView.reloadData()
                
                print(data)
                
            }
        }
    }
    
    
    func ShowComment() {
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)show-advertisement-comments/\(AdId)?page=\(CurrentPage)") { (data : AllCommentModel?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
              
                self.CurrentPage = data.data?.pagination?.current_page ?? 1
                self.lastPage = data.data?.pagination?.last_page ?? 1
                
                for item in data.data?.data ?? [] {
                    self.CommentArray.append(item)
                }
                
                self.CommentTableView.reloadData()
                
                self.isActive = true
                
                print(data)
            }
        }
    }
    
    func AddReplay(text : String , id : String , index : Int) {
        
        let Parameters = [
            "comment_id" : id,
            "reply" : text
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)user/add-or-update-reply-on-comment") { (data : Level_6_Model?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                self.CommentArray[index].comment_if_advertiser_reply_yet = true
                self.CommentArray[index].comment_advertiser_reply = text
                self.CommentTableView.reloadData()
                
                
                print(data)
            }
        }
    }
    
    
    
    func AddToFavourite(advertisement_id : String) {
        
        let param = [
            "advertisement_id" : advertisement_id
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)advertisement-operations/add-remove-favorite") { (data : ContactUsModel?, String) in

            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                 return
                }
                
                print(data)
                
                
            }
        }
    }
}
