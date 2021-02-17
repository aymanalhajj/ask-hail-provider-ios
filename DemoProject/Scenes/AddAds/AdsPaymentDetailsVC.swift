//
//  AdsPaymentDetailsVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/7/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class AdsPaymentDetailsVC: UIViewController {

    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var DetailView: UIView!
    @IBOutlet weak var BankBtnView: UIView!
    @IBOutlet weak var InternetBtnView: UIView!
    
    @IBOutlet weak var Titlee: UILabel!
    @IBOutlet weak var StarRight: UIImageView!
    @IBOutlet weak var StarLeft: UIImageView!
    
    @IBOutlet weak var NumberAds: UILabel!
    @IBOutlet weak var AdsPrice: UILabel!
    @IBOutlet weak var AdsTime: UILabel!
    @IBOutlet weak var Desc: UILabel!
    
    @IBOutlet weak var MainView: UIView!
    
    @IBOutlet weak var LineImage: UIImageView!
    
    var Model : PackagesData?
    
    var state = ""
    var PaymentWay = ""
    var Adv_Id = ""
    var url = ""
    var displayPlace = ""
    var currentPage = 0
    
    var Package_id = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainView.isHidden = true
        
        if Model?.package_id != nil {
            
            Package_id = "\(Model?.package_id ?? 0)"
            
        }
        
        
        print(Model?.package_id)
        
        getPackageDetails()
        
        
        
        if L102Language.currentAppleLanguage() == englishLang {
            LineImage.image = #imageLiteral(resourceName: "lines-eng")
        }
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
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
        
        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsPaymentBankVC") as! AdsPaymentBankVC
        vc.PaymentWay = "bank"
        vc.state = self.state
        vc.Model = self.Model
        vc.Adv_Id = self.Adv_Id
        vc.Package_id = Package_id
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func InternetPayAction(_ sender: Any) {
        
        if IsNew == 1 {
            if type == 1 {
                StarAdv()
            } else if type == 2{
                if state == ComeFrom.updatePackage.rawValue {
                    UpdatePackage()
                }else{
                    ReNewPackage()
                }
            }
        } else {
            ChosePackage()
        }
        
    }

}

extension AdsPaymentDetailsVC {
    
    func getPackageDetails() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)package/\(Package_id)") { (data : PackageModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.Titlee.text = data.data?.package_name ?? ""

                self.NumberAds.text = data.data?.package_advertisements_count ?? ""
                self.AdsPrice.text = data.data?.package_price ?? ""
                
                self.AdsTime.text = data.data?.package_duration_in_days ?? ""
                self.Desc.text = data.data?.package_description ?? ""
                
                if data.data?.package_rate == "1" {
                    
                    self.StarRight.image = #imageLiteral(resourceName: "feature-1")
                    self.StarLeft.image = #imageLiteral(resourceName: "feature-1")
                    
                }
                
                if data.data?.package_rate == "2" {
                    
                    self.StarRight.image = #imageLiteral(resourceName: "Blue-Star")
                    self.StarLeft.image = #imageLiteral(resourceName: "Blue-Star")
                }
                
                if data.data?.package_rate == "3" {
                    
                    self.StarRight.image = #imageLiteral(resourceName: "Gold-Star")
                    self.StarLeft.image = #imageLiteral(resourceName: "Gold-Star")
                    
                }
                
                
                self.MainView.isHidden = false
                
                print(data)
                
                
            }
        }
    }
    
    
    func ChosePackage() {
        
        var Parameters = [
            "package_id": "\(Model?.package_id ?? 0)",
            "payment_time": "now",
            "payment_way" : "e_payment"
        ] as [String : Any]
        
        print(Parameters)
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject], url: "\(hostName)businedd-add-advertisement/add-package") { (data : Level_6_Model?, String) in
            
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "ReNewPackage_e_paymentVC") as! ReNewPackage_e_paymentVC
                vc.url = data.data ?? ""
                vc.modalTransitionStyle = .coverVertical
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
                print(data)
                
                
            }
        }
    }
    
    func ReNewPackage() {
        
        self.view.lock()
        
        let param = [
            "payment_way" : "e_payment"
        ] as [String : Any]
        
        
        ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)renew-package") { (data : Level_6_Model?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "ReNewPackage_e_paymentVC") as! ReNewPackage_e_paymentVC
                vc.url = data.data ?? ""
                vc.modalTransitionStyle = .coverVertical
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
                print(data)
                
                
            }
        }
    }
    
    func UpdatePackage() {
        
        self.view.lock()
        
        let param = [
            "package_id": Model?.package_id ?? 0,
            "payment_way": "e_payment",
        ] as [String : Any]
        
        
        ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)update-package") { (data : Level_6_Model?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "ReNewPackage_e_paymentVC") as! ReNewPackage_e_paymentVC
                vc.url = data.data ?? ""
                vc.modalTransitionStyle = .coverVertical
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
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
