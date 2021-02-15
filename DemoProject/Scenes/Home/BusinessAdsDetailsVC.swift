//
//  BusinessAdsVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/6/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import FSPagerView
import Cosmos
import GoogleMaps
import GooglePlaces
import FirebaseDynamicLinks

class BusinessAdsDetailsVC: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
    
    // MARK:OutLet
    
    @IBOutlet weak var noSocialLabel: UILabel!
    
    @IBOutlet weak var EditView: UIView!
    @IBOutlet weak var StarBtn: UIImageView!
    @IBOutlet weak var MapIcon: UIImageView!
    @IBOutlet weak var AdsNumber: UILabel!
    @IBOutlet weak var imgVedio: UIImageView!
    @IBOutlet weak var PromotionalPhotoBtn: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var AdsTitle: UILabel!
    @IBOutlet weak var AdsRate: UILabel!
    @IBOutlet weak var AdsDisnatce: UILabel!
    @IBOutlet weak var ViewsNumber: UILabel!
    @IBOutlet weak var AdsDate: UILabel!
    @IBOutlet weak var AdvState: UILabel!
    @IBOutlet weak var AdvPrice: UILabel!
    @IBOutlet weak var TwitterLbl: UILabel!
    @IBOutlet weak var InstgrameLbl: UILabel!
    @IBOutlet weak var SnapLable: UILabel!
    @IBOutlet weak var FaceBookLbl: UILabel!
    @IBOutlet weak var WebSiteLbl: UILabel!
    @IBOutlet weak var AdsDescribtion: UILabel!
    @IBOutlet weak var Addess: UILabel!
    @IBOutlet weak var NumberOfComments: UILabel!
    @IBOutlet weak var TotalCommentsRate: UILabel!
    @IBOutlet weak var ScrollView: NSLayoutConstraint!
    @IBOutlet weak var StarAdsView: UIView!
    @IBOutlet weak var DetailsView: UIView!
    @IBOutlet weak var CommentsTableView: UITableView!
    @IBOutlet weak var PagerView: FSPagerView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var MainView: UIScrollView!
    @IBOutlet weak var ShowMoreBtn: UIButton!
    @IBOutlet weak var DetailsCollectionView: UICollectionView!
    @IBOutlet weak var featureHeight: NSLayoutConstraint!
    @IBOutlet weak var NoCommentLable: UILabel!
    @IBOutlet weak var CollectionBottomhight: NSLayoutConstraint!
    @IBOutlet weak var FeatuseTopTitle: UIStackView!
    
    @IBOutlet weak var SocialView: UIView!
    @IBOutlet weak var SocialViewHight: NSLayoutConstraint!
    @IBOutlet weak var SocialStackView: UIStackView!
    
    
    @IBOutlet weak var twitterView: UIView!
    @IBOutlet weak var instgrameView: UIView!
    @IBOutlet weak var snapChatView: UIView!
    @IBOutlet weak var facebookView: UIView!
    @IBOutlet weak var websiteView: UIView!
    
    var refreshControl = UIRefreshControl()
    
    var RateState = false
    var AdId = ""
    var RateArray : [Rates_data] = []
    var AdData : ShowBusinessAdvData?
    var FeatureArray : [Adv_specifications] = []
    var FeatureData = false
    var media = [Adv_media]()
    
    var lang = ""
    var lat = ""
    
    var WhatsApp = ""
    
    var phoneNumber = ""
    var callState = ""
    
    var whatsNumber = ""
    var whatsState = ""
    
    var CommentCount = 0
    
    var checkBox = false
    var RateData = false
    var isActive = true
    
    var isHome = 0
    var isProfile = 0
    
    var x = 0.0
    
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SocialStackView.layoutIfNeeded()
        MainView.isHidden = true
        CurrentPage = 1
        lastPage = 1
        RateArray.removeAll()
        getAdData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AdsNumber.text = "\(AdId)"
        NoCommentLable.text = "No rates".localized
        noSocialLabel.text = "No social media avilable".localized
        
        if  DynamicLinkModel.Product_id != "" {
            
            self.AdId = DynamicLinkModel.Product_id
            
            
        }
        
        setShadow(view: EditView, width: 1, height: 1, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        
        tabBarController?.tabBar.isHidden = true
        
        lang = AdData?.advertisement_details?.adv_latitude ?? ""
        lat = AdData?.advertisement_details?.adv_latitude ?? ""
        
        
        pageControl.currentPage = 0
        
        
        mapView.addSubview(MapIcon)
        CommentsTableView.delegate = self
        CommentsTableView.dataSource = self
        
        CommentsTableView.RegisterNib(cell: RateCell.self)
        
        PagerView.dataSource = self
        PagerView.delegate = self
        
        PagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        
        DetailsCollectionView.dataSource = self
        DetailsCollectionView.delegate = self
        DetailsCollectionView.RegisterNib(cell: ShowDetailsCell.self)
        DetailsCollectionView.flipX()
                
        PagerView.isInfinite = false
        PagerView.addSubview(pageControl)
        PagerView.addSubview(StarAdsView)
        PagerView.addSubview(imgVedio)
        PagerView.itemSize = CGSize(width: PagerView.frame.size.width, height: PagerView.frame.size.height)
        PagerView.transformer = FSPagerViewTransformer(type: .linear)
        
        PagerView.automaticSlidingInterval = 5.0
        
        print(DetailsView.frame.height)
        
        self.CommentsTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.DetailsCollectionView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.AdsDescribtion.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
        self.SocialView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        CommentsTableView.layer.removeAllAnimations()
        DetailsCollectionView.layer.removeAllAnimations()
        
        if PromotionalPhotoBtn.isHidden == true {
            featureHeight.constant = DetailsCollectionView.contentSize.height + 120 + AdsDescribtion.intrinsicContentSize.height
            CollectionBottomhight.constant = 0
        }else{
            featureHeight.constant = DetailsCollectionView.contentSize.height + 180 +  AdsDescribtion.intrinsicContentSize.height
            CollectionBottomhight.constant = 80
        }
        
        
        ScrollView.constant = CommentsTableView.contentSize.height + 900 + featureHeight.constant + SocialView.frame.height
        
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
        
        if media[index].media_video != "" {
            
            self.imgVedio.isHidden = false
        }else {
            self.imgVedio.isHidden = true
            
        }
        
        cell.imageView?.loadImage(URL(string: media[index].media_image ?? ""))
        cell.imageView?.contentMode = .scaleAspectFill
        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
        print(media)
        if media[index].media_video != "" {
            
            let storyboard = UIStoryboard(name: Home, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "OpenViewVC") as! OpenViewVC
            vc.modalPresentationStyle = .fullScreen
            vc.videoUrl = media[index].media_video
            present(vc, animated: true, completion: nil)
            
        }else {
            
            var imageV = UIImageView()
            imageV.loadImage(URL(string: media[index].media_image ?? ""))
            
            Helper.openZoomAbleImage(image: imageV.image ?? UIImage(), vc: self)
            
        }
    }
    
    func CreateMarker(Lat : Double , lng : Double){
        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude:Lat, longitude: lng)
