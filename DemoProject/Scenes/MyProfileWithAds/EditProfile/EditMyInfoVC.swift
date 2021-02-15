//
//  EditMyInfoVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/14/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import Toast_Swift

class EditMyInfoVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var BackGround: UIView!
    
    @IBOutlet weak var TopBar: UIView!
    
    @IBOutlet weak var FullNameTf: UITextField!
    @IBOutlet weak var FullnameImage: UIImageView!
    @IBOutlet weak var FullnameLineView: UIView!
    @IBOutlet weak var FullNameView: UIView!
    
    @IBOutlet weak var MailTf: UITextField!
    @IBOutlet weak var MailImage: UIImageView!
    @IBOutlet weak var MailLineView: UIView!
    @IBOutlet weak var MailView: UIView!
    
    @IBOutlet weak var PhoneTf: UITextField!
    @IBOutlet weak var PhoneImage: UIImageView!
    @IBOutlet weak var PhoneLineView: UIView!
    @IBOutlet weak var PhoneView: UIView!
    
    @IBOutlet weak var SaveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FullNameTf.text = Helper.getaUser_name()
        MailTf.text = Helper.getauser_Email()
        PhoneTf.text = Helper.getauser_Phone()
        
        if L102Language.currentAppleLanguage() == englishLang {
            
            PhoneView.semanticContentAttribute = .forceLeftToRight
            
        }
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        FullNameTf.delegate = self
        MailTf.delegate = self
        PhoneTf.delegate = self
        
        FullNameTf.placeHolderColor = Colors.PlaceHolderColoer
        MailTf.placeHolderColor = Colors.PlaceHolderColoer
        PhoneTf.placeHolderColor = Colors.PlaceHolderColoer
        
        SaveBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        setShadowButton(view: SaveBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.8974673004, green: 0.911144314, blue: 0.922011104, alpha: 1))
        
        setShadow(view: FullNameView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: MailView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: PhoneView, width: 0, height: 2, shadowRadius: 2, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        FullNameTf.setPadding(left: 16, right: 16)
        MailTf.setPadding(left: 16, right: 16)
        PhoneTf.setPadding(left: 16, right: 16)
        
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func SaveACtion(_ sender: Any) {
        
        if FullNameTf.text?.isEmpty != true , MailTf.text?.isEmpty != true , PhoneTf.text?.isEmpty != true {
            
            updateProfile()
            
        } else {
            
            if FullNameTf.text?.isEmpty == true {
                
                ErrorLineAnimite(text: FullNameTf, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user"), lineView: FullnameLineView, ishidden: false)
                
            }
            
            if MailTf.text?.isEmpty == true {
                
                ErrorLineAnimite(text: MailTf, ImageView: MailImage, imageEnable: #imageLiteral(resourceName: "mail"), lineView: MailLineView, ishidden: false)
                
            }
            
            if PhoneTf.text?.isEmpty == true {
                
                ErrorLineAnimite(text: PhoneTf, ImageView: PhoneImage, imageEnable: #imageLiteral(resourceName: "phone"), lineView: PhoneLineView, ishidden: false)
                
            }
            
            self.view.shake()
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == FullNameTf {
            EnableLineAnimite(text: FullNameTf, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user-1"), lineView: FullnameLineView, ishidden: false)
        }else if textField == MailTf {
            EnableLineAnimite(text: MailTf, ImageView: MailImage, imageEnable: #imageLiteral(resourceName: "mail-1"), lineView: MailLineView, ishidden: false)
        }else if textField == PhoneTf{
            EnableLineAnimite(text: PhoneTf, ImageView: PhoneImage, imageEnable: #imageLiteral(resourceName: "phone-1"), lineView: PhoneLineView, ishidden: false)
        }
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text?.isEmpty == true {
            
            if textField == FullNameTf {
                EnableLineAnimite(text: FullNameTf, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user"), lineView: FullnameLineView, ishidden: true)
            }else if textField == MailTf {
                EnableLineAnimite(text: MailTf, ImageView: MailImage, imageEnable: #imageLiteral(resourceName: "mail"), lineView: MailLineView, ishidden: true)
            }else if textField == PhoneTf{
                EnableLineAnimite(text: PhoneTf, ImageView: PhoneImage, imageEnable: #imageLiteral(resourceName: "phone"), lineView: PhoneLineView, ishidden: true)
            }
            
        }
        return true;
    }
    
    

}

extension EditMyInfoVC {
    
    func updateProfile() {
        
          self.view.lock()
        
        let param = [
            "name" : FullNameTf.text ?? "",
            "email" : MailTf.text ?? "",
            "mobile" : PhoneTf.text ?? ""
        ]
        
        
        ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)update-personal-data") { (data : EditProfileModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                Helper.Saveuser_namen(name: self.FullNameTf.text ?? "")
                Helper.Saveuser_Email(email: self.MailTf.text ?? "")
                Helper.Saveuser_phone(phone: self.PhoneTf.text ?? "")
                
                self.navigationController?.popToViewController(ofClass: MyInfoVC.self, animated: true)
                self.navigationController?.view.makeToast("\(data.data?.message ?? "")")
                
                print(data)
                
                
            }
        }
    }
    
}
