//
//  CreateAccount_3.swift
//  DemoProject
//
//  Created by Abdullah Tarek on 10/28/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import AJMessage


class CreateAccount_3: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var FullNameTf: UITextField!
    @IBOutlet weak var MailTf: UITextField!
    @IBOutlet weak var PasswordFt: UITextField!
    @IBOutlet weak var FullnameImage: UIImageView!
    @IBOutlet weak var MailImage: UIImageView!
    @IBOutlet weak var PasswordImage: UIImageView!
    @IBOutlet weak var FullnameLineView: UIView!
    @IBOutlet weak var MailLineView: UIView!
    @IBOutlet weak var PasswordLineView: UIView!
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    @IBOutlet weak var FullNameView: UIView!
    @IBOutlet weak var MailView: UIView!
    @IBOutlet weak var PasswordView: UIView!
    
    @IBOutlet weak var checkBoxBtn: UIButton!
    
    @IBOutlet weak var Lable: UILabel!
    
    var checkBox = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FullNameTf.delegate = self
        MailTf.delegate = self
        PasswordFt.delegate = self
        
        FullNameTf.placeHolderColor = Colors.PlaceHolderColoer
        MailTf.placeHolderColor = Colors.PlaceHolderColoer
        PasswordFt.placeHolderColor = Colors.PlaceHolderColoer
        
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        setShadow(view: FullNameView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: MailView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: PasswordView, width: 0, height: 2, shadowRadius: 2, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        
        FullNameTf.setPadding(left: 16, right: 16)
        MailTf.setPadding(left: 16, right: 16)
        PasswordFt.setPadding(left: 16, right: 16)
        
        
        let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Tajawal-Bold", size: 16), NSAttributedString.Key.foregroundColor : Colors.DarkBlue]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Tajawal-Bold", size: 16), NSAttributedString.Key.foregroundColor : UIColor(hexString: "#39CDEE")]
        
        let attributedString1 = NSMutableAttributedString(string: "By registering for the Ask Hail application, I agree to".localized, attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string: " Terms and Conditions".localized, attributes:attrs2)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 7
        
        attributedString1.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString1.length
            ))
        
        attributedString2.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString2.length
            ))
        
        attributedString1.append(attributedString2)
        Lable.attributedText = attributedString1
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func ConfirmACtion(_ sender: Any) {
        if checkBox == false{
           
            self.showAlertWithTitle(title: "", message: "you should agree terms and conditions".localized, type: .error)
            
            return
            
        }
        
        if FullNameTf.text?.isEmpty != true , MailTf.text?.isEmpty != true , PasswordFt.text?.isEmpty != true , checkBox != false {
            
            CompleteRegister()
            view.lock()
           
            
        } else {
            
            if FullNameTf.text?.isEmpty == true {
                
                ErrorLineAnimite(text: FullNameTf, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user"), lineView: FullnameLineView, ishidden: false)
                
            }
            
            if MailTf.text?.isEmpty == true {
                
                ErrorLineAnimite(text: MailTf, ImageView: MailImage, imageEnable: #imageLiteral(resourceName: "mail"), lineView: MailLineView, ishidden: false)
                
            }
            
            if PasswordFt.text?.isEmpty == true {
                
                ErrorLineAnimite(text: PasswordFt, ImageView: PasswordImage, imageEnable: #imageLiteral(resourceName: "password"), lineView: PasswordLineView, ishidden: false)
                
            }
            self.view.shake()
        }
        
    }
    
    
    
    @IBAction func CheckBoxAction(_ sender: Any) {
        
        if checkBox == false{
            checkBoxBtn.setImage(#imageLiteral(resourceName: "check-1"), for: .normal)
            checkBox = true
        }else{
            checkBoxBtn.setImage(#imageLiteral(resourceName: "check"), for: .normal)
            checkBox = false
        }
    }
    
    
    @IBAction func TermsAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: More, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "TempVC") as! TempVC
        vc.isCreateAccount = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == FullNameTf {
            EnableLineAnimite(text: FullNameTf, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user-1"), lineView: FullnameLineView, ishidden: false)
        }else if textField == MailTf {
            EnableLineAnimite(text: MailTf, ImageView: MailImage, imageEnable: #imageLiteral(resourceName: "mail-1"), lineView: MailLineView, ishidden: false)
        }else if textField == PasswordFt {
            EnableLineAnimite(text: PasswordFt, ImageView: PasswordImage, imageEnable: #imageLiteral(resourceName: "password-1"), lineView: PasswordLineView, ishidden: false)
        }
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text?.isEmpty == true {
            
            if textField == FullNameTf {
                EnableLineAnimite(text: FullNameTf, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user"), lineView: FullnameLineView, ishidden: true)
            }else if textField == MailTf {
                EnableLineAnimite(text: MailTf, ImageView: MailImage, imageEnable: #imageLiteral(resourceName: "mail"), lineView: MailLineView, ishidden: true)
            }else if textField == PasswordFt {
                EnableLineAnimite(text: PasswordFt, ImageView: PasswordImage, imageEnable: #imageLiteral(resourceName: "password"), lineView: PasswordLineView, ishidden: true)
            }
            
        }
        return true;
    }
}

extension CreateAccount_3 {
    
    func CompleteRegister() {
        
        let Parameters = [
            "advertiser_id" : Helper.getaUser_id() ?? "",
            "name" : FullNameTf.text ?? "",
            "password":PasswordFt.text ?? "",
            "password_confirmation" : PasswordFt.text ?? "",
            "firebase_token" : Helper.getFcmtoken() ?? "token",
            "email" : "\(MailTf.text ?? "")"
        ]
        
        print(Parameters)
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)business/register-level3-add-details") { (data : RegisterModel_3?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                self.view.unlock()
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                Helper.Saveuser_id(user_id: "\(data.data?.advertiser_id ?? 0)")
                Helper.Saveuser_namen(name: data.data?.advertiser_name ?? "" )
                Helper.Saveuser_phone(phone: data.data?.advertiser_mobile ?? "")
                Helper.Saveuser_Email(email: data.data?.advertiser_email ?? "")
                Helper.SaveApitoken(token: data.data?.advertiser_api_token ?? "")
                Helper.SavePackage_Id(PackageId: data.data?.advertiser_package_id ?? "")
                Helper.SaveChatType(ChatState: "true")
                
                let storyboard = UIStoryboard(name: Authontication, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "SuccessCreateAccountVC") as! SuccessCreateAccountVC
                self.navigationController?.pushViewController(vc, animated: true)
                self.view.unlock()
                    
                
                print(data)
                
            }
        }
    }
    
}