//        //        marker.title = "Sydney"
//        //        marker.snippet = "Australia"
//        marker.map = mapView
        let cameraPosition = GMSCameraPosition.camera(withLatitude: Lat, longitude: lng, zoom: 15.0)
        mapView.animate(to: cameraPosition)
        
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

            navigationController?.popViewController(animated: true)

    }
    
    @IBAction func ShareAds(_ sender: Any) {

        let longLinkUrl = "https://askhail.page.link/?link=1\(self.AdId)"

        DynamicLinkComponents.shortenURL(URL(string: longLinkUrl)!, options: nil) { shortUrl, warnings, error in
            if error != nil{
                let shareText = "\(self.AdsTitle.text ?? "")" + "\n" + longLinkUrl
                let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
                if(UIDevice.current.userInterfaceIdiom == .pad){
                    vc.popoverPresentationController?.sourceView = self.view
                }else{
                    self.present(vc, animated: true, completion: {})
                }
            }
            guard let url = shortUrl, error == nil else { return }
            print("The short URL is: \(shortUrl)")
            let shareText = "See the product on the askHailBusiness store" + "\n" + "\(shortUrl!)"
            let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
            if(UIDevice.current.userInterfaceIdiom == .pad){
                vc.popoverPresentationController?.sourceView = self.view
            }else{
                self.present(vc, animated: true, completion: {})
            }
        }

        print("Share")

    }
    
    @IBAction func Photogrphe(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: BusinessAds, bundle: nil)
        
        let vc  = storyboard.instantiateViewController(withIdentifier: "BusinessAdsPopUpVC") as! BusinessAdsPopUpVC
        vc.modalPresentationStyle = .fullScreen
        vc.image = AdData?.advertisement_details?.adv_promotional_image ?? ""
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
    @IBAction func ContactTwitterAcction(_ sender: Any) {
        openUrl(link: TwitterLbl.text ?? "")
    }
    
    @IBAction func ContactInstgrameAction(_ sender: Any) {
        openUrl(link: InstgrameLbl.text ?? "")
    }
    
    
    @IBAction func ConractSnapAction(_ sender: Any) {
        openUrl(link: SnapLable.text ?? "")
    }
    
    @IBAction func ContactFaceBookAction(_ sender: Any) {
        openUrl(link: FaceBookLbl.text ?? "")
    }
    
    @IBAction func WebSiteAction(_ sender: Any) {
        openUrl(link: WebSiteLbl.text ?? "")
        
    }
    
    @IBAction func GoToPlaceAction(_ sender: Any) {
        
        UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=\(Double(AdData?.advertisement_details?.adv_latitude ?? "") ?? 0.0),\(Double(AdData?.advertisement_details?.adv_longitude ?? "") ?? 0.0)&zoom=14&views=traffic")!, options: [:], completionHandler: nil)
        
        
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


    @IBAction func StarAdsAction(_ sender: Any) {
        if  AdData?.advertisement_details?.adv_special_status == "مميز" || AdData?.advertisement_details?.adv_special_status == "special" {
            
            let storyboard = UIStoryboard(name: Home, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "StarAdDetailsVC") as! StarAdDetailsVC
            vc.Ad_id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
            navigationController?.pushViewController(vc, animated: true)
        }else{
            
            if AdData?.advertisement_details?.isWaiting == true{
                let storyboard = UIStoryboard(name: Home, bundle: nil)
                
                let vc  = storyboard.instantiateViewController(withIdentifier: "StarAdDetailsVC") as! StarAdDetailsVC
                vc.Ad_id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
                navigationController?.pushViewController(vc, animated: true)
                
                
            }else {
                
                let storyboard = UIStoryboard(name: StarAds, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "StarAdsVC") as! StarAdsVC
                vc.Ad_id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
                navigationController?.pushViewController(vc, animated: true)
                
            }
            
        }

    }


    @IBAction func StateAvtion(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "AdvStateVC") as! AdvStateVC
        vc.Ad_id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
        navigationController?.pushViewController(vc, animated: true)

    }
    
    
    
  }

