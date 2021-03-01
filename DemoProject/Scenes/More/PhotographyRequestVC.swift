//
//  PhotographyRequestVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/1/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import IQKeyboardManager

class PhotographyRequestVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet var TopBar: UIView!
    @IBOutlet var BackGround: UIView!
    
    
    @IBOutlet weak var desTxt: UITextView!
    @IBOutlet weak var desLineView: UIView!
    @IBOutlet weak var desView: UIView!
    
    @IBOutlet weak var BuildingTyteTf: UITextField!
    @IBOutlet weak var BuildingTyteImage: UIImageView!
    @IBOutlet weak var BuildingTyteLineView: UIView!
    @IBOutlet weak var BuildingTyteView: UIView!
    
    @IBOutlet weak var FullNameTf: UITextField!
    @IBOutlet weak var FullnameImage: UIImageView!
    @IBOutlet weak var FullnameLineView: UIView!
    @IBOutlet weak var FullNameView: UIView!
    
    @IBOutlet weak var PhoneTf: UITextField!
    @IBOutlet weak var PhoneImage: UIImageView!
    @IBOutlet weak var PhoneLineView: UIView!
    @IBOutlet weak var PhoneView: UIView!
    
    @IBOutlet weak var VisitDateTf: UITextField!
    @IBOutlet weak var VisitDateImage: UIImageView!
    @IBOutlet weak var VisitDateLineView: UIView!
    @IBOutlet weak var VisitDateView: UIView!
    
    
    @IBOutlet weak var VisitTimeTf: UITextField!
    @IBOutlet weak var VisitTimeImage: UIImageView!
    @IBOutlet weak var VisitTimeLineView: UIView!
    @IBOutlet weak var VisitTimeView: UIView!
    
    var pickerOfDate = UIDatePicker()
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    var SectionsArrayAr = ["للبيع" , "للايجار"]
    var SectionsArrayEn = [ "buy" , "rent"]
    
    var SectionsPicker = UIPickerView()
    var Category_id : String = ""
    let timePicker = UIDatePicker()
    
    let currentDate = Date()
    var api_time = ""
    
    override func viewDidDisappear(_ animated: Bool) {
        IQKeyboardManager.shared().isEnabled = true
    }
    override func viewWillAppear(_ animated: Bool) {
        IQKeyboardManager.shared().isEnabled = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if L102Language.currentAppleLanguage() == englishLang {
            PhoneView.semanticContentAttribute = .forceLeftToRight
        }

        
        BuildingTyteTf.placeHolderColor = Colors.PlaceHolderColoer
        PhoneTf.placeHolderColor = Colors.PlaceHolderColoer
        FullNameTf.placeHolderColor = Colors.PlaceHolderColoer
        VisitDateTf.placeHolderColor = Colors.PlaceHolderColoer
        VisitTimeTf.placeHolderColor = Colors.PlaceHolderColoer
        
        BuildingTyteTf.delegate = self
        PhoneTf.delegate = self
        FullNameTf.delegate = self
        VisitTimeTf.delegate = self
        VisitDateTf.delegate = self
        desTxt.delegate = self
        
        BuildingTyteTf.setPadding(left: 16, right: 16)
        PhoneTf.setPadding(left: 16, right: 16)
        FullNameTf.setPadding(left: 16, right: 16)
        VisitTimeTf.setPadding(left: 16, right: 16)
        VisitDateTf.setPadding(left: 16, right: 16)
        
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.8974673004, green: 0.911144314, blue: 0.922011104, alpha: 1))
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        setShadow(view: FullNameView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: BuildingTyteView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: PhoneView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: VisitDateView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: VisitTimeView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: desView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        
        self.BuildingTyteTf.inputView = SectionsPicker
        self.initPickers(picker: self.SectionsPicker)
        
        self.VisitDateTf.inputView = pickerOfDate
        self.VisitTimeTf.inputView = timePicker
        
        let loc = Locale(identifier: "en")
        self.timePicker.locale = loc
        self.pickerOfDate.locale = loc
        self.timePicker.datePickerMode = .time
        self.pickerOfDate.datePickerMode = .date
        pickerOfDate.preferredDatePickerStyle = .wheels
        timePicker.preferredDatePickerStyle = .wheels
       
        pickerOfDate.minimumDate = currentDate
        
        pickerOfDate.addTarget(self, action: #selector(PhotographyRequestVC.dateChanged(datePicker:)), for: .valueChanged)
        timePicker.addTarget(self, action: #selector(PhotographyRequestVC.dateChanged(datePicker:)), for: .valueChanged)
        
        if L102Language.currentAppleLanguage() == "en" {
            
            desTxt.text = "Complite Location"
            
        }else {
            
            desTxt.text = "العنوان بالكامل"
        }
        
        desTxt.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5)
        
    }
    
    @objc func dateChanged(datePicker : UIDatePicker) {
             
           if datePicker == pickerOfDate {
             let dateFormatter = DateFormatter()
               dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale
         dateFormatter.dateFormat = "yyyy-MM-dd"
         VisitDateTf.text = dateFormatter.string(from: pickerOfDate.date)
               
            
               
           }else {
            
            
            let dateFormatter_api = DateFormatter()
            dateFormatter_api.locale = NSLocale(localeIdentifier: "en") as Locale
            dateFormatter_api.dateFormat = "HH:MM:SS"
            api_time = dateFormatter_api.string(from: timePicker.date)
            
            let dateFormatter = DateFormatter()
            if L102Language.currentAppleLanguage() == englishLang {
                dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale
            }else{
                dateFormatter.locale = NSLocale(localeIdentifier: "ar") as Locale
            }
            
            dateFormatter.dateFormat = "hh:mm a"
            
            VisitTimeTf.text = dateFormatter.string(from: timePicker.date)
            
            //            var time = dateFormatter.string(from: timePicker.date)
            //
            //            var time_1 = ""
            //            if time.contains("AM") {
            //                if L102Language.currentAppleLanguage() == englishLang {
            //                    time_1.append(" AM")
            //                }else{
            //                    time_1.append("صباحا ")
            //                }
            //
            //            }else{
            //                if L102Language.currentAppleLanguage() == englishLang {
            //                    time_1.append(" PM")
            //                }else{
            //                    time_1.append("مساء ")
            //                }
            //            }
            
           }
             
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
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if  desTxt.text == ""{
            desTxt.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5)
            if L102Language.currentAppleLanguage() == "en" {
                desTxt.text = "Complite Location"
                desTxt.textAlignment = .left
            }else {
                desTxt.textAlignment = .right
                desTxt.text = "العنوان بالكامل"
            }
            
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
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        
        if desTxt.text?.isEmpty != true ,BuildingTyteTf.text?.isEmpty != true,
           FullNameTf.text?.isEmpty != true,PhoneTf.text?.isEmpty != true,VisitDateTf.text?.isEmpty != true,VisitTimeTf.text?.isEmpty != true {
            
            requestPhotoGraph()
            
        } else {
            
            if desTxt.text?.isEmpty == true {
                ErrorLineAnimiteTextView(text: desTxt, lineView: desLineView, ishidden: false)
            }
            if BuildingTyteTf.text?.isEmpty == true {
                ErrorLineAnimite(text: BuildingTyteTf, ImageView: BuildingTyteImage, imageEnable: #imageLiteral(resourceName: "building-1"), lineView: BuildingTyteLineView, ishidden: false)
            }
            if FullNameTf.text?.isEmpty == true {
                
                ErrorLineAnimite(text: FullNameTf, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user"), lineView: FullnameLineView, ishidden: false)
            }
            if PhoneTf.text?.isEmpty == true {
                ErrorLineAnimite(text: PhoneTf, ImageView: PhoneImage, imageEnable: #imageLiteral(resourceName: "phone"), lineView: PhoneLineView, ishidden:false)
            }
            
            if VisitDateTf.text?.isEmpty == true {
                ErrorLineAnimite(text: VisitDateTf, ImageView: VisitDateImage, imageEnable: #imageLiteral(resourceName: "calendar"), lineView: VisitDateLineView, ishidden: false)
                
      
            }
            if VisitTimeTf.text?.isEmpty == true {
                ErrorLineAnimite(text: VisitTimeTf, ImageView: VisitTimeImage, imageEnable: #imageLiteral(resourceName: "time"), lineView: VisitTimeLineView, ishidden: false)
            }
            
            self.view.shake()
            
        }
        
        
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == FullNameTf {
            
            EnableLineAnimite(text: FullNameTf, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user-1"), lineView: FullnameLineView, ishidden: false)
            
        } else if textField == PhoneTf {
            
            EnableLineAnimite(text: PhoneTf, ImageView: PhoneImage, imageEnable: #imageLiteral(resourceName: "phone-1"), lineView: PhoneLineView, ishidden: false)
            PhoneTf.textAlignment = .left
            
        } else if textField == BuildingTyteTf {
            
            EnableLineAnimite(text: BuildingTyteTf, ImageView: BuildingTyteImage, imageEnable: #imageLiteral(resourceName: "building"), lineView: BuildingTyteLineView, ishidden: false)
                
                if L102Language.currentAppleLanguage() == "en" {
                    BuildingTyteTf.text = SectionsArrayEn[0]
                }else {
                    BuildingTyteTf.text = SectionsArrayAr[0]
                }
            
        } else if textField == VisitTimeTf {
            
            EnableLineAnimite(text: VisitTimeTf, ImageView: VisitTimeImage, imageEnable: #imageLiteral(resourceName: "time"), lineView: VisitTimeLineView, ishidden: false)
            
            let dateFormatter = DateFormatter()
            if L102Language.currentAppleLanguage() == englishLang {
                dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale
            }else{
                dateFormatter.locale = NSLocale(localeIdentifier: "ar") as Locale
            }
            
            dateFormatter.dateFormat = "hh:mm a"
            
            VisitTimeTf.text = dateFormatter.string(from: timePicker.date)
            
            
        }else if textField == VisitDateTf {
            
            EnableLineAnimite(text: VisitDateTf, ImageView: VisitDateImage, imageEnable: #imageLiteral(resourceName: "calendar"), lineView: VisitDateLineView, ishidden: false)
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale
            dateFormatter.dateFormat = "yyyy-MM-dd"
            VisitDateTf.text = dateFormatter.string(from: currentDate)
            
            
        }
        return true;
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text?.isEmpty == true {
            if textField == FullNameTf {
                
                EnableLineAnimite(text: FullNameTf, ImageView: FullnameImage, imageEnable: #imageLiteral(resourceName: "user"), lineView: FullnameLineView, ishidden: true)
                
            } else if textField == PhoneTf {
                
                EnableLineAnimite(text: PhoneTf, ImageView: PhoneImage, imageEnable: #imageLiteral(resourceName: "phone"), lineView: PhoneLineView, ishidden: true)
                
                    PhoneTf.textAlignment = .natural
                
                
                
            } else if textField == BuildingTyteTf {
                
                EnableLineAnimite(text: BuildingTyteTf, ImageView: BuildingTyteImage, imageEnable: #imageLiteral(resourceName: "building-1"), lineView: BuildingTyteLineView, ishidden: true)
                
                if L102Language.currentAppleLanguage() == "en" {
                    
                    if SectionsArrayEn.count > 0{
                        BuildingTyteTf.text = SectionsArrayEn[0]
                    }
                    
                }else {
                    
                    if SectionsArrayAr.count > 0{
                        BuildingTyteTf.text = SectionsArrayAr[0]
                    }
                }
                
            } else if textField == VisitTimeTf {
                
                EnableLineAnimite(text: VisitTimeTf, ImageView: VisitTimeImage, imageEnable: #imageLiteral(resourceName: "time"), lineView: VisitTimeLineView, ishidden: true)
                
            }else if textField == VisitDateTf {
                
                EnableLineAnimite(text: VisitDateTf, ImageView: VisitDateImage, imageEnable: #imageLiteral(resourceName: "calendar"), lineView: VisitDateLineView, ishidden: true)
                
            }
            
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

extension PhotographyRequestVC : UIPickerViewDelegate, UIPickerViewDataSource  {
    
    func initPickers(picker: UIPickerView) {
        
        picker.dataSource = self as! UIPickerViewDataSource
        picker.delegate = self as! UIPickerViewDelegate
        picker.tintColor = #colorLiteral(red: 0.840886116, green: 0.6630725861, blue: 0.2519706488, alpha: 1)
        picker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == SectionsPicker {
            
            if L102Language.currentAppleLanguage() == "en" {
                
                return SectionsArrayEn.count
                
            }else {
                
                return SectionsArrayAr.count
            }
            
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if pickerView == SectionsPicker{
            
            if L102Language.currentAppleLanguage() == "en" {
                
                if SectionsArrayEn.count != 0 {
                    print(row)
                    Category_id = SectionsArrayEn[row]
                    return SectionsArrayEn[row]
                }
                
            }else {
                
                if SectionsArrayAr.count != 0 {
                    print(row)
                    Category_id = SectionsArrayEn[row]
                    return SectionsArrayAr[row]
                }
            }
            
        }
        
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == SectionsPicker{
            
            if L102Language.currentAppleLanguage() == "en" {
                if SectionsArrayEn.count != 0 {
                    
                    BuildingTyteTf.text = SectionsArrayEn[row]
                    Category_id = SectionsArrayEn[row]
                    
                }
            }else {
                BuildingTyteTf.text = SectionsArrayAr[row]
                Category_id = SectionsArrayEn[row]
            }
        }
    }
}

extension PhotographyRequestVC{
    
    func requestPhotoGraph() {
        
        self.view.lock()
        
        let Parameters = [
            "address" : desTxt.text ?? "",
            "real_estate_status" : Category_id,
            "name": FullNameTf.text ?? "",
            "mobile": PhoneTf.text ?? "",
            "visit_date" : VisitDateTf.text!,
            "visit_time" : self.api_time
        ] as [String : AnyObject]
        
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)real-estate-shot") { (data : RealEstateShotModel?, String) in
        self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
               self.view.unlock()
                
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
