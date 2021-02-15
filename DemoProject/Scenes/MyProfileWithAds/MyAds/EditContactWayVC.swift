//
//  EditContactWayVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/16/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class EditContactWayVC: UIViewController {

    var CheckBoxPhone = false
    var CheckBoxWhatsApp = false
    
    var PhoneState = ""
    var WhatsState = ""
    
    var Ad_id = ""
    
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet weak var BackGround: UIView!
    @IBOutlet weak var View1: UIView!
    
    @IBOutlet weak var PhoneCheckBoxBtn: UIButton!
    @IBOutlet weak var WhatsCheckBoxBtn: UIButton!
    
    @IBOutlet weak var PhoneNumber: UILabel!
    @IBOutlet weak var WhatsAppNymber: UILabel!
    
    @IBOutlet weak var AddPhoneBtn: UIButton!
    @IBOutlet weak var AddWhatsAppBtn: UIButton!
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    var lable = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getContactWay()
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.8974673004, green: 0.911144314, blue: 0.922011104, alpha: 1))
        
        
        setShadow(view: View1 , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func ChatCheckBoxAction(_ sender: Any) {
        
        self.showAlertWithTitle(title: "", message: "Chan Comuncation is Importemt", type: .warning)
        
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
            
            print(" Phone ")
            
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
            
            print(" What's App ")
            
        }
        
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        updateContactWay()
        
    }
    
}

extension EditContactWayVC : AddPhone {
    
    func getPhone(Phone: String) {
        
        if lable == 0 {
            self.PhoneNumber.text = "\(Phone)"
        } else {
            self.WhatsAppNymber.text = "\(Phone)"
        }
        
    }
}

extension EditContactWayVC {
    
    func updateContactWay() {
        
        self.view.lock()
        
        let Parameters = [
            "advertisement_id" : Ad_id,
            "call_contact_status" : PhoneState,
            "call_number" : PhoneNumber.text ?? "",
            "whatsapp_contact_status" : WhatsState,
            "whatsapp_number" : WhatsAppNymber.text
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject], url: "\(hostName)business-update-advertisement/update-contact-ways") { (data : SuccessEditSectionModel?, String) in
        self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
               self.view.unlock()
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.navigationController?.popViewController(animated: true)
                
                self.navigationController?.view.makeToast("\(data.data?.message ?? "")")
                
                print(data)
                
                
            }
        }
    }
    
    func getContactWay() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)business-update-advertisement/edit-contact-ways?advertisement_id=\(Ad_id)") { (data : EditContactWayModel?, String) in
        self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
               self.view.unlock()
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.Ad_id = "\(data.data?.adv_id ?? 0)"
                
                self.PhoneState = data.data?.adv_call_number_status ?? ""
                self.PhoneNumber.text = data.data?.adv_call_number ?? ""
                
                self.WhatsState = data.data?.adv_whatsapp_number_status ?? ""
                self.WhatsAppNymber.text = data.data?.adv_whatsapp_number ?? ""
                
                self.PhoneCheckBoxBtn.setImage(#imageLiteral(resourceName: "check"), for: .normal)
                
                if data.data?.adv_call_number_status == "active" {
                    self.PhoneCheckBoxBtn.setImage(#imageLiteral(resourceName: "check-1"), for: .normal)
                    self.PhoneState = data.data?.adv_call_number_status ?? ""
                    self.CheckBoxPhone = true
                }
                
                self.WhatsCheckBoxBtn.setImage(#imageLiteral(resourceName: "check"), for: .normal)
                if data.data?.adv_whatsapp_number_status == "active" {
                    self.WhatsCheckBoxBtn.setImage(#imageLiteral(resourceName: "check-1"), for: .normal)
                    self.WhatsState = data.data?.adv_whatsapp_number_status ?? ""
                    self.CheckBoxWhatsApp = true
                }
                
                print(data)
                
                
            }
        }
    }
    
}



