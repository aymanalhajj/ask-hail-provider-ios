//
//  AskDetailsVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/8/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class AskDetailsVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var desTxt: UITextView!
    @IBOutlet weak var desLineView: UIView!
    
    @IBOutlet weak var AskTitleTf: UITextField!
    @IBOutlet weak var AskTitleLineView: UIView!
    
    @IBOutlet weak var CheckBoxBtn: UIButton!
        
    @IBOutlet weak var ConfiemBtn: UIButton!
        
   
    
    var Image = UIImageView()
    
    var CheckBox = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AskTitleTf.placeHolderColor = Colors.PlaceHolderColoer
        
        AskTitleTf.delegate = self
        desTxt.delegate = self
        
        AskTitleTf.setPadding(left: 16, right: 16)
        
        setShadowButton(view: ConfiemBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        ConfiemBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        
        // Do any additional setup after loading the view.
        
        if L102Language.currentAppleLanguage() == "en" {
            desTxt.text = "Description what do you ask about"
            
        }else {
            
            desTxt.text = "وصف سؤالك"
        }
        
        desTxt.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if desTxt.textColor == #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5) {
            desTxt.text = ""
            desTxt.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 1)
        }
    }
    
    @IBAction func CheckBoxAction(_ sender: Any) {
        
        if CheckBox == false{
            CheckBoxBtn.setImage(#imageLiteral(resourceName: "check-1"), for: .normal)
            CheckBox = true
        }else{
            CheckBoxBtn.setImage(#imageLiteral(resourceName: "check"), for: .normal)
            CheckBox = false
        }
        
    }
    
    
    @IBAction func BackAcrion(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        if AskTitleTf.text?.isEmpty != true , desTxt.text?.isEmpty != true {
            AddAsk()
        
            
        }else {
            if AskTitleTf.text?.isEmpty == true{
                ErrorLineAnimiteNoimage(text: AskTitleTf, lineView: AskTitleLineView, ishidden: false)
            }
            if desTxt.text?.isEmpty == true {
                ErrorLineAnimiteTextView(text: desTxt, lineView: desLineView, ishidden: false)
            }
            
            self.view.shake()
            
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == AskTitleTf {
            
            EnableLineAnimiteNoimage(text: AskTitleTf, lineView: AskTitleLineView, ishidden: false)
        }
        
        return true;
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField == AskTitleTf {
            
            EnableLineAnimiteNoimage(text: AskTitleTf, lineView: AskTitleLineView, ishidden: true)
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


extension AskDetailsVC {
    
    func AddAsk() {
        
        var showNameState = ""
        
        if CheckBox == true {
            showNameState = "active"
        }else{
            showNameState = "block"
        }
        
        self.view.lock()
        
        let Parameters = [
            "title" : AskTitleTf.text ?? "" ,
            "description" : desTxt.text ?? "" ,
            "show_name_status" : showNameState
        ]
        
        
        ApiServices.instance.uploadImage(methodType: .post, parameters: Parameters as [String : AnyObject], url: "\(hostName)business/add-question", imagesArray: nil, profileImage: nil, commercial_register_image: Image.image, office_license_image: nil, id_image: nil, VediosArray: nil, VediosDuration: nil) { (data : Level_6_Model?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
               self.view.unlock()
                
            }else {
                
                guard let data = data else {
                    return
                }
         
                print(data)
                
                let storyboard = UIStoryboard(name:AddAskHail, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "AskSuccessAddVC") as! AskSuccessAddVC
                vc.messege = data.data ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
                
                
            }
        }
    }
    
}
