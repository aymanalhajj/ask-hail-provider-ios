//
//  OrderAddNewNumberVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/4/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

protocol  AddPhone {
    func getPhone(Phone : String)
}

class OrderAddNewNumberVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var PhoneTf: UITextField!
    @IBOutlet weak var PhoneImage: UIImageView!
    @IBOutlet weak var PhoneLineView: UIView!
    @IBOutlet weak var PhoneView: UIView!
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    var Delegate : AddPhone?
    
    var state = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAnimate()
        
        if L102Language.currentAppleLanguage() == englishLang {
            
            PhoneView.semanticContentAttribute = .forceLeftToRight
            
        }
        
        PhoneTf.placeHolderColor = Colors.PlaceHolderColoer
        
        PhoneTf.delegate = self
        PhoneTf.setPadding(left: 16, right: 16)
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer, ColorButtom: Colors.ButtomGradBtnColoer)
        
        
        
    }
    
    @IBAction func CancelAction(_ sender: Any) {
        
        removeAnimate()
        
    }
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        if PhoneTf.text?.isEmpty == true {
            
            ErrorLineAnimite(text: PhoneTf, ImageView: PhoneImage, imageEnable: #imageLiteral(resourceName: "phone"), lineView: PhoneLineView, ishidden: false)
            
        } else {
            
            
            Delegate?.getPhone(Phone: self.PhoneTf.text ?? "")
            
            removeAnimate()
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == PhoneTf {
            
            EnableLineAnimite(text: PhoneTf, ImageView: PhoneImage, imageEnable: #imageLiteral(resourceName: "phone-1"), lineView: PhoneLineView, ishidden: false)
            
        }
        return true;
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField == PhoneTf {
            
            EnableLineAnimite(text: PhoneTf, ImageView: PhoneImage, imageEnable: #imageLiteral(resourceName: "phone"), lineView: PhoneLineView, ishidden: true)
            
        }
        
        return true;
    }
    
}