//MARK:- TableView Contoller
extension BusinessAdsDetailsVC : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  RateArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as RateCell
        
        if RateData {
            
            var Model = RateArray[indexPath.row]
            
            cell.CellName.text = "... \(Model.rate_voter_name ?? "")" + " Rated".localized
            cell.CellTime.text = Model.rate_custom_date ?? ""
            cell.CellRate.rating = Model.rate ?? 0.0
            
        }
        
        return cell
    }
    
}

//MARK:- CollectionView Controller
extension BusinessAdsDetailsVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FeatureArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowDetailsCell", for: indexPath) as! ShowDetailsCell
        
        if FeatureData {
            let Model = FeatureArray[indexPath.row]
            
            cell.CellTitle.text = Model.specification_section_feature?.feature_name ?? ""
            
            
        }
        
        cell.flipX()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (collectionView.frame.width - 16)/3
            return CGSize.init(width: width , height:46)
    }
    
}

//MARK:- Edit Section

extension BusinessAdsDetailsVC : selectEditSection {
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
            navigationController?.pushViewController(vc, animated: true)

        }else if select == 3 {

            let storyboard = UIStoryboard(name: EditAds_Story , bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "EditContactWayVC") as! EditContactWayVC
            vc.Ad_id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
            navigationController?.pushViewController(vc, animated: true)
        }else if select == 4 {

            let storyboard = UIStoryboard(name: EditAds_Story , bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "EditSocialMediaVC") as! EditSocialMediaVC
            vc.Ad_id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
            navigationController?.pushViewController(vc, animated: true)


        }
    }
}

