//
//  EditCategoryVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/15/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class EditCategoryVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var BackGround: UIView!
    @IBOutlet weak var TopBar: UIView!

    @IBOutlet weak var SectionTf: UITextField!
    @IBOutlet weak var SectionImage: UIImageView!
    @IBOutlet weak var SectionLineView: UIView!
    @IBOutlet weak var SectionView: UIView!
    
    @IBOutlet weak var SubSectionTf: UITextField!
    @IBOutlet weak var SubSectionLineView: UIView!
    @IBOutlet weak var SubSectionView: UIView!
    
    @IBOutlet weak var LoadingView: UIView!
    
    var SectionsPicker = UIPickerView()
    var SubSectionPicker = UIPickerView()
    
    var SectionsArray : [SectionData] = []
    var SubSectionsArray : [SectionData] = []
    
    var SectionData : EditSectionData?
    
    var Ad_id = ""
    var Section_id = ""
    var SubSection_id = ""

    @IBOutlet weak var ConfirmBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSectionsData()

         
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        SectionTf.placeHolderColor = Colors.PlaceHolderColoer
        SubSectionTf.placeHolderColor = Colors.PlaceHolderColoer

        SectionTf.delegate = self
        SubSectionTf.delegate = self
        
        SectionTf.setPadding(left: 16, right: 16)
        SubSectionTf.setPadding(left: 16, right: 16)
        
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.8974673004, green: 0.911144314, blue: 0.922011104, alpha: 1))
        
        setShadow(view: SectionView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: SubSectionView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        self.SectionTf.inputView = SectionsPicker
        self.SubSectionTf.inputView = SubSectionPicker
        
        self.initPickers(picker: self.SectionsPicker)
        self.initPickers(picker: self.SubSectionPicker)
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        
        if SectionTf.text?.isEmpty != true ,SubSectionTf.text?.isEmpty != true {
            
            updateSection()
            
        } else {
            
            if SectionTf.text?.isEmpty == true {
                
                ErrorLineAnimite(text: SectionTf, ImageView: SectionImage, imageEnable: #imageLiteral(resourceName: "building-1"), lineView: SectionLineView, ishidden: false)
                
            }
            
            if SubSectionTf.text?.isEmpty == true {
                
                ErrorLineAnimiteNoimage(text: SubSectionTf, lineView: SubSectionLineView, ishidden: false)
                
            }
            
            self.view.shake()
            
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == SectionTf {
            EnableLineAnimite(text: SectionTf, ImageView: SectionImage, imageEnable: #imageLiteral(resourceName: "building"), lineView: SectionLineView, ishidden: false)
    
           
        } else if textField == SubSectionTf {
            
            if Section_id != "" {
                getSubSection()
            }
            
            EnableLineAnimiteNoimage(text: SubSectionTf, lineView: SubSectionLineView, ishidden: false)

        }
        
        return true;
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField == SectionTf {
            
            EnableLineAnimite(text: SectionTf, ImageView: SectionImage, imageEnable: #imageLiteral(resourceName: "building-white"), lineView: SectionLineView, ishidden: true)
            
        } else if textField == SubSectionTf {
            
            EnableLineAnimiteNoimage(text: SubSectionTf, lineView: SubSectionLineView, ishidden: true)
            
        }
        
        return true;
    }
}


//MARK:PickerView Controller

extension EditCategoryVC : UIPickerViewDelegate, UIPickerViewDataSource  {
    
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
            
            return SectionsArray.count
            
        }else if pickerView == SubSectionPicker {
            
            return SubSectionsArray.count
            
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if pickerView == SectionsPicker{
            
            if SectionsArray.count != 0 {
                print(row)
                Section_id = "\(SectionsArray[row].section_id ?? 0)"
                return SectionsArray[row].section_name
            }
            
        }else if pickerView == SubSectionPicker{
            
            if SubSectionsArray.count != 0 {
                
                print(row)
                SubSection_id = "\(SubSectionsArray[row].section_id ?? 0)"
                return SubSectionsArray[row].section_name
                
            }
        }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == SectionsPicker{
            
            if SectionsArray.count != 0 {
                SectionTf.text = SectionsArray[row].section_name
                Section_id = "\(SectionsArray[row].section_id ?? 0)"
            }
        }else if pickerView == SubSectionPicker {
            
            if SubSectionsArray.count != 0 {
                SubSectionTf.text = SubSectionsArray[row].section_name
                SubSection_id = "\(SubSectionsArray[row].section_id ?? 0)"
                
            }
        }
    }
}

//MARK:API

extension EditCategoryVC{
    
    func getSectionsData() {
        
        self.LoadingView.isHidden =  false
        self.view.lock()
        
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)business-update-advertisement/edit-sections?advertisement_id=\(Ad_id)") { (data : AdvEditSectionModel?, String) in
            
            self.view.lock()
            
            
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.SectionData = data.data
                self.getMainSection()
                
                print(data)
                
            }
        }
    }
    
    func updateSection() {
        
        self.view.lock()
        
        let Parameters = [
            "advertisement_id" : "\(SectionData?.adv_id ?? 0)",
            "main_section" : Section_id,
            "sub_section" : SubSection_id
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject], url: "\(hostName)business-update-advertisement/update-sections") { (data : SuccessEditSectionModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.navigationController?.popViewController(animated: true)
                
                self.navigationController?.view.makeToast("\(data.data?.message ?? "")")
                
                print(data)
                
            }
        }
        
        
    }
    
    func getMainSection() {
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)main-sections/business?package_id=\(Helper.getPackage_Id() ?? "0")") { (data : SectionsModel?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.SectionsArray = data.data ?? []
                
                for item in self.SectionsArray {
                    if item.section_id ?? 0 == self.SectionData?.adv_main_section_id ?? 0 {
                        self.SectionTf.text = item.section_name
                        self.Section_id = "\(self.SectionData?.adv_main_section_id ?? 0)"
                        self.initPickers(picker: self.SectionsPicker)
                    }
                }


                self.getSubSection()
                print(data)
                
                
            }
        }
    }
    
    func getSubSection() {
        
        print(Section_id)
        
        if Section_id == "" {
            self.view.unlock()
            self.LoadingView.isHidden =  true
            return
        }
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)sub-sections/\(Section_id)") { (data : SectionsModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.LoadingView.isHidden =  true
                self.SubSectionsArray = data.data ?? []
                
                
                
                for item in self.SubSectionsArray {
                    if item.section_id ?? 0 == self.SectionData?.adv_sub_section_id ?? 0 {
                        self.SubSectionTf.text = item.section_name
                        self.SubSection_id = "\(self.SectionData?.adv_sub_section_id ?? 0)"
                        self.initPickers(picker: self.SubSectionPicker)
                    }
                }
                
                self.initPickers(picker: self.SubSectionPicker)
                print(data)
                
                
            }
        }
    }
}
