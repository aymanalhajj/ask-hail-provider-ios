//
//  ForgetPasswordVC_3.swift
//  DemoProject
//
//  Created by Abdullah Tarek on 10/28/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class ForgetPasswordVC_3: UIViewController ,UITextFieldDelegate {
    
    @IBOutlet weak var PasswordTf1: UITextField!
    @IBOutlet weak var PasswordTf2: UITextField!
    @IBOutlet weak var PasswordImage1: UIImageView!
    @IBOutlet weak var PasswordImage2: UIImageView!
    @IBOutlet weak var PasswordLineView1: UIView!
    @IBOutlet weak var PasswordLineView2: UIView!
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    @IBOutlet weak var PasswordView: UIView!
    @IBOutlet weak var PasswordView2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PasswordTf1.delegate = self
        PasswordTf2.delegate = self
        
        PasswordTf1.placeHolderColor = Colors.PlaceHolderColoer
        PasswordTf2.placeHolderColor = Colors.PlaceHolderColoer
        
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        setShadow(view: PasswordView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: PasswordView2, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        PasswordTf1.setPadding(left: 16, right: 16)
        PasswordTf2.setPadding(left: 16, right: 16)
        
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func Confitm(_ sender: Any) {
        
        if PasswordTf1.text?.isEmpty != true , PasswordTf2.text?.isEmpty != true {
            
            SetNewPassword()
            view.lock()
            
        } else {
            
            if PasswordTf1.text?.isEmpty == true {
                
                ErrorLineAnimite(text: PasswordTf1, ImageView: PasswordImage1, imageEnable: #imageLiteral(resourceName: "password-2"), lineView: PasswordLineView1, ishidden: false)
                
            }
            
            if PasswordTf2.text?.isEmpty == true  {
                
                ErrorLineAnimite(text: PasswordTf2, ImageView: PasswordImage2, imageEnable: #imageLiteral(resourceName: "password-2"), lineView: PasswordLineView2, ishidden: false)
                
            }
            
            self.view.shake()
            
        }
        
    }
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == PasswordTf1 {
            EnableLineAnimite(text: PasswordTf1, ImageView: PasswordImage1, imageEnable: #imageLiteral(resourceName: "password-1"), lineView: PasswordLineView1, ishidden: false)
        }else if textField == PasswordTf2 {
            EnableLineAnimite(text: PasswordTf2, ImageView: PasswordImage2, imageEnable: #imageLiteral(resourceName: "password-1"), lineView: PasswordLineView2, ishidden: false)
        }
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text?.isEmpty == true {
            
            if textField == PasswordTf1 {
                EnableLineAnimite(text: PasswordTf1, ImageView: PasswordImage1, imageEnable: #imageLiteral(resourceName: "password"), lineView: PasswordLineView1, ishidden: true)
            } else if textField == PasswordTf2 {
                EnableLineAnimite(text: PasswordTf2, ImageView: PasswordImage2, imageEnable: #imageLiteral(resourceName: "password"), lineView: PasswordLineView2, ishidden: true)
            }
            
        }
        
        return true;
    }
}

extension ForgetPasswordVC_3 {
    
    func SetNewPassword() {
        
        
        let Parameters = [
            "advertiser_id" : Helper.getaUser_id() ?? "" ,
            "password" : PasswordTf1.text ?? "",
            "password_confirmation" : PasswordTf2.text ?? ""
        ]
        
        print(Parameters)
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)business/forget-level3-new-password") { (data : SetNewPasswordModel?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                self.view.unlock()
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.view.unlock()
                
                self.navigationController?.popToRootViewController(animated: true)
                
                print(data)
                
                
            }
        }
    }
    
}
