//
//  StarAdsVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/12/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class StarAdsVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var MainView: UIView!
    
    @IBOutlet weak var SectionTf: UITextField!
    @IBOutlet weak var SectionLineView: UIView!
    @IBOutlet weak var SectionView: UIView!
    
    @IBOutlet weak var CoverImage: UIImageView!
    @IBOutlet weak var ScrollHeight: NSLayoutConstraint!
    @IBOutlet weak var SpecialTableView: UITableView!
    
    @IBOutlet weak var Special: UIView!
    @IBOutlet weak var BackGround: UIView!
    
    @IBOutlet weak var Desc: UILabel!
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    var SectionsPicker = UIPickerView()
    
    var SectionsArray = ["main_page" , "inside_section"]
    
    var enArray = ["Homw page".localized, "Section".localized]
    
    var Section_id = ""
    var Ad_id = ""
    
    var SpecialArray : SpecialData?
    
    
    override func viewWillAppear(_ animated: Bool) {
        MainView.isHidden = true
        getSpecialDetailss()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        SectionTf.placeHolderColor = Colors.PlaceHolderColoer
        
        SpecialTableView.delegate = self
        SpecialTableView.dataSource = self
        SpecialTableView.RegisterNib(cell: SpecialDetailsCell.self)
        
        SectionTf.delegate = self
        
        SectionTf.setPadding(left: 16, right: 16)
        
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.8974673004, green: 0.911144314, blue: 0.922011104, alpha: 1))
        
        setShadow(view: SectionView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        self.SectionTf.inputView = SectionsPicker
        self.initPickers(picker: self.SectionsPicker)
        
        self.SpecialTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.Desc.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        SpecialTableView.layer.removeAllAnimations()
        
        ScrollHeight.constant = SpecialTableView.contentSize.height + 500 + Desc.frame.height
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
            self.loadViewIfNeeded()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func NextAction(_ sender: Any) {
        
        if SectionTf.text?.isEmpty != true {
            
            let storyboard = UIStoryboard(name: StarAds, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "SpecialPackageVC") as! SpecialPackageVC
            vc.displayPlace = Section_id
            vc.Adv_Id = Ad_id

            navigationController?.pushViewController(vc, animated: true)
            
            
        } else {
            
            if SectionTf.text?.isEmpty == true {
                
                ErrorLineAnimiteNoimage(text: SectionTf, lineView: SectionLineView, ishidden: false)
                
            }
            
            self.view.shake()
            
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == SectionTf {
            
            EnableLineAnimiteNoimage(text: SectionTf, lineView: SectionLineView, ishidden: false)
            
            if SectionsArray.count > 0 {
                SectionTf.text = enArray[0]
            }
            
        }
        
        return true;
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField == SectionTf {
            
            EnableLineAnimiteNoimage(text: SectionTf, lineView: SectionLineView, ishidden: false)
            
        }
        
        return true;
    }
}

//MARK:-CollectionView Controller

extension StarAdsVC : UIPickerViewDelegate, UIPickerViewDataSource  {
    
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
            
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if pickerView == SectionsPicker{
            
            if SectionsArray.count != 0 {
                print(row)
                Section_id = "\(SectionsArray[row])"
                return enArray[row]
            }
            
        }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == SectionsPicker{
            
            if SectionsArray.count != 0 {
                SectionTf.text = enArray[row]
                Section_id = "\(SectionsArray[row])"
            }
        }
    }
}

//MARK:-TableViewContoller
extension StarAdsVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SpecialArray?.special_advantages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as SpecialDetailsCell
        
        let Model = SpecialArray?.special_advantages?[indexPath.row] ?? ""
        
        cell.CellTitle.text = Model
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
}

//MARK:-API
extension StarAdsVC {
    
    func getSpecialDetailss() {
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)show-special-information") { (data : SpecialModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.SpecialArray = data.data
                self.CoverImage.loadImage(URL(string: data.data?.special_image ?? ""))
                self.Desc.text = data.data?.special_description ?? ""
                self.SpecialTableView.reloadData()
                
                self.MainView.isHidden = false

                
            }
        }
    }
    
}
