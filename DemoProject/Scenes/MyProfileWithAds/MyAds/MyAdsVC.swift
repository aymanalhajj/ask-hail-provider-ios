//
//  MyOrderVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/12/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class MyAdsVC: UIViewController {
    
    var isSaved = false
    var isHome = 0
    
    @IBOutlet weak var TopBar : UIView!
    
    @IBOutlet weak var StopedAddBtn: UIButton!
    @IBOutlet weak var NumOfBlockedNumber: UILabel!
    
    @IBOutlet weak var MyAdsTAbleView: UITableView!
    
    @IBOutlet var BackGround: UIView!
    
    var MyAdsArray : [AdsData] = []
    var MyAdData = false
    
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
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        MyAdsTAbleView.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        
        MyAdsTAbleView.delegate = self
        MyAdsTAbleView.dataSource = self
        
        MyAdsTAbleView.RegisterNib(cell: SubAdsCell.self)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMyAds()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func BackAvtion(_ sender: Any) {
        
        if isHome == 0 {
            navigationController?.popViewController(animated: true)
            
        }else {
            guard let window = UIApplication.shared.keyWindow else{return}
            let sb = UIStoryboard(name: Home, bundle: nil)
            var vc : UIViewController
            vc = sb.instantiateViewController(withIdentifier: "HomeVC")
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        }
        
        
    }
    
    
    
    @IBAction func AddNewAdsAction(_ sender: Any) {
        
        CkeckIfHaveOldAds()
        
    }
    
    @IBAction func StopedAdvAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: MyProfile, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "StopedAdvVC") as! StopedAdvVC
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

//MARK:TableView Controller
extension MyAdsVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MyAdsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue() as SubAdsCell
        
        if MyAdData {
            
            var Model = MyAdsArray[indexPath.row]
            
            cell.ImagesUrl = Model.adv_media ?? []
            cell.pageControl.numberOfPages =  Model.adv_media?.count ?? 0
            cell.PagerView.reloadData()
            cell.name.text = Model.adv_title
            cell.Price.text = Model.adv_price
            cell.distance.text = Model.adv_distance
            cell.ViewsNumber.text = Model.adv_views
            
            isSaved = Model.adv_is_favorite ?? false
            
            cell.SaveBtn.setBackgroundImage(UIImage(named: "save_white"), for: .normal)
            
            if Model.adv_is_favorite == true {
                cell.SaveBtn.setBackgroundImage(UIImage(named: "save_white-1"), for: .normal)
            }else{
                cell.SaveBtn.setBackgroundImage(UIImage(named: "save_white"), for: .normal)
            }
            
            cell.StarAdView.isHidden = true
            
            if Model.adv_special_status == "special" || Model.adv_special_status == "مميز" {
                cell.StarAdView.isHidden = false
            }
            
            cell.SaveAcrion = {
                
                self.AddToFavourite(advertisement_id: "\(Model.adv_id ?? 0)")
                
                if Model.adv_is_favorite == false {
                    cell.SaveBtn.setBackgroundImage(UIImage(named: "save_white-1"), for: .normal)
                    Model.adv_is_favorite = true
                }else{
                    cell.SaveBtn.setBackgroundImage(UIImage(named: "save_white"), for: .normal)
                    Model.adv_is_favorite = false
                }
                
            }
            
            cell.SelectCell = {
                
                let storyboard = UIStoryboard(name: MyProfile, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "MyAdsDetailsVC") as! MyAdsDetailsVC
                vc.AdId = "\(self.MyAdsArray[indexPath.row].adv_id ?? 0)"
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: MyProfile, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "MyAdsDetailsVC") as! MyAdsDetailsVC
        vc.AdId = "\(MyAdsArray[indexPath.row].adv_id ?? 0)"
        vc.User_id = MyAdsArray[indexPath.row].adv_advertiser_id ?? 0
        navigationController?.pushViewController(vc, animated: true)

        return MyAdsTAbleView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let ContentHeight = scrollView.contentSize.height
        // print(position , tableView.contentSize.height)
        if isActive {
            if position > ContentHeight - scrollView.frame.height {
                
                print("Done")
                isActive = false
                
                //numberofitem
                
                //  print(CurrentPage , lastPage)
                if CurrentPage < lastPage {
                    
                    CurrentPage = CurrentPage + 1
                    
                    self.getMyAds()
                    
                }
            }
            
        }
        
    }
    
}




