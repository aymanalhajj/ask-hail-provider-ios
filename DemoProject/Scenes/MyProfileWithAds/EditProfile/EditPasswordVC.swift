//
//  EditPasswordVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/14/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class EditPasswordVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var BackGround: UIView!
    
    @IBOutlet weak var CurrentPasswordTF: UITextField!
    @IBOutlet weak var CurrentPasswordImage: UIImageView!
    @IBOutlet weak var CurrentPasswordLineView: UIView!
    
    @IBOutlet weak var NewPasswordTF: UITextField!
    @IBOutlet weak var NewPasswordImage: UIImageView!
    @IBOutlet weak var NewPasswordLineView: UIView!
    
    
    @IBOutlet weak var ConfirmPasswordTF: UITextField!
    @IBOutlet weak var ConfirmPasswordImage: UIImageView!
    @IBOutlet weak var ConfirmPasswordLineView: UIView!
    
    @IBOutlet weak var CurrentPasswordView: UIView!
    @IBOutlet weak var NewPasswordView: UIView!
    @IBOutlet weak var ConfirmPasswordView: UIView!
    
    @IBOutlet weak var SaveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        CurrentPasswordTF.delegate = self
        NewPasswordTF.delegate = self
        ConfirmPasswordTF.delegate = self
        
        CurrentPasswordTF.placeHolderColor = Colors.PlaceHolderColoer
        NewPasswordTF.placeHolderColor = Colors.PlaceHolderColoer
        ConfirmPasswordTF.placeHolderColor = Colors.PlaceHolderColoer
        
        CurrentPasswordTF.setPadding(left: 16, right: 16)
        NewPasswordTF.setPadding(left: 16, right: 16)
        ConfirmPasswordTF.setPadding(left: 16, right: 16)
        
        SaveBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        setShadowButton(view: SaveBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.8974673004, green: 0.911144314, blue: 0.922011104, alpha: 1))
        
        setShadow(view: CurrentPasswordView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: NewPasswordView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: ConfirmPasswordView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func BackAcrion(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func SaveAction(_ sender: Any) {
        
        
        if CurrentPasswordTF.text?.isEmpty != true , NewPasswordTF.text?.isEmpty != true , ConfirmPasswordTF.text?.isEmpty != true {
            
            EditPassword()
            
            
        } else {
            
            if CurrentPasswordTF.text?.isEmpty == true {
                
            ErrorLineAnimite(text: CurrentPasswordTF, ImageView: CurrentPasswordImage, imageEnable: #imageLiteral(resourceName: "password"), lineView: CurrentPasswordLineView, ishidden: false)
                
            }
            
            if NewPasswordTF.text?.isEmpty == true {
                
                ErrorLineAnimite(text: NewPasswordTF, ImageView: NewPasswordImage, imageEnable: #imageLiteral(resourceName: "password"), lineView: NewPasswordLineView, ishidden: false)
            }
            
            if ConfirmPasswordTF.text?.isEmpty == true {
                
                ErrorLineAnimite(text: ConfirmPasswordTF, ImageView: ConfirmPasswordImage, imageEnable: #imageLiteral(resourceName: "password"), lineView: ConfirmPasswordLineView, ishidden: false)
            }
            self.view.shake()
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == CurrentPasswordTF {
            EnableLineAnimite(text: CurrentPasswordTF, ImageView: CurrentPasswordImage, imageEnable: #imageLiteral(resourceName: "password-1"), lineView: CurrentPasswordLineView, ishidden: false)
        }else if textField == NewPasswordTF {
            EnableLineAnimite(text: NewPasswordTF, ImageView: NewPasswordImage, imageEnable: #imageLiteral(resourceName: "password-1"), lineView: NewPasswordLineView, ishidden: false)
        }else if textField == ConfirmPasswordTF{
            EnableLineAnimite(text: ConfirmPasswordTF, ImageView: ConfirmPasswordImage, imageEnable: #imageLiteral(resourceName: "password-1"), lineView: ConfirmPasswordLineView, ishidden: false)
        }
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text?.isEmpty == true {
            
            if textField == CurrentPasswordTF {
                EnableLineAnimite(text: CurrentPasswordTF, ImageView: CurrentPasswordImage, imageEnable: #imageLiteral(resourceName: "password"), lineView: CurrentPasswordLineView, ishidden: true)
            }else if textField == NewPasswordTF {
                EnableLineAnimite(text: NewPasswordTF, ImageView: NewPasswordImage, imageEnable: #imageLiteral(resourceName: "password"), lineView: NewPasswordLineView, ishidden: true)
            }else if textField == ConfirmPasswordTF{
                EnableLineAnimite(text: ConfirmPasswordTF, ImageView: ConfirmPasswordImage, imageEnable: #imageLiteral(resourceName: "password"), lineView: ConfirmPasswordLineView, ishidden: true)
            }
            
        }
        return true;
    }
    
}

extension EditPasswordVC {
    
    func EditPassword() {
        self.view.lock()
        
        let Parameters = [
            "old_password" : CurrentPasswordTF.text ?? "",
            "new_password" : NewPasswordTF.text ?? "" ,
            "new_password_confirmation" : ConfirmPasswordTF.text ?? ""
        ]
        
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)change-password") { (data : Level_6_Model?, String) in
            self.view.unlock()
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.navigationController?.popToViewController(ofClass: MyInfoVC.self, animated: true)
                self.navigationController?.view.makeToast("\(data.data ?? "")")

                print(data)
                
                
            }
        }
    }
    
}