//MARK: - Api
extension BusinessAdsDetailsVC {
    
    func getAdData() {
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)show-advertisement/\(AdId)") { (data : ShowBusinessAdvModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            } else {
                
                guard let data = data else {
                    return
                }
                
                self.AdData = data.data
                
                self.media = data.data?.advertisement_details?.adv_media ?? []
                
                self.AdsNumber.text = "  \(data.data?.advertisement_details?.adv_id ?? 0)".localized
                self.AdsTitle.text = data.data?.advertisement_details?.adv_title ?? ""
                self.AdvPrice.text = data.data?.advertisement_details?.adv_price ?? ""
                self.AdsDisnatce.text = data.data?.advertisement_details?.adv_distance ?? ""
                print(data.data?.advertisement_details?.adv_distance ?? "")
                self.ViewsNumber.text = data.data?.advertisement_details?.adv_views ?? ""
                
                self.AdsDate.text = "published ".localized + "\(data.data?.advertisement_details?.adv_custom_published_date ?? "") | " + "Modified ".localized + "\( data.data?.advertisement_details?.adv_custom_last_update_date ?? "")"
                
                self.AdsDescribtion.font = UIFont(name: "Tajawal-Regular", size: 16)
                self.AdsDescribtion.text = data.data?.advertisement_details?.adv_description ?? ""
                self.Addess.text = data.data?.advertisement_details?.adv_location ?? ""
                
                self.NumberOfComments.text = data.data?.rates_count ?? ""
                
                self.x = Double(data.data?.advertisement_details?.adv_total_rate ?? "") ?? 0.0
                let net = Double(round(100*self.x)/100)
                
                self.AdsRate.text = "\(net)"
                
                if data.data?.advertisement_details?.adv_twitter ?? "" != ""{
                    self.TwitterLbl.text = data.data?.advertisement_details?.adv_twitter ?? ""
                    self.twitterView.isHidden = false
                }else{
                    self.twitterView.isHidden = true
                }
                
                if data.data?.advertisement_details?.adv_instagram ?? "" != ""{
                    self.InstgrameLbl.text = data.data?.advertisement_details?.adv_instagram ?? ""
                    self.instgrameView.isHidden = false
                }else{
                    self.instgrameView.isHidden = true
                }
                
                if data.data?.advertisement_details?.adv_snapchat ?? "" != ""{
                    self.SnapLable.text = data.data?.advertisement_details?.adv_snapchat ?? ""
                    self.snapChatView.isHidden = false
                }else{
                    self.snapChatView.isHidden = true
                }
                
                if data.data?.advertisement_details?.adv_facebook ?? "" != ""{
                    self.FaceBookLbl.text = data.data?.advertisement_details?.adv_facebook ?? ""
                    self.facebookView.isHidden = false
                }else{
                    self.facebookView.isHidden = true
                }
                
                if data.data?.advertisement_details?.adv_website ?? "" != ""{
                    self.WebSiteLbl.text = data.data?.advertisement_details?.adv_website ?? ""
                    self.websiteView.isHidden = false
                }else{
                    self.websiteView.isHidden = true
                }
                
                
                
