//
//  AdsPlaceTypeVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/7/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class AdsPlaceTypeVC: UIViewController, UITextFieldDelegate {
    
    var isHome = 0
    
    @IBOutlet weak var SectionTf: UITextField!
    @IBOutlet weak var SectionImage: UIImageView!
    @IBOutlet weak var SectionLineView: UIView!
    
    @IBOutlet weak var SubSectionTf: UITextField!
    @IBOutlet weak var SubSectionLineView: UIView!
    
    var SectionsPicker = UIPickerView()
    var SubSectionPicker = UIPickerView()
    
    var SectionsArray : [SectionData] = []
    var SubSectionsArray : [SectionData] = []
    
    var Ad_id = ""
    var Section_id = ""
    var SubSection_id = ""
    

    @IBOutlet weak var ConfirmBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMainSection()
   
        SectionTf.placeHolderColor = Colors.PlaceHolderColoer
        SubSectionTf.placeHolderColor = Colors.PlaceHolderColoer

        SectionTf.delegate = self
        SubSectionTf.delegate = self
        
        SectionTf.setPadding(left: 16, right: 16)
        SubSectionTf.setPadding(left: 16, right: 16)
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        
        self.SectionTf.inputView = SectionsPicker
        self.SubSectionTf.inputView = SubSectionPicker
        
    
        
        
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        if isHome == 0 {
            navigationController?.popViewController(animated: true)
            
        }else{
            guard let window = UIApplication.shared.keyWindow else{return}
            let sb = UIStoryboard(name: Home, bundle: nil)
            var vc : UIViewController
            vc = sb.instantiateViewController(withIdentifier: "HomeVC")
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        }
        
        
        
    }
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        
        if SectionTf.text?.isEmpty != true ,SubSectionTf.text?.isEmpty != true {
            
            setSection()
            
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
            
            
            if SectionsArray.count > 0 {
                
                SectionTf.text = SectionsArray[0].section_name

            }
            
           
        } else if textField == SubSectionTf {
            
            if Section_id != "" {
                
                getSubSection()
                
            }
          
            
            EnableLineAnimiteNoimage(text: SubSectionTf, lineView: SubSectionLineView, ishidden: false)
            
            if SubSectionsArray.count > 0 {
                
                SubSectionTf.text = SubSectionsArray[0].section_name
            }
            
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


//MARK:PickerView Manger

extension AdsPlaceTypeVC : UIPickerViewDelegate, UIPickerViewDataSource  {
    
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


//MARK: API
extension AdsPlaceTypeVC {

    
    func setSection() {
        
        self.view.lock()
        var Parameters = [
            "advertisement_id": Ad_id,
            "main_section" : Section_id,
            "sub_section" : SubSection_id,
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject], url: "\(hostName)business-add-advertisement/level3-choose-sections") { (data : Level_1_Model?, String) in
            
            self.view.unlock()
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }

                let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "AdsAddPhotoVC") as! AdsAddPhotoVC
                vc.Ad_id = self.Ad_id
                vc.section_ID = self.Section_id
                vc.subSection_ID = self.SubSection_id
                self.navigationController?.pushViewController(vc, animated: true)
                
                print(data)
                
                
            }
        }
    }
    
    func getMainSection() {
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)main-sections/business") { (data : SectionsModel?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.SectionsArray = data.data ?? []
                self.initPickers(picker: self.SectionsPicker)
                
                print(data)
                
            }
        }
    }
    
    
    func getSubSection() {
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)sub-sections/\(Section_id)") { (data : SectionsModel?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.SubSectionsArray = data.data ?? []
                
                if self.SubSectionsArray.count > 0 {
                    
                    self.SubSectionTf.text = self.SubSectionsArray[0].section_name
                    
                }
                self.initPickers(picker: self.SubSectionPicker)
                
                print(data)
                
            }
        }
    }
    
}
