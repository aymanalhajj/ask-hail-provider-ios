//
//  SpecialConfirmTransActionVC.swift
//  AskHail
//
//  Created by bodaa on 13/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit
import Toast_Swift


class SpecialConfirmTransActionVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var NameTf: UITextField!
    @IBOutlet weak var NameImage: UIImageView!
    @IBOutlet weak var NameLineView: UIView!
    
    @IBOutlet weak var LoadingView: UIView!
    @IBOutlet weak var BankNameTf: UITextField!
    @IBOutlet weak var BankNameImage: UIImageView!
    @IBOutlet weak var BankNameLineView: UIView!
    
    @IBOutlet var ScrollBackGround: UIView!
    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var DetailView: UIView!
    
    @IBOutlet weak var Titlee: UILabel!
    @IBOutlet weak var StarRight: UIImageView!
    @IBOutlet weak var StarLeft: UIImageView!
    
   
    @IBOutlet weak var AdsPrice: UILabel!
    @IBOutlet weak var AdsTime: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var AccountBankNumberTf: UITextField!
    @IBOutlet weak var AccountBankNumberLineView: UIView!
    
    @IBOutlet weak var BankNamelbl: UILabel!
    @IBOutlet weak var BankNuberLbl: UILabel!
    @IBOutlet weak var IbanNumberLbl: UILabel!
    @IBOutlet weak var BankImage: UIImageView!
    
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    var displayPlace = ""
    
    var Model : SpecialPackageData?
    var bankData = false
    
    var bankId : String = ""
    var PaymentWay = ""
    
    var state = ""
    var Adv_Id = ""
    
    var Package_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Model?.package_id != nil {
            Package_id = "\(Model?.package_id ?? 0)"
        }
        
        getPackageData()
        getBankInformation()
        getPackageDetails()
        
        print(state)
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        ScrollBackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        LoadingView.backgroundColor = Colors.ViewBackGroundColoer
        setShadow(view: DetailView, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        NameTf.placeHolderColor = Colors.PlaceHolderColoer
        BankNameTf.placeHolderColor = Colors.PlaceHolderColoer
        AccountBankNumberTf.placeHolderColor = Colors.PlaceHolderColoer
        
        NameTf.delegate = self
        AccountBankNumberTf.delegate = self
        BankNameTf.delegate = self
        
        NameTf.setPadding(left: 16, right: 16)
        AccountBankNumberTf.setPadding(left: 16, right: 16)
        AccountBankNumberTf.setPadding(left: 16, right: 16)
        
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.8974673004, green: 0.911144314, blue: 0.922011104, alpha: 1))
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    func getPackageData() {
        
        Titlee.text = Model?.package_name
       
        AdsPrice.text = Model?.package_price
        AdsTime.text = Model?.package_duration_in_days
        desc.text = Model?.package_description
        
        if self.Model?.package_rate == "1" {
            
            self.StarRight.image = #imageLiteral(resourceName: "feature-1")
            self.StarLeft.image = #imageLiteral(resourceName: "feature-1")
            
        }
        
        if self.Model?.package_rate == "2" {
            
            self.StarRight.image = #imageLiteral(resourceName: "Blue-Star")
            self.StarLeft.image = #imageLiteral(resourceName: "Blue-Star")
        }
        
        if self.Model?.package_rate == "3" {
            
            self.StarRight.image = #imageLiteral(resourceName: "Gold-Star")
            self.StarLeft.image = #imageLiteral(resourceName: "Gold-Star")
            
        }
        
        
    }
    
    
    
    @IBAction func BankAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func CopyBankNameAction(_ sender: Any) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = BankNamelbl.text ?? ""
        
        self.navigationController?.view.makeToast("Bank Name Copied")
        
        
        print("Copied")
        
    }
    
    @IBAction func CopyBankAcountNuberAction(_ sender: Any) {
        
        let pasteboard = UIPasteboard.general
        pasteboard.string = BankNamelbl.text ?? ""
        
        self.navigationController?.view.makeToast("Bank Acount Nuber Copied")
        
        print("Copied")
        
    }
    
    @IBAction func CoptIbanNumberAction(_ sender: Any) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = IbanNumberLbl.text ?? ""
        
        self.navigationController?.view.makeToast("Bank Iban Number Copied")
        
        
        print("Copied")
        
    }
    
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        
        if NameTf.text?.isEmpty != true ,BankNameTf.text?.isEmpty != true,AccountBankNumberTf.text?.isEmpty != true {
         
            make_special()
            
        } else {
            
            if NameTf.text?.isEmpty == true {
                
                ErrorLineAnimite(text: NameTf, ImageView:NameImage , imageEnable: #imageLiteral(resourceName: "user"), lineView: NameLineView, ishidden: false)
                
            }
            
            if BankNameTf.text?.isEmpty == true {
                
                ErrorLineAnimite(text: BankNameTf, ImageView:BankNameImage , imageEnable: #imageLiteral(resourceName: "bank"), lineView: BankNameLineView, ishidden: false)
                
            }
            
            if AccountBankNumberTf.text?.isEmpty == true {
                
                ErrorLineAnimiteNoimage(text: AccountBankNumberTf, lineView: AccountBankNumberLineView, ishidden: false)
                
            }
            
            self.view.shake()
            
        }
    }
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == NameTf {
            
            EnableLineAnimite(text: NameTf, ImageView: NameImage, imageEnable: #imageLiteral(resourceName: "user-1"), lineView: NameLineView, ishidden: false)
            
        } else if textField == BankNameTf {
            
            EnableLineAnimite(text: BankNameTf, ImageView: BankNameImage, imageEnable: #imageLiteral(resourceName: "bank-1"), lineView: BankNameLineView, ishidden: false)
            
        } else if textField == AccountBankNumberTf {
            
            EnableLineAnimiteNoimage(text: AccountBankNumberTf, lineView: AccountBankNumberLineView, ishidden: false)
            
        }
        
        return true;
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField == NameTf {
            
            EnableLineAnimite(text: NameTf, ImageView: NameImage, imageEnable: #imageLiteral(resourceName: "user"), lineView: NameLineView, ishidden: true)
            
        } else if textField == BankNameTf {
            
            EnableLineAnimite(text: BankNameTf, ImageView: BankNameImage, imageEnable: #imageLiteral(resourceName: "bank"), lineView: BankNameLineView, ishidden: true)
            
        } else if textField == AccountBankNumberTf {
            
            EnableLineAnimiteNoimage(text: AccountBankNumberTf, lineView: AccountBankNumberLineView, ishidden: true)
            
        }
        
        return true;
    }
    
    
}

extension SpecialConfirmTransActionVC {
    
    func getPackageDetails() {
        
        self.LoadingView.isHidden = false
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)special-package/\(Package_id)") { (data : PackageModel?, String) in
            
            self.LoadingView.isHidden = true
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.Titlee.text = data.data?.package_name ?? ""
                
               
                self.AdsPrice.text = data.data?.package_price ?? ""
                
                self.AdsTime.text = data.data?.package_duration_in_days ?? ""
                self.desc.text = data.data?.package_description ?? ""
                
                if self.Model?.package_rate == "1" {
                    
                    self.StarRight.image = #imageLiteral(resourceName: "feature-1")
                    self.StarLeft.image = #imageLiteral(resourceName: "feature-1")
                    
                }
                
                if self.Model?.package_rate == "2" {
                    
                    self.StarRight.image = #imageLiteral(resourceName: "Blue-Star")
                    self.StarLeft.image = #imageLiteral(resourceName: "Blue-Star")
                }
                
                if self.Model?.package_rate == "3" {
                    
                    self.StarRight.image = #imageLiteral(resourceName: "Gold-Star")
                    self.StarLeft.image = #imageLiteral(resourceName: "Gold-Star")
                    
                }
                
                
                
                print(data)
                
                
            }
        }
    }
    
    func getBankInformation() {
        
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)bank-account/\(bankId)") { (data : BankModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.BankNamelbl.text = data.data?.bank_account_name ?? ""
                self.BankNuberLbl.text = data.data?.bank_account_number ?? ""
                self.IbanNumberLbl.text = data.data?.bank_account_iban ?? ""
                self.BankImage.loadImage(URL(string: data.data?.bank_account_logo ?? ""))
                
                print(data)
                
            }
        }
    }
   
    
    
    
    func make_special() {
        
        self.view.lock()
        
        let param = [
            "advertisement_id" : Adv_Id ,
            "package_id" : Model?.package_id ?? 0,
            "display_place" : displayPlace ,
            "payment_way" : PaymentWay,
            "bank_account_id" : bankId ,
            "converter_customer_name" : NameTf.text ?? "",
            "converter_bank_name" : BankNameTf.text ?? "" ,
            "converter_account_number" : AccountBankNumberTf.text ?? ""
        ] as [String : Any]
        
        
        
        
        ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)advertisement-operations/make-special") { (data : SuccessTransActionModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "PaymenSuccessesVC") as! PaymenSuccessesVC
                vc.modalPresentationStyle = .fullScreen
                vc.messege = data.data?.message ?? ""
                self.present(vc, animated: true, completion: nil)
                
                print(data)
                
                
            }
        }
    }
    
}
