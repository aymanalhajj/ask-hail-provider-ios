//
//  AdsContactNumberVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/8/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class AdsContactNumberVC: UIViewController {
    
    var CheckBoxPhone = false
    var CheckBoxWhatsApp = false
    
    var WhatsState = "block"
    var PhoneState = "block"
    
    var Ad_id = ""
    
    var isHome = 0
    
    var lable = 0

    var section_ID = ""
    var subSection_ID = ""
    
    @IBOutlet weak var PhoneCheckBoxBtn: UIButton!
    @IBOutlet weak var WhatsCheckBoxBtn: UIButton!
    
    @IBOutlet weak var PhoneNumber: UILabel!
    @IBOutlet weak var WhatsAppNymber: UILabel!
    
    @IBOutlet weak var AddPhoneBtn: UIButton!
    @IBOutlet weak var AddWhatsAppBtn: UIButton!
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PhoneNumber.text = Helper.getauser_Phone() ?? ""

        
        WhatsState = "block"
        PhoneState = "block"
        lable = 0
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
       
        
        PhoneNumber.text = Helper.getauser_Phone()
        WhatsAppNymber.text = Helper.getauser_Phone()
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    
    @IBAction func ChatCheckBoxAction(_ sender: Any) {
        self.showAlertWithTitle(title: "", message: "Communication within the application is mandatory".localized, type: .warning)
    }
    
    
    @IBAction func PhoneCheckBoxAction(_ sender: Any) {
        
        guard PhoneNumber.text != "" else {
            
            self.showAlertWithTitle(title: "", message: "There is no Phone number".localized, type: .error)
            return
        }
        
        if CheckBoxPhone == false{
            PhoneCheckBoxBtn.setImage(#imageLiteral(resourceName: "check-1"), for: .normal)
            CheckBoxPhone = true
            PhoneState = "active"
        }else{
            PhoneCheckBoxBtn.setImage(#imageLiteral(resourceName: "check"), for: .normal)
            CheckBoxPhone = false
            PhoneState = "block"
        }
    }
    
    
    @IBAction func WhatsAppCheckBoxAction(_ sender: Any) {
        
        guard WhatsAppNymber.text != "" else {
            
            self.showAlertWithTitle(title: "", message: "There is no WhatsApp number".localized, type: .error)
            return
        }
        
        if CheckBoxWhatsApp == false{
            
            WhatsCheckBoxBtn.setImage(#imageLiteral(resourceName: "check-1"), for: .normal)
            CheckBoxWhatsApp = true
            WhatsState = "active"
        }else{
            WhatsCheckBoxBtn.setImage(#imageLiteral(resourceName: "check"), for: .normal)
            CheckBoxWhatsApp = false
            WhatsState = "block"
        }
        
    }
    
    @IBAction func AddNumberPhoneAction(_ sender: UIButton) {
        
        if sender == AddPhoneBtn {
            
            lable = 0
            
            let storyboard = UIStoryboard(name: Order, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "OrderAddNewNumberVC") as! OrderAddNewNumberVC
            vc.Delegate = self
            vc.modalPresentationStyle = .fullScreen
            self.addChild(vc)
            vc.view.frame = self.view.frame
            self.view.addSubview(vc.view)
            vc.didMove(toParent: self)
            
        } else if sender == AddWhatsAppBtn{
            
            lable = 1

            let storyboard = UIStoryboard(name: Order, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "OrderAddNewNumberVC") as! OrderAddNewNumberVC
            vc.Delegate = self
            vc.modalPresentationStyle = .fullScreen
            self.addChild(vc)
            vc.view.frame = self.view.frame
            self.view.addSubview(vc.view)
            vc.didMove(toParent: self)
                        
        }
        
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        if isHome == 0 {
            navigationController?.popViewController(animated: true)
        }
        else{
            
            guard let window = UIApplication.shared.keyWindow else{return}
            let sb = UIStoryboard(name: Home, bundle: nil)
            var vc : UIViewController
            vc = sb.instantiateViewController(withIdentifier: "HomeVC")
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
            
        }
        
    }
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        setDetails()
    }
    
}

extension AdsContactNumberVC : AddPhone {
    func getPhone(Phone: String) {
        
        if lable == 0 {
            self.PhoneNumber.text = "\(Phone)"
        } else {
            self.WhatsAppNymber.text = "\(Phone)"
        }
        
    }
}


//MARK: API
extension AdsContactNumberVC {
    
    
    func setDetails() {
        self.view.lock()
        
        
        print(self.WhatsState ,self.PhoneState )
        
        var Parameters = [
            
            "advertisement_id": Ad_id,
            "call_contact_status" : self.PhoneState,
            "call_number" : PhoneNumber.text ?? "",
            "whatsapp_contact_status" : self.WhatsState,
            "whatsapp_number" : WhatsAppNymber.text ?? ""
        ]
        
        print(Parameters)
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject], url: "\(hostName)business-add-advertisement/level6-choose-contact-ways") { (data : Level_1_Model?, String) in
            
            self.view.unlock()
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }

                let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "AdsSocialMediaVC") as! AdsSocialMediaVC
                vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                self.navigationController?.pushViewController(vc, animated: true)
                
                print(data)
                
                
            }
        }
    }

}



