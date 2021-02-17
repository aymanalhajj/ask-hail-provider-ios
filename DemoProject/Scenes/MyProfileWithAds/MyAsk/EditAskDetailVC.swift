//
//  EditAskDetailVC.swift
//  AskHail
//
//  Created by bodaa on 17/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class EditAskDetailVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet weak var desTxt: UITextView!
    @IBOutlet weak var desLineView: UIView!
    @IBOutlet weak var desView: UIView!
    
    @IBOutlet weak var AskTitleTf: UITextField!
    @IBOutlet weak var AskTitleLineView: UIView!
    @IBOutlet weak var AskTitleView: UIView!
    @IBOutlet weak var CheckNameView: UIView!
    
    @IBOutlet weak var CheckBoxBtn: UIButton!
        
    @IBOutlet weak var ConfiemBtn: UIButton!
    
    var Order_id = ""

    var CheckBox = false
    
    var AskData : Question_details?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        AskTitleTf.text = AskData?.question_title
        desTxt.text = AskData?.question_description
        
        CheckBoxBtn.setImage(#imageLiteral(resourceName: "check"), for: .normal)
        if AskData?.question_show_name_status == "active" {
            CheckBoxBtn.setImage(#imageLiteral(resourceName: "check-1"), for: .normal)
            CheckBox = true
        }

        BackGround.backgroundColor = Colors.ViewBackGroundColoer

        AskTitleTf.delegate = self
        desTxt.delegate = self
        
        AskTitleTf.setPadding(left: 16, right: 16)
        
        setShadow(view: desView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: AskTitleView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: CheckNameView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        ConfiemBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        setShadowButton(view: ConfiemBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.8974673004, green: 0.911144314, blue: 0.922011104, alpha: 1))
        
        if AskData?.question_description == ""
        {
            if L102Language.currentAppleLanguage() == "en" {
                desTxt.text = "Description what do you ask about"
                
            }else {
                
                desTxt.text = "وصف سؤالك"
            }
            desTxt.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5)
        }
        
        desTxt.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 1)
        
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
    
    @IBAction func CheckBoxAction(_ sender: Any) {
        
        if CheckBox == false{
            CheckBoxBtn.setImage(#imageLiteral(resourceName: "check-1"), for: .normal)
            CheckBox = true
        }else{
            CheckBoxBtn.setImage(#imageLiteral(resourceName: "check"), for: .normal)
            CheckBox = false
        }
        
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        if AskTitleTf.text?.isEmpty != true , desTxt.text?.isEmpty != true {
            UpdateAskData()
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

//MARK: API
extension EditAskDetailVC {
    
    func UpdateAskData() {
        
        var state = ""
        if CheckBox == true {
            state = "active"
        }else{
            state = "block"
        }
        
        self.view.lock()
        
        let Parameters = [
            "question_id" : AskData?.question_id ?? 0,
            "title" : AskTitleTf.text ?? "",
            "description" : desTxt.text ?? "",
            "show_name_status" : state
        ] as [String : Any]
            
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)business/update-question") { (data : SuccessUpdateAskModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.view.makeToast("\(data.data?.message ?? "")")
                
            }
        }
    }
}
