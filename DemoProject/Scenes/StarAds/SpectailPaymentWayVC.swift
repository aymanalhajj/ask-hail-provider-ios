//
//  SpectailPaymentWayVC.swift
//  AskHail
//
//  Created by bodaa on 12/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit




class SpectailPaymentWayVC: UIViewController {

    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var DetailView: UIView!
    @IBOutlet weak var BankBtnView: UIView!
    @IBOutlet weak var InternetBtnView: UIView!
    
    @IBOutlet weak var Titlee: UILabel!
    @IBOutlet weak var StarRight: UIImageView!
    @IBOutlet weak var StarLeft: UIImageView!
    
    @IBOutlet weak var AdsPrice: UILabel!
    @IBOutlet weak var AdsTime: UILabel!
    @IBOutlet weak var Desc: UILabel!
    
    @IBOutlet weak var LineImage: UIImageView!
    
    @IBOutlet weak var LoadingView: UIView!
    
    
    var Model : SpecialPackageData?
    var state = ""
    var PaymentWay = ""
    var Adv_Id = ""
    var url = ""
    var displayPlace = ""
    var currentPage = 0
    
    var Package_id = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        getPackageDetails()
        
        
        
        if L102Language.currentAppleLanguage() == englishLang {
            LineImage.image = #imageLiteral(resourceName: "lines-eng")
        }
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        LoadingView.backgroundColor = Colors.ViewBackGroundColoer
        setShadow(view: DetailView, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        setShadow(view: BankBtnView, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: InternetBtnView, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func BankAction(_ sender: Any) {
      
        var Model : PackageData?

        let storyboard = UIStoryboard(name: StarAds, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "SpecialChooseBanckVC") as! SpecialChooseBanckVC
        vc.PaymentWay = "bank"
        vc.state = self.state
        vc.Model = self.Model
        vc.Adv_Id = self.Adv_Id
        vc.Package_id = Package_id
        vc.displayPlace = self.displayPlace
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func InternetPayAction(_ sender: Any) {
    
        StarAdv()
            
       
        
    }

}

extension SpectailPaymentWayVC {
    
    func getPackageDetails() {
        self.LoadingView.isHidden = false
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)business-special-package/\(Package_id)") { (data : PackageModel?, String) in
            
            self.view.unlock()
            self.LoadingView.isHidden = true
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.Titlee.text = data.data?.package_name ?? ""

                //self.NumberAds.text = data.data?.package_advertisements_count ?? ""
                self.AdsPrice.text = data.data?.package_price ?? ""
                
                self.AdsTime.text = data.data?.package_duration_in_days ?? ""
                self.Desc.text = data.data?.package_description ?? ""
                
                if self.Model?.package_rate == "1" {
                    
                    self.StarRight.image = #imageLiteral(resourceName: "feature-1")
                    self.StarLeft.image = #imageLiteral(resourceName: "feature-1")
                    
                }
                
                if self.Model?.package_rate == "2" {
                    
                    self.StarRight.image = #imageLiteral(resourceName: "Blue-Star")
                    self.StarLeft.image = #imageLiteral(resourceName: "Blue-Star")
                }
                
                if self.Model?.package_rate == "3" {
                    
                    self.StarRight.image = #imageLiteral(resourceName: "Gold-Star")
                    self.StarLeft.image = #imageLiteral(resourceName: "Gold-Star")
                    
                }
                
                

                print(data)
                
                
            }
        }
    }
    
    
    
    func StarAdv() {
        
        
        self.view.lock()
        
        var Parameters = [
            "advertisement_id": Adv_Id,
            "display_place": displayPlace,
            "package_id" : Model?.package_id ?? 0,
            "payment_way" : "e_payment"
        ] as [String : Any]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject], url: "\(hostName)advertisement-operations/make-special") { (data : Level_6_Model?, String) in

            self.view.unlock()

            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.url = data.data ?? ""
                
                let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "ReNewPackage_e_paymentVC") as! ReNewPackage_e_paymentVC
                vc.url = self.url
                self.navigationController?.pushViewController(vc, animated: true)
                
                print(data)
                
                
            }
        }
        
    }
    
}
