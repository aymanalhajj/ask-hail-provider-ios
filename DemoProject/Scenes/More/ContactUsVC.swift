//
//  ContactUsVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/1/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class ContactUsVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var ContentView1: UIView!
    
    
    @IBOutlet weak var desTxt: UITextView!
    @IBOutlet weak var desLineView: UIView!
    @IBOutlet weak var desView: UIView!
    
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
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    @IBOutlet weak var snaoChatLabel: UILabel!
    @IBOutlet weak var instgramLabel: UILabel!
    @IBOutlet weak var whats: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    
    var twitterLink = ""
    var instgramLink = ""
    var snapchatLink = ""
    var WhatsApplink = ""
    
    
    
    @IBOutlet weak var ContactView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AboutUs()
        
        PhoneTf.placeHolderColor = Colors.PlaceHolderColoer
        FullNameTf.placeHolderColor = Colors.PlaceHolderColoer
        MailTf.placeHolderColor = Colors.PlaceHolderColoer
        
        PhoneTf.delegate = self
        FullNameTf.delegate = self
        MailTf.delegate = self
        desTxt.delegate = self
        
        PhoneTf.setPadding(left: 16, right: 16)
        FullNameTf.setPadding(left: 16, right: 16)
        MailTf.setPadding(left: 16, right: 16)
        
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.8974673004, green: 0.911144314, blue: 0.922011104, alpha: 1))
        
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view:TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        setShadow(view: ContentView1, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: FullNameView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: MailView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: PhoneView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: desView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        
        if L102Language.currentAppleLanguage() == "en" {
            
            desTxt.text = "Your Messege"
            
        }else {
            
            desTxt.text = "رسالتك"
        }
        
        desTxt.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if desTxt.textColor == #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5) {
            desTxt.text = ""
            desTxt.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 1)
        }
    }
    
    @IBAction func BackAcrion(_ sender: Any) {
        
        guard let window = UIApplication.shared.keyWindow else{return}
        let sb = UIStoryboard(name: Home, bundle: nil)
        var vc : UIViewController
        vc = sb.instantiateViewController(withIdentifier: "HomeVC")
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        
    }
    
    @IBAction func CallAction(_ sender: Any) {
        
        dialNumber(number: WhatsApplink)
        
    }
    
    func dialNumber(number : String) {

     if let url = URL(string: "tel://\(number)"),
       UIApplication.shared.canOpenURL(url) {
          if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler:nil)
           } else {
               UIApplication.shared.openURL(url)
           }
       } else {
                // add error message here
       }
    }
    
    
    @IBAction func twitterBtn(sender: UIButton){
        sender.showsTouchWhenHighlighted = true
        guard let url = URL(string: twitterLink) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func instagramBtn(sender: UIButton){
        sender.showsTouchWhenHighlighted = true
        guard let url = URL(string: instgramLink) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func snapchatBtn(sender: UIButton){
        
        sender.showsTouchWhenHighlighted = true
        guard let url = URL(string: snapchatLink) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
    }
    
    
    @IBAction func WhatsAppAction(_ sender: Any) {
        
        let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(WhatsApplink)")!
        print(appURL)
        if UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(appURL)
            }
        } else {
            // WhatsApp is not installed
        }
    }
    
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        if FullNameTf.text?.isEmpty != true ,MailTf.text?.isEmpty != true,PhoneTf.text?.isEmpty != true,desTxt.text?.isEmpty != true {
            
            ContactUsRequest()
            

            
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
            
            if desTxt.text?.isEmpty == true {
                ErrorLineAnimiteTextView(text: desTxt, lineView: desLineView, ishidden: false)
            }
            
            self.view.shake()
            
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == FullNameTf {
            
            EnableLineAnimite(text: FullNameTf, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user-1"), lineView: FullnameLineView, ishidden: false)
            
        } else if textField == PhoneTf {
            
            EnableLineAnimite(text: PhoneTf, ImageView: PhoneImage, imageEnable: #imageLiteral(resourceName: "phone-1"), lineView: PhoneLineView, ishidden: false)
            
        } else if textField == MailTf {
            
            EnableLineAnimite(text: MailTf, ImageView: MailImage, imageEnable: #imageLiteral(resourceName: "mail-1"), lineView: MailLineView, ishidden: false)
            
        }
        return true;
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField == FullNameTf {
            
            EnableLineAnimite(text: FullNameTf, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user"), lineView: FullnameLineView, ishidden: true)
            
        } else if textField == PhoneTf {
            
            EnableLineAnimite(text: PhoneTf, ImageView: PhoneImage, imageEnable: #imageLiteral(resourceName: "phone"), lineView: PhoneLineView, ishidden: true)
            
        } else if textField == MailTf {
            
            EnableLineAnimite(text: MailTf, ImageView: MailImage, imageEnable: #imageLiteral(resourceName: "mail"), lineView: MailLineView, ishidden: true)
            
        }
        
        return true;
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView ==  desTxt{
            
            EnableLineAnimiteTextView(text: desTxt, lineView: desLineView, ishidden: false)
            
        }
        return true;
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
        if textView ==  desTxt{
            
            EnableLineAnimiteTextView(text: desTxt, lineView: desLineView, ishidden: true)
            
        }
        
        return true;
    }
}


extension ContactUsVC {
    
    func AboutUs() {
        
        self.view.lock()
        
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)app-info") { (data : AboutUsModel?, String) in
            
            self.view.unlock()
            
            //  self.AdsCollectionVoew.showLoader()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.phoneNumberLabel.text  = data.data?.app_mobile ?? ""
                self.snaoChatLabel.text = data.data?.app_snapchat ?? ""
                self.instgramLabel.text = data.data?.app_instagram ?? ""
                self.twitterLabel.text = data.data?.app_twitter ?? ""
                self.whats.text  = data.data?.app_mobile ?? ""
                
                
                self.WhatsApplink = data.data?.app_whatsapp ?? ""
                self.twitterLink = "https://twitter.com/\(data.data?.app_twitter ?? "")"
                self.snapchatLink = "https://www.snapchat.com/\(data.data?.app_snapchat ?? "")"
                self.instgramLink = "https://www.instagram.com/\(data.data?.app_instagram ?? "")"
                
                
                print(data)

            }
        }
    }
    
    func ContactUsRequest() {
        
        self.view.lock()
        
        let Parameters = [
            "name" : FullNameTf.text ?? "",
            "email" : MailTf.text ?? "",
            "mobile" : PhoneTf.text ?? "",
            "message" : desTxt.text ?? ""
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)contact-us") { (data : ContactUsModel?, String) in
            
            self.view.unlock()
            
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                

                let storyboard = UIStoryboard(name: More, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "RequestSendedVC") as! RequestSendedVC
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
               
                print(data)

            }
        }
    }
    
}
