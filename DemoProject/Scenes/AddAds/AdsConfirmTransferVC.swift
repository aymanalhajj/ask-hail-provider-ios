//
//  AdsConfirmTransferVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/7/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit


enum ComeFrom : String {
    case reNewPackage = "reNewPackage"
    case updatePackage = "updatePackage"
    case starAdv = "starAdv"
}

class AdsConfirmTransferVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var NameTf: UITextField!
    @IBOutlet weak var NameImage: UIImageView!
    @IBOutlet weak var NameLineView: UIView!
    
    @IBOutlet weak var MainView1: UIView!
    @IBOutlet weak var MainView2: UIView!
    
    @IBOutlet weak var BankNameTf: UITextField!
    @IBOutlet weak var BankNameImage: UIImageView!
    @IBOutlet weak var BankNameLineView: UIView!
    
    @IBOutlet var ScrollBackGround: UIView!
    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var DetailView: UIView!
    
    @IBOutlet weak var Titlee: UILabel!
    @IBOutlet weak var StarRight: UIImageView!
    @IBOutlet weak var StarLeft: UIImageView!
    
    @IBOutlet weak var NumberAds: UILabel!
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
    
    var Model : PackagesData?
    var bankData = false
    
    var bankId : String = ""
    var PaymentWay = ""
    
    var state = ""
    var Adv_Id = ""

    var Package_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainView1.isHidden = true
        MainView2.isHidden = true
        
        if Model?.package_id != nil {
            Package_id = "\(Model?.package_id ?? 0)"
        }
        
        getPackageData()
        getBankInformation()
        getPackageDetails()
        
        print(state)
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        ScrollBackGround.backgroundColor = Colors.ViewBackGroundColoer
        
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
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    func getPackageData() {
        
        Titlee.text = Model?.package_name
        NumberAds.text = Model?.package_advertisements_count
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
            if state == ComeFrom.reNewPackage.rawValue || state == ComeFrom.updatePackage.rawValue {
                if state == ComeFrom.reNewPackage.rawValue{
                    ReNewPackage()
                } else if state == ComeFrom.updatePackage.rawValue {
                    UpdatePackage()
                }
            }else{
                AddNewPackage()
            }
            
            
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

extension AdsConfirmTransferVC {
    
    func getPackageDetails() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)package/\(Package_id)") { (data : PackageModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.Titlee.text = data.data?.package_name ?? ""

                self.NumberAds.text = data.data?.package_advertisements_count ?? ""
                self.AdsPrice.text = data.data?.package_price ?? ""
                
                self.AdsTime.text = data.data?.package_duration_in_days ?? ""
                self.desc.text = data.data?.package_description ?? ""
                
                if data.data?.package_rate == "1" {
                    
                    self.StarRight.image = #imageLiteral(resourceName: "feature-1")
                    self.StarLeft.image = #imageLiteral(resourceName: "feature-1")
                    
                }
                
                if data.data?.package_rate == "2" {
                    
                    self.StarRight.image = #imageLiteral(resourceName: "Blue-Star")
                    self.StarLeft.image = #imageLiteral(resourceName: "Blue-Star")
                }
                
                if data.data?.package_rate == "3" {
                    
                    self.StarRight.image = #imageLiteral(resourceName: "Gold-Star")
                    self.StarLeft.image = #imageLiteral(resourceName: "Gold-Star")
                    
                }
                
                
                self.MainView1.isHidden = false
                self.MainView2.isHidden = false
                
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
    
    func AddNewPackage() {
        
        self.view.lock()
        
        let param = [
            "package_id" : "\(Model?.package_id ?? 0)",
            "payment_time" : "now",
            "payment_way" : "bank" ,
            "bank_account_id" : bankId ,
            "converter_customer_name" : NameTf.text ?? "",
            "converter_bank_name" : BankNameTf.text ?? "" ,
            "converter_account_number" : AccountBankNumberTf.text ?? ""
        ] as [String : Any]
        
        print(param)
        
        ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)businedd-add-advertisement/add-package") { (data : Level_1_Model?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "AdsSuccessTransferVC") as! AdsSuccessTransferVC
                vc.Adv_Id = "\(data.data?.advertisement_id ?? 0)"
                print(data.data?.advertisement_id ?? 0)
                self.navigationController?.pushViewController(vc, animated: true)
                
                print(data)
                
                
            }
        }
    }
    
    
    func ReNewPackage() {
        
        self.view.lock()
        
        let param = [
            "payment_way" : PaymentWay ,
            "bank_account_id" : bankId ,
            "converter_customer_name" : NameTf.text ?? "",
            "converter_bank_name" : BankNameTf.text ?? "" ,
            "converter_account_number" : AccountBankNumberTf.text ?? ""
        ] as [String : Any]
        
        print(param)
        
        ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)renew-package") { (data : Level_6_Model?, String) in
            
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
                vc.messege = data.data ?? ""
                self.present(vc, animated: true, completion: nil)
                
                print(data)
                
                
            }
        }
    }
    
    func UpdatePackage() {
        
        self.view.lock()
        
        let param = [
            "package_id" : Model?.package_id ?? 0,
            "payment_way" : PaymentWay ,
            "bank_account_id" : bankId ,
            "converter_customer_name" : NameTf.text ?? "",
            "converter_bank_name" : BankNameTf.text ?? "" ,
            "converter_account_number" : AccountBankNumberTf.text ?? ""
        ] as [String : Any]
        
        
        
        
        ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)update-package") { (data : Level_6_Model?, String) in
            
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
                vc.messege = data.data ?? ""
                self.present(vc, animated: true, completion: nil)
                
                print(data)
                
                
            }
        }
    }
    
}