//MARK:API

extension MyAdsVC {
    
    func getMyAds() {
        self.view.lock()
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)user/my-advertisements") { (data : MyAdsModel?, String) in
            self.view.unlock()

            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.CurrentPage = data.data?.pagination?.current_page ?? 1
                 self.lastPage = data.data?.pagination?.last_page ?? 1
                
                self.MyAdsTAbleView.isHidden = true
                self.StopedAddBtn.isHidden = true
                
                print(data.data?.if_have_blocked_advertisements)
                if data.data?.if_have_blocked_advertisements == true {
                    self.StopedAddBtn.isHidden = false
                }
                
                if data.data?.advertisements_count == "0" {
                    self.NumOfBlockedNumber.text = "لا"
                }else{
                    self.NumOfBlockedNumber.text = data.data?.advertisements_count ?? ""
                }
                
                if data.data?.advertisements_count != "0" {
                    
                    

                    for item in data.data?.data ?? [] {
                        
                        self.MyAdsArray.append(item)
                    }
                    
                    self.MyAdData = true
                    self.MyAdsTAbleView.isHidden = false
                    self.MyAdsTAbleView.reloadData()
                    
                    self.isActive = true
                    
                }
                
                print(data)
                
            }
        }
    }
    
}


extension MyAdsVC {
    
    func CkeckIfHaveOldAds() {
        
        ApiServices.instance.getPosts(methodType: .post, parameters: nil , url: "\(hostName)business-add-advertisement/level1-check-last-not-completed-advertisement") { (data : Level_1_Model?, String) in
            
            if String != nil {
                
                let storyboard = UIStoryboard(name: AddAds , bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "AdsTermsVC") as! AdsTermsVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                let alert = UIAlertController(title: "", message: data.message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Complete now".localized, style: UIAlertAction.Style.default, handler:{_ in
                    
                    if data.data?.next_level == 2 {
                        
                        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "ChoseGradeVC") as! ChoseGradeVC
                        vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    } else if data.data?.next_level == 3 {
                        
                        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsPlaceTypeVC") as! AdsPlaceTypeVC
                        vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    } else if data.data?.next_level == 4 {
                        
                        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsAddPhotoVC") as! AdsAddPhotoVC
                        vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                    } else if data.data?.next_level == 5 {
                        
                        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsDetailsVC") as! AdsDetailsVC
                        vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                    } else if data.data?.next_level == 6 {
                        
                        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsContactNumberVC") as! AdsContactNumberVC
                        vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }
                    self.getNewOrContinue(state: "continue")
                    
                    
                }))
                
                alert.addAction(UIAlertAction(title: "New one".localized, style: UIAlertAction.Style.default, handler:{_ in
                    
                    self.getNewOrContinue(state: "new")
                    
                    let storyboard = UIStoryboard(name: AddAds , bundle: nil)
                    let vc  = storyboard.instantiateViewController(withIdentifier: "AdsTermsVC") as! AdsTermsVC
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    print("Complite now")
                    
  
                }))
                
                self.present(alert, animated: true, completion: nil)
                
                
                print(data)
                

            }
        }
        
    }
    

    func getNewOrContinue(state : String) {
        
        let Parameters = [
            "desire" : state
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)business-add-advertisement/choose-continue-or-new") { (data : RealEstateShotModel?, String) in
            
            if String != nil {
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                               
                print(data)
                
            }
        }
    }
    
    
    func AddToFavourite(advertisement_id : String) {
        
        //  self.view.lock()
        
        let param = [
            
            "advertisement_id" : advertisement_id
            
        ]
        
        
        ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)advertisement-operations/add-remove-favorite") { (data : ContactUsModel?, String) in
            //self.view.unlock()
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                //   self.StarAdsCollection.reloadData()
                
                
                print(data)
                
                
            }
        }
    }
    
}
