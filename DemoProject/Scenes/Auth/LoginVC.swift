 //
 //  LoginVC.swift
 //  DemoProject
 //
 //  Created by Abdullah Tarek on 10/28/20.
 //  Copyright © 2020 MOHAB. All rights reserved.
 //
 
 
 
 import UIKit
 
 class LoginVC: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var ConfitmBtn: UIButton!
    @IBOutlet weak var PhoneTF: UITextField!
    @IBOutlet weak var PhoneImage: UIImageView!
    @IBOutlet weak var PhoneLineView: UIView!
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordImage: UIImageView!
    @IBOutlet weak var passwordLineView: UIView!
    
    @IBOutlet weak var PhoneView: UIView!
    @IBOutlet weak var PasswordView: UIView!
    
    var isVisitor = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isVisitor  {
            
            Helper.restartApp("Home")
        }
        
        if L102Language.currentAppleLanguage() == englishLang {
            
            PhoneView.semanticContentAttribute = .forceLeftToRight
            
        }
        
        
        PhoneTF.delegate = self
        passwordTF.delegate = self
        
        PhoneTF.placeHolderColor = Colors.PlaceHolderColoer
        passwordTF.placeHolderColor = Colors.PlaceHolderColoer
        
        PhoneTF.setPadding(left: 16, right: 16)
        passwordTF.setPadding(left: 16, right: 16)
        
        ConfitmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        
        setShadowButton(view: ConfitmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        setShadow(view: PhoneView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: PasswordView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    
    @IBAction func LoginAction(_ sender: Any) {
        
        
        if PhoneTF.text?.isEmpty != true , passwordTF.text?.isEmpty != true {
            
            login()
            view.lock()
            
        } else {
            
            if PhoneTF.text?.isEmpty == true {
                
            ErrorLineAnimite(text: PhoneTF, ImageView: PhoneImage, imageEnable: #imageLiteral(resourceName: "phone"), lineView: PhoneLineView, ishidden: false)
                
            }
            
            if passwordTF.text?.isEmpty == true {
                
                ErrorLineAnimite(text: passwordTF, ImageView: passwordImage, imageEnable: #imageLiteral(resourceName: "password"), lineView: passwordLineView, ishidden: false)
            }
            
            self.view.shake()
        }
        
       
  
    }
    
    
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func ForgetPasswordAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Authontication, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "ForgetPasswordVC_1") as! ForgetPasswordVC_1
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == PhoneTF {
            
            EnableLineAnimite(text: PhoneTF, ImageView: PhoneImage, imageEnable: #imageLiteral(resourceName: "phone-1"), lineView: PhoneLineView, ishidden: false)
            PhoneTF.textAlignment = .left
            
        } else if textField == passwordTF {
            
            EnableLineAnimite(text: passwordTF, ImageView: passwordImage, imageEnable: #imageLiteral(resourceName: "password-1"), lineView: passwordLineView, ishidden: false)
            
        }
        
        return true;
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text == "" {
            if textField == PhoneTF {
                
                EnableLineAnimite(text: textField, ImageView: PhoneImage, imageEnable: #imageLiteral(resourceName: "phone"), lineView: PhoneLineView, ishidden: true)
                
            }else if textField == passwordTF {
                
                EnableLineAnimite(text: passwordTF, ImageView: passwordImage, imageEnable: #imageLiteral(resourceName: "password"), lineView: passwordLineView, ishidden: true)
                
            }
        }
        return true;
    }
    
 }
 
 
 extension LoginVC {
    
    
     
     func login() {

        var Parameters = [ "mobile" : PhoneTF.text ?? "",
                           "password" : passwordTF.text ?? "" ,
                           "firebase_token" : Helper.getFcmtoken() ?? "fcmToken"
        ]
        
        print(Parameters)
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)business/login") { (data : LoginModel?, String) in
             
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

                
                self.view.unlock()
                
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "HomeVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
                 print(data)
                 
                 
             }
         }
     }
     
 }