                self.FeatureArray = data.data?.advertisement_details?.adv_specifications ?? []
                
                
                if data.data?.advertisement_details?.adv_specifications?.count ?? 0 == 0 {
                    self.FeatuseTopTitle.isHidden = true
                }else{
                    self.FeatuseTopTitle.isHidden = false
                }
                
                
                
                self.phoneNumber = data.data?.advertisement_details?.adv_call_number ?? ""
                self.whatsNumber = data.data?.advertisement_details?.adv_whatsapp_number ?? ""
                
                self.callState = data.data?.advertisement_details?.adv_call_number_status ?? ""
                self.whatsState = data.data?.advertisement_details?.adv_whatsapp_number_status ?? ""
                
                self.pageControl.numberOfPages = self.media.count
                
                if self.media.count > 1 {
                    self.pageControl.isHidden = false
                }else{
                    self.pageControl.isHidden = true
                }
                
                
                if data.data?.advertisement_details?.adv_available_status !=  "" {
                    if data.data?.advertisement_details?.adv_available_status ==  "available" {
                        self.AdvState.textColor = #colorLiteral(red: 0.2862745098, green: 0.8588235294, blue: 0.4980392157, alpha: 1)
                    }else{
                        self.AdvState.textColor = #colorLiteral(red: 1, green: 0.4784313725, blue: 0.5803921569, alpha: 1)
                    }
                }
                
                
                if data.data?.advertisement_details?.adv_promotional_image ?? "" == "" || data.data?.advertisement_details?.adv_promotional_image ?? "" == "https://askhail.com/public/images/no_image.png" {
                    self.PromotionalPhotoBtn.isHidden = true
                }else{
                    self.PromotionalPhotoBtn.isHidden = false
                }
                
                if L102Language.currentAppleLanguage() == englishLang {
                    self.AdvState.text = data.data?.advertisement_details?.adv_available_status ?? ""
                } else {
                    self.AdvState.text = data.data?.advertisement_details?.adv_available_custom_status ?? ""
                }
                
                
                if data.data?.advertisement_details?.adv_special_status == "مميز" || data.data?.advertisement_details?.adv_special_status == "special" {
                    self.StarAdsView.isHidden = false
                    self.StarBtn.image = #imageLiteral(resourceName: "feature")
                } else {
                    
                    self.StarAdsView.isHidden = true
                    
                    if data.data?.advertisement_details?.isWaiting == true{
                        self.StarBtn.image = #imageLiteral(resourceName: "feature")
                    } else {
                        self.StarBtn.image = #imageLiteral(resourceName: "rate-1")
                    }
                    
                }
                
                
                
                if data.data?.rates_count ?? "" == "0" {
                    self.NoCommentLable.isHidden = false
                    self.CommentsTableView.isHidden = true
                }else{
                    self.RateArray = data.data?.rates_data ?? []
                    self.RateData = true
                    self.NoCommentLable.isHidden = true
                    self.CommentsTableView.isHidden = false
                }
                
                self.CreateMarker(Lat: Double(data.data?.advertisement_details?.adv_latitude ?? "0.0") ?? 0.0, lng: Double(data.data?.advertisement_details?.adv_longitude ?? "0.0") ?? 0.0)
                
                self.NumberOfComments.text = "( \(data.data?.rates_count ?? "") )"
                self.TotalCommentsRate.text = data.data?.rates_average ?? ""
                
                self.SocialStackView.layoutIfNeeded()
                if self.SocialStackView.frame.height == 24.0 {
                    self.SocialStackView.isHidden = true
                }
                
                self.CommentsTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
                self.DetailsCollectionView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
                self.AdsDescribtion.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
                self.SocialStackView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
                
                self.PagerView.reloadData()
                self.FeatureData = true
                self.isActive = true
                self.CommentsTableView.reloadData()
                self.DetailsCollectionView.reloadData()
                self.MainView.isHidden = false
                
                
                print(self.SocialStackView.frame.height) // old height

                print(data)
                
            }
        }
    }
    
}
