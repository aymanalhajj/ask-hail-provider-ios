//
//  AdvStateVC.swift
//  AskHailBusiness
//
//  Created by bodaa on 14/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit
import IQKeyboardManager

class AdvStateVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var MainView: UIScrollView!
    
    @IBOutlet weak var DateTf: UITextField!
    @IBOutlet weak var DateImage: UIImageView!
    @IBOutlet weak var DateLineView: UIView!
    
    @IBOutlet weak var DayesNumTf: UITextField!
    @IBOutlet weak var DayesNumLineView: UIView!
    
    @IBOutlet weak var TopBar: UIView!
    
    @IBOutlet weak var unavilableCollectionView: UICollectionView!
    
    @IBOutlet weak var unavilableCollectionViewHight: NSLayoutConstraint!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    @IBOutlet var BackGround: UIView!
    
    var Ad_id = ""
    
    var unavilableArray : [AdvAvilableData] = []
    
    var pickerOfDate = UIDatePicker()
    let currentDate = Date()
    
    override func viewDidDisappear(_ animated: Bool) {
        IQKeyboardManager.shared().isEnabled = true
    }
    override func viewWillAppear(_ animated: Bool) {
        MainView.isHidden = true
        IQKeyboardManager.shared().isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ShowAdvState(advertisement_id : Ad_id)
        
        DateTf.delegate = self
        DayesNumTf.delegate = self
        
        unavilableCollectionView.dataSource = self
        unavilableCollectionView.delegate = self
        unavilableCollectionView.RegisterNib(cell: UnavailableCell.self)
        if L102Language.currentAppleLanguage() == englishLang {
            
        }else{
            unavilableCollectionView.flipX()
        }
        
        
        DateTf.placeHolderColor = Colors.PlaceHolderColoer
        DayesNumTf.placeHolderColor = Colors.PlaceHolderColoer
        
        DateTf.setPadding(left: 16, right: 16)
        DayesNumTf.setPadding(left: 16, right: 16)
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        setShadow(view: view1 , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: view2 , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        
        self.DateTf.inputView = pickerOfDate
        
        let loc = Locale(identifier: "en")
        self.pickerOfDate.locale = loc
        self.pickerOfDate.datePickerMode = .date
        pickerOfDate.preferredDatePickerStyle = .wheels
       
        pickerOfDate.minimumDate = currentDate
        
        pickerOfDate.addTarget(self, action: #selector(PhotographyRequestVC.dateChanged(datePicker:)), for: .valueChanged)

        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func BackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        if DateTf.text?.isEmpty != true ,DayesNumTf.text?.isEmpty != true {
            
            SetNewTime()
            
        } else {
            
            if DateTf.text?.isEmpty == true {
                
                ErrorLineAnimite(text: DateTf, ImageView: DateImage, imageEnable: #imageLiteral(resourceName: "calendar"), lineView: DateLineView, ishidden: false)
                
            }
            
            if DayesNumTf.text?.isEmpty == true {
                
                ErrorLineAnimiteNoimage(text: DayesNumTf, lineView: DayesNumLineView, ishidden: true)
                
            }
            
            self.view.shake()
            
        }
    }
    
    @objc func dateChanged(datePicker : UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale
        dateFormatter.dateFormat = "yyyy-MM-dd"
        DateTf.text = dateFormatter.string(from: pickerOfDate.date)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
         if textField == DateTf {
            
            EnableLineAnimite(text: DateTf, ImageView: DateImage, imageEnable: #imageLiteral(resourceName: "calendar"), lineView: DateLineView, ishidden: false)
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale
            dateFormatter.dateFormat = "yyyy-MM-dd"
            DateTf.text = dateFormatter.string(from: currentDate)
            
        }else if textField == DayesNumTf {
            
            EnableLineAnimiteNoimage(text: DayesNumTf, lineView: DayesNumLineView, ishidden: false)
            
        }
        return true;
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text?.isEmpty == true {
            if textField == DateTf {
               EnableLineAnimite(text: DateTf, ImageView: DateImage, imageEnable: #imageLiteral(resourceName: "calendar"), lineView: DateLineView, ishidden: true)
           }else if textField == DayesNumTf {
               EnableLineAnimiteNoimage(text: DayesNumTf, lineView: DayesNumLineView, ishidden: true)
           }
        }
        
       
        return true;
    }
    
}


extension AdvStateVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return unavilableArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UnavailableCell", for: indexPath) as! UnavailableCell
        
        setShadow(view: cell, width: 1, height: 1, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.8497933686, green: 0.8863877511, blue: 0.9072735773, alpha: 1))
        
        let Model = unavilableArray[indexPath.row]
        
        cell.unavailable_duration_start_date.text = Model.unavailable_duration_start_date ?? ""
        cell.unavailable_duration_days.text = "\(Model.unavailable_duration_days ?? 0)"
        cell.unavailable_duration_available_after_days.text = "\(Model.unavailable_duration_available_after_days ?? 0)"
        
        cell.DeleteState = {
            
            self.DeleteState(id : "\(self.unavilableArray[indexPath.row].unavailable_duration_id ?? 0)")
            self.unavilableArray.remove(at: indexPath.row)
        }
        
        if L102Language.currentAppleLanguage() == englishLang {
            
        }else{
            cell.flipX()
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width = (collectionView.frame.width - 80)
        if unavilableArray.count == 1 {
            width = collectionView.frame.width
        }
        
        let height = collectionView.frame.height - 30
        
        return CGSize.init(width: width , height:height)
        
    }
    
}

//MARK:-API

extension AdvStateVC {
    
    func ShowAdvState(advertisement_id : String) {
        
        self.view.lock()
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)business/show-unavailable-information?advertisement_id=\(advertisement_id)") { (data : AdvAvilableModel?, String) in
            self.view.unlock()
            if String != nil {
                self.unavilableCollectionView.isHidden = true
                self.unavilableCollectionViewHight.constant = 0
                self.MainView.isHidden = false
            }else {
                
                guard let data = data else {
                    return
                }
                self.unavilableArray = data.data ?? []
                self.unavilableCollectionView.reloadData()
                self.unavilableCollectionView.collectionViewLayout.invalidateLayout()
                self.MainView.isHidden = false
                print(data)
            }
        }
    }
    
    func SetNewTime() {
        
        self.view.lock()
        
        let Parameters = [
            "advertisement_id" : Ad_id ,
            "unavailable_start_date" : DateTf.text ?? "",
            "unavailable_days" : DayesNumTf.text ?? "",
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject], url: "\(hostName)business/make-unavailable") { (data : SuccessTransActionModel?, String) in
            self.view.unlock()
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                if self.unavilableArray.count == 0 {
                    self.navigationController?.view.makeToast(data.data?.message ?? "")
                    self.navigationController?.popViewController(animated: true)
                }else{
                    self.navigationController?.view.makeToast(data.data?.message ?? "")
                    self.ShowAdvState(advertisement_id: self.Ad_id)
                    self.unavilableCollectionView.reloadData()
                }
                print(data)
                
            }
        }
    }
    
    func DeleteState(id : String) {
        
        self.view.lock()
        
        let Parameters = [
            "unavailable_duration_id" : id ,
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject], url: "\(hostName)business/delete-unavailable") { (data : SuccessTransActionModel?, String) in
            self.view.unlock()
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                self.navigationController?.view.makeToast(data.data?.message ?? "")
                self.unavilableCollectionView.reloadData()
                self.ShowAdvState(advertisement_id: self.Ad_id)
                
                print(data)
                
            }
        }
    }
    
}


