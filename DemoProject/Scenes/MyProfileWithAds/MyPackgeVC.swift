//
//  MyPackgeVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/13/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class MyPackgeVC: UIViewController {
    
    
    @IBOutlet weak var ScrollView: UIScrollView!
    
    
    @IBOutlet weak var MainView2: UIView!
    
    @IBOutlet weak var PackgeTitle: UILabel!
    @IBOutlet weak var PackageDescription: UILabel!
    @IBOutlet weak var PackgeImageLeft: UIImageView!
    @IBOutlet weak var PackgeImageRight: UIImageView!
    @IBOutlet weak var PackgeAdsNumber: UILabel!
    @IBOutlet weak var PackgePrice: UILabel!
    @IBOutlet weak var PackgeLongTime: UILabel!
    
    @IBOutlet weak var RenewPackageBtn: UIButton!
    @IBOutlet weak var UserAdsNumber: UILabel!
    @IBOutlet weak var UserPackgeUsed: UILabel!
    @IBOutlet weak var UserBuyDate: UILabel!
    @IBOutlet weak var UserEndDate: UILabel!
    @IBOutlet weak var NumberDaysRemening: UILabel!
    @IBOutlet weak var RemaonongDayesLabel: UILabel!
    @IBOutlet weak var EditPackageBtn: UIButton!
    
    
    @IBOutlet weak var DetailsView: NSLayoutConstraint!
    @IBOutlet weak var DetailsStackView: UIStackView!
    @IBOutlet weak var TopBar: UIView!
    
    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var BackGround2: UIView!
    
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var View2: UIView!
    
    @IBOutlet weak var AlertView: UIView!
    @IBOutlet weak var AlertHight: NSLayoutConstraint!
    @IBOutlet weak var AlertText: UIStackView!
    @IBOutlet weak var AlertTitle: UILabel!
    @IBOutlet weak var AlertDescribe: UILabel!
    
    
    
    var Model : MyPackageData?
    
    
    override func viewWillAppear(_ animated: Bool) {
       
        
        ScrollView.isHidden = true
        MainView2.isHidden = false
        getMyPackage()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        BackGround2.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        setShadow(view: View1 , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: View2 , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))

        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
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
    
    
    @IBAction func ReActiveAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsPaymentDetailsVC") as! AdsPaymentDetailsVC
        vc.state = ComeFrom.reNewPackage.rawValue
        IsNew = 1
        type = 2
        vc.Package_id = "\(Model?.package_id ?? 0)"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func ChangePachgeAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: StarAds, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "StarAdsPackgeVC") as! StarAdsPackgeVC
        vc.state = ComeFrom.updatePackage.rawValue
        IsNew = 1
        type = 2
        vc.topTitle = "Change Package"
        navigationController?.pushViewController(vc, animated: true)
        print(DetailsView.constant)
    }
    
    
}


extension MyPackgeVC {
    
    func getMyPackage() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)my-packages") { (data : MyPackageModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.ScrollView.isHidden = true
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                   
                    return
                }
                
                //if no package found
                guard data.data != nil else {
                    
                    self.ScrollView.isHidden = true
                    self.MainView2.isHidden = true
                    
                    return
                }
                
                self.Model = data.data
                                
                if data.data?.package_rate == "1" {
                    self.PackgeImageLeft.image = #imageLiteral(resourceName: "feature-1")
                    self.PackgeImageRight.image = #imageLiteral(resourceName: "feature-1")
                }
                
                if data.data?.package_rate == "2" {
                    self.PackgeImageLeft.image = #imageLiteral(resourceName: "Blue-Star")
                    self.PackgeImageRight.image = #imageLiteral(resourceName: "Blue-Star")
                }
                
                if data.data?.package_rate == "3" {
                    self.PackgeImageLeft.image = #imageLiteral(resourceName: "Gold-Star")
                    self.PackgeImageRight.image = #imageLiteral(resourceName: "Gold-Star")
                }
                
                self.PackgeTitle.text = data.data?.package_name ?? ""
                self.PackageDescription.text = data.data?.package_description ?? ""
                self.PackgeLongTime.text = data.data?.package_duration_in_days ?? ""
                self.PackgePrice.text = data.data?.package_price ?? ""
                self.PackgeAdsNumber.text = data.data?.package_advertisements_count ?? ""
                self.UserBuyDate.text = data.data?.package_details?.subscription_custom_start_date ?? ""
                self.UserEndDate.text = data.data?.package_details?.subscription_custom_end_date ?? ""
                self.UserPackgeUsed.text = "\(data.data?.package_details?.subscription_used_advertisements ?? 0)"
                self.NumberDaysRemening.text = "\(data.data?.package_details?.subscription_rest_days ?? 0)"
                self.UserAdsNumber.text = data.data?.package_advertisements_count ?? ""
                
                if data.data?.package_if_subscription_type_is_later == true {
                    
                    self.EditPackageBtn.isHidden = true
                    self.RenewPackageBtn.isHidden = false
                    self.ScrollView.isHidden = false
                    self.MainView2.isHidden = false
                    self.DetailsView.constant = 200
                    self.DetailsStackView.isHidden = true
                    self.AlertText.isHidden = false
                    self.AlertHight.constant = 72
                    self.AlertView.isHidden = false
                    self.AlertTitle.text = "Pay now".localized
                    self.AlertDescribe.text = "You have not paid the package price".localized
                    self.RenewPackageBtn.setTitle("Pay now".localized, for: .normal)
                    return
                     
                }else{
                    
                    self.AlertText.isHidden = true
                    self.AlertHight.constant = 0
                    self.AlertView.isHidden = true
                    self.NumberDaysRemening.textColor = UIColor(hexString: "#024A88")
                    self.RemaonongDayesLabel.textColor = UIColor(hexString: "024A88")
                    
                    self.RenewPackageBtn.isHidden = true
                    if data.data?.package_details?.subscription_can_renew_package_status == true {
                        self.RenewPackageBtn.isHidden = false
                        self.AlertText.isHidden = false
                        self.AlertHight.constant = 72
                        self.AlertView.isHidden = false
                        self.RemaonongDayesLabel.textColor = UIColor(hexString: "#FF7994")
                        self.NumberDaysRemening.textColor = UIColor(hexString: "#FF7994")
                        
                    }
                    
                    if Int(data.data?.package_price ?? "") ?? 0 == 0 {
                        self.PackgePrice.text = "Free".localized
                    }
                    
                }
                
                
                
                //if have package but not active yet!
                guard (data.data?.package_details) != nil else {
                    self.RenewPackageBtn.isHidden = true
                    self.EditPackageBtn.isHidden = true
                    self.ScrollView.isHidden = false
                    self.MainView2.isHidden = false
                    self.DetailsView.constant = 150
                    self.DetailsStackView.isHidden = true
                    self.AlertText.isHidden = false
                    self.AlertHight.constant = 72
                    self.AlertView.isHidden = false
                    self.AlertTitle.text = "Confirm bank transfer".localized
                    self.AlertDescribe.text = "Bank transfer process is now under review".localized
                    return
                }
                
                 
                self.ScrollView.isHidden = false
                self.MainView2.isHidden = true

                print(data.data)
                
                
            }
        }
    }
}
