//
//  CreateAccount_2.swift
//  DemoProject
//
//  Created by Abdullah Tarek on 10/28/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import OTPFieldView

class CreateAccount_2: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var TF1: UITextField!
    @IBOutlet weak var TF2: UITextField!
    @IBOutlet weak var TF3: UITextField!
    @IBOutlet weak var TF4: UITextField!
    
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var View2: UIView!
    @IBOutlet weak var View3: UIView!
    @IBOutlet weak var View4: UIView!
    
    @IBOutlet weak var ConfirmCodeStack: UIStackView!
    
    @IBOutlet weak var ConfirmBtn: UIButton!

    @IBOutlet weak var dontSetYetLbl: UILabel!
    
    @IBOutlet weak var ResendCodeTimerLabl: UILabel!
    @IBOutlet weak var ResendCodeBtn: UIButton!
    
    var runCount = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ResendCodeBtn.isEnabled = false
        dontSetYetLbl.isHidden = false
        
        let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Tajawal-Bold", size: 14), NSAttributedString.Key.foregroundColor : Colors.DarkBlue]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Tajawal-Bold", size: 14), NSAttributedString.Key.foregroundColor : UIColor(hexString: "#FF7A94")]
        
        let attributedString1 = NSMutableAttributedString(string:"You can request another code within".localized, attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string: "60 second".localized, attributes:attrs2)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        
        
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
        self.ResendCodeTimerLabl.attributedText = attributedString1
        
        self.ResendCodeTimerLabl.textAlignment = .center
        
        resetTimer()
        
        if L102Language.currentAppleLanguage() == englishLang{
            ConfirmCodeStack.semanticContentAttribute = .forceLeftToRight

        }
        
        
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        TF1.becomeFirstResponder()
        
        TF1.addTarget(self, action: #selector(textFieldDidChange1), for: .editingChanged)
        TF2.addTarget(self, action: #selector(textFieldDidChange2), for: .editingChanged)
        TF3.addTarget(self, action: #selector(textFieldDidChange3), for: .editingChanged)
        TF4.addTarget(self, action: #selector(textFieldDidChange4), for: .editingChanged)
        
        
        TF1.delegate = self
        TF2.delegate = self
        TF3.delegate = self
        TF4.delegate = self
        
        
        
        
    }
    
    
    func resetTimer() {
        
        runCount = 60
    

        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            
            self.runCount -= 1
            
            self.dontSetYetLbl.font = UIFont(name: "Tajawal-Bold", size: 14)
            self.dontSetYetLbl.text = "Didn't receive the code?".localized
            
            let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Tajawal-Bold", size: 14), NSAttributedString.Key.foregroundColor : Colors.DarkBlue]
            
            let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Tajawal-Bold", size: 14), NSAttributedString.Key.foregroundColor : UIColor(hexString: "#FF7A94")]
            
            let attributedString1 = NSMutableAttributedString(string:"You can request another code within".localized, attributes:attrs1)
            
            let attributedString2 = NSMutableAttributedString(string: " \(self.runCount)" + "second".localized, attributes:attrs2)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            
            
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
            self.ResendCodeTimerLabl.attributedText = attributedString1
            
            self.ResendCodeTimerLabl.textAlignment = .center

            if self.runCount == 0 {
                self.dontSetYetLbl.isHidden = true
                self.ResendCodeTimerLabl.text = "Send now".localized
                self.ResendCodeTimerLabl.font = UIFont(name: "Tajawal-Bold", size: 16)
                self.ResendCodeBtn.isEnabled = true
                timer.invalidate()
                
            }
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func ResendConfitmCodeAction(_ sender: Any) {
        
        
        ResendConfirmCode()
        
        dontSetYetLbl.isHidden = false
        ResendCodeBtn.isEnabled = false
        
    }
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        if TF1.text?.isEmpty != true , TF2.text?.isEmpty != true , TF3.text?.isEmpty != true , TF4.text?.isEmpty != true {
            
            ConfitmCode()
            
            
        } else {
            
            View1.borderColor = Colors.errorLineView
            View1.borderWidth = 2
            
            View2.borderColor = Colors.errorLineView
            View2.borderWidth = 2
            
            View3.borderColor = Colors.errorLineView
            View3.borderWidth = 2
            
            View4.borderColor = Colors.errorLineView
            View4.borderWidth = 2
            
            
            self.view.shake()
            
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == TF1 {
            
            textField.text = ""
            View1.backgroundColor = #colorLiteral(red: 0, green: 0.2846388221, blue: 0.497141242, alpha: 1)
            View1.borderWidth = 1
            
        } else if textField == TF2 {
            
            textField.text = ""
            View2.backgroundColor = #colorLiteral(red: 0, green: 0.2846388221, blue: 0.497141242, alpha: 1)
            View2.borderWidth = 1
            
        } else if textField == TF3 {
            
            textField.text = ""
            View3.backgroundColor = #colorLiteral(red: 0, green: 0.2846388221, blue: 0.497141242, alpha: 1)
            View3.borderWidth = 1
            
        } else if textField == TF4 {
            
            textField.text = ""
            View4.backgroundColor = #colorLiteral(red: 0, green: 0.2846388221, blue: 0.497141242, alpha: 1)
            View4.borderWidth = 1
            
        }
        
    }
    
    @objc func textFieldDidChange1()  {
        View1.backgroundColor = .clear
        
        if TF1.text?.count == 1 {
            
            TF2.becomeFirstResponder()
        }
    }
    
    @objc func textFieldDidChange2()  {
        View2.backgroundColor = .clear
        
        if TF2.text?.count == 1 {
            TF3.becomeFirstResponder()
        }
    }
    
    @objc func textFieldDidChange3()  {
        View3.backgroundColor = .clear
        
        if TF3.text?.count == 1 {
            TF4.becomeFirstResponder()
        }
    }
    
    @objc func textFieldDidChange4()  {
        View4.backgroundColor = .clear
        if TF4.text?.count == 1 {
            TF4.resignFirstResponder()
            
            if TF1.text?.isEmpty != true , TF2.text?.isEmpty != true , TF3.text?.isEmpty != true , TF4.text?.isEmpty != true {
                
                ConfitmCode()
                
                
            } else {
                
                View1.borderColor = Colors.errorLineView
                View1.borderWidth = 2
                
                View2.borderColor = Colors.errorLineView
                View2.borderWidth = 2
                
                View3.borderColor = Colors.errorLineView
                View3.borderWidth = 2
                
                View4.borderColor = Colors.errorLineView
                View4.borderWidth = 2
                
                
                self.view.shake()
                
            }
            
        }
    }
    
}

extension CreateAccount_1: OTPFieldViewDelegate {
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        
        return true
    }
    
    func enteredOTP(otp: String) {
        
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        
        return false
    }
}


extension CreateAccount_2 {
    
    func ConfitmCode() {
        
        view.lock()
        
        let Parameters = [
            "advertiser_id" : Helper.getaUser_id() ?? "",
            "active_code" : "\(TF1.text ?? "")\(TF2.text ?? "")\(TF3.text ?? "")\(TF4.text ?? "")"  ?? ""
        ]
        
        print(Parameters)
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)business/register-level2-check-active-code") { (data : RegisterModel_2?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                
                let storyboard = UIStoryboard(name: Authontication, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "CreateAccount_3") as! CreateAccount_3
                self.navigationController?.pushViewController(vc, animated: true)
                
                self.view.unlock()
                
                
                print(data)
                
                
            }
        }
    }
    
    func ResendConfirmCode() {
        
        let Parameters = [
            "advertiser_id" : Helper.getaUser_id() ?? ""
        ]
        
        print(Parameters)
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)business/forget-level2-resend-forget-code") { (data : ResendConfirmCodeModel?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }

                self.TF1.text = ""
                self.TF2.text = ""
                self.TF3.text = ""
                self.TF4.text = ""
                self.resetTimer()
                
                print(data)
                
                
            }
        }
    }
    
}
