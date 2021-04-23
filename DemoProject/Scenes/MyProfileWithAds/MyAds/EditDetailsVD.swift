//
//  EditCategoryVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/15/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class EditDetailsVD: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet var BackGround: UIView!
    
    @IBOutlet weak var MainView: UIScrollView!
    @IBOutlet weak var TopBar: UIView!
    
    @IBOutlet weak var desTxt: UITextView!
    @IBOutlet weak var desLineView: UIView!
    @IBOutlet weak var desView: UIView!
    
    @IBOutlet weak var OrderTitleTf: UITextField!
    @IBOutlet weak var OrderTitleLineView: UIView!
    @IBOutlet weak var OrderTitleView: UIView!
    
    @IBOutlet weak var LocationTf: UITextField!
    @IBOutlet weak var LocationImage: UIImageView!
    @IBOutlet weak var LocationLineView: UIView!
    @IBOutlet weak var LocationView: UIView!
    
    @IBOutlet weak var PriceTf: UITextField!
    @IBOutlet weak var PriceImage: UIImageView!
    @IBOutlet weak var PriceLineView: UIView!
    @IBOutlet weak var PriceView: UIView!
    
    @IBOutlet weak var directionTf: UITextField!
    @IBOutlet weak var directionImage: UIImageView!
    @IBOutlet weak var directionLineView: UIView!
    @IBOutlet weak var directionView: UIView!
    
    @IBOutlet weak var RegionTf: UITextField!
    @IBOutlet weak var RegionImage: UIImageView!
    @IBOutlet weak var RegionLineView: UIView!
    @IBOutlet weak var RegionView: UIView!
    
    @IBOutlet weak var DetailsCollectionView: UICollectionView!
    
    @IBOutlet weak var ScrollHeight: NSLayoutConstraint!
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    var DirectionPicker = UIPickerView()
    var RegionPicker = UIPickerView()
    
    var DirectionArray : [SidesData] = []
    var RegionArray : [BlocksData] = []
    
    var FeatureArray : [FeaturesData] = []
    var SelectedFeature = [Int : Feature_data]()
    var cellArray = [AddDetailsCell]()
    
    var CurrentFeatureArray : [Adv_specifications] = []
    
    var DetialsData : EditDetailsData?
    
    var FeatureData = false
    
    var lat = 0.0
    var lng = 0.0
    var Address = ""
    
    var Direction_id = ""
    var Region_id = ""
    
    var Ad_id = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAdvDetails()
       
        getFeature()
        
        
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.8974673004, green: 0.911144314, blue: 0.922011104, alpha: 1))
        
        OrderTitleTf.placeHolderColor = Colors.PlaceHolderColoer
        LocationTf.placeHolderColor = Colors.PlaceHolderColoer
        PriceTf.placeHolderColor = Colors.PlaceHolderColoer
        directionTf.placeHolderColor = Colors.PlaceHolderColoer
        RegionTf.placeHolderColor = Colors.PlaceHolderColoer
        
        LocationTf.delegate = self
        OrderTitleTf.delegate = self
        PriceTf.delegate = self
        directionTf.delegate = self
        
        RegionTf.delegate = self
        desTxt.delegate = self
        
        
        OrderTitleTf.setPadding(left: 16, right: 16)
        LocationTf.setPadding(left: 16, right: 16)
        PriceTf.setPadding(left: 16, right: 16)
        directionTf.setPadding(left: 16, right: 16)
        RegionTf.setPadding(left: 16, right: 16)
        
        
        DetailsCollectionView.delegate = self
        DetailsCollectionView.dataSource = self
        DetailsCollectionView.RegisterNib(cell: AddDetailsCell.self)
        
        
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        
        setShadow(view: OrderTitleView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: desView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: PriceView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: RegionView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: LocationView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        self.directionTf.inputView = DirectionPicker
        self.RegionTf.inputView = RegionPicker
        
        self.initPickers(picker: self.DirectionPicker)
        self.initPickers(picker: self.RegionPicker)
        
        self.DetailsCollectionView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        DetailsCollectionView.layer.removeAllAnimations()
        ScrollHeight.constant = DetailsCollectionView.contentSize.height + 680
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
            self.loadViewIfNeeded()
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
    
    
    @IBAction func BackAcrion(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func SelectLocationAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "ChoseLocationOnMapVC") as! ChoseLocationOnMapVC
        vc.Delegate = self
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        if OrderTitleTf.text?.isEmpty != true , PriceTf.text?.isEmpty != true , desTxt.text?.isEmpty != true , directionTf.text?.isEmpty != true ,RegionTf.text?.isEmpty != true ,
           LocationTf.text?.isEmpty != true {
            
            updateDetail()
            
        } else {
            
            if LocationTf.text?.isEmpty == true {
                ErrorLineAnimite(text: LocationTf, ImageView: LocationImage, imageEnable: #imageLiteral(resourceName: "distance-1"), lineView: LocationLineView, ishidden: false)
            }
            if OrderTitleTf.text?.isEmpty == true {
                ErrorLineAnimiteNoimage(text: OrderTitleTf, lineView: OrderTitleLineView, ishidden: false)
            }
            if PriceTf.text?.isEmpty == true {
                ErrorLineAnimite(text: PriceTf, ImageView: PriceImage, imageEnable: #imageLiteral(resourceName: "money"), lineView: PriceLineView, ishidden: false)
            }
            if desTxt.text?.isEmpty == true {
                ErrorLineAnimiteTextView(text: desTxt, lineView: desLineView, ishidden: false)
            }
            if directionTf.text?.isEmpty == true {
                ErrorLineAnimite(text: directionTf, ImageView: directionImage, imageEnable: #imageLiteral(resourceName: "direction"), lineView: directionLineView, ishidden: false)
            }
            if RegionTf.text?.isEmpty == true {
                ErrorLineAnimite(text: RegionTf, ImageView: RegionImage, imageEnable: #imageLiteral(resourceName: "distance-1"), lineView: RegionLineView, ishidden: false)
            }
            
            self.view.shake()
            
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == OrderTitleTf {
            
            EnableLineAnimiteNoimage(text: OrderTitleTf, lineView: OrderTitleLineView, ishidden: false)
            
        } else if textField == PriceTf {
            EnableLineAnimite(text: PriceTf, ImageView: PriceImage, imageEnable: #imageLiteral(resourceName: "money-white"), lineView: PriceLineView, ishidden: false)
            
        } else if textField == directionTf {
            
            EnableLineAnimite(text: directionTf, ImageView: directionImage, imageEnable: #imageLiteral(resourceName: "direction-2"), lineView: directionLineView, ishidden: false)
            
        } else if textField == RegionTf {
            
            EnableLineAnimite(text: RegionTf, ImageView: RegionImage, imageEnable: #imageLiteral(resourceName: "distance-2"), lineView: RegionLineView, ishidden: false)
            
        }else if textField == LocationTf {
            
            EnableLineAnimite(text: LocationTf, ImageView: LocationImage, imageEnable: #imageLiteral(resourceName: "distance-2"), lineView: LocationLineView, ishidden: false)
            
        }
        return true;
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField == OrderTitleTf {
            
            EnableLineAnimiteNoimage(text: OrderTitleTf, lineView: OrderTitleLineView, ishidden: true)
            
        } else if textField == PriceTf {
            
            EnableLineAnimite(text: PriceTf, ImageView: PriceImage, imageEnable: #imageLiteral(resourceName: "money"), lineView: PriceLineView, ishidden: true)
            
        } else if textField == directionTf {
            
            EnableLineAnimite(text: directionTf, ImageView: directionImage, imageEnable: #imageLiteral(resourceName: "direction"), lineView: directionLineView, ishidden: true)
            
//            if DirectionArray.count > 0 {
//                directionTf.text = DirectionArray[Int(Direction_id) ?? 0].side_name
//            }
            
        } else if textField == RegionTf {
            
            EnableLineAnimite(text: RegionTf, ImageView: RegionImage, imageEnable: #imageLiteral(resourceName: "distance-1"), lineView: RegionLineView, ishidden: true)
            
//            if RegionArray.count > 0 {
//                RegionTf.text = RegionArray[Int(Region_id) ?? 0].block_name
//            }
            
        }else if textField == LocationTf {
            
            EnableLineAnimite(text: LocationTf, ImageView: LocationImage, imageEnable: #imageLiteral(resourceName: "distance-1"), lineView: LocationLineView, ishidden: true)
            
        }
        
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView ==  desTxt{
            
            EnableLineAnimiteTextView(text: desTxt, lineView: desLineView, ishidden: true)
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

extension EditDetailsVD : UIPickerViewDelegate, UIPickerViewDataSource  {
    
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
        
        if pickerView == DirectionPicker {
            
            return DirectionArray.count
            
        }else if pickerView == RegionPicker {
            
            return RegionArray.count
            
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if pickerView == DirectionPicker{
            
            if DirectionArray.count != 0 {
                print(row)
                Direction_id = "\(DirectionArray[row].side_id ?? 0)"
                return DirectionArray[row].side_name
            }
            
        }else if pickerView == RegionPicker{
            
            if RegionArray.count != 0 {
                
                print(row)
                Region_id = "\(RegionArray[row].block_id ?? 0)"
                return RegionArray[row].block_name
                
            }
        }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == DirectionPicker{
            
            if DirectionArray.count != 0 {
                directionTf.text = DirectionArray[row].side_name
                Direction_id = "\(DirectionArray[row].side_id ?? 0)"
            }
        }else if pickerView == RegionPicker {
            
            if RegionArray.count != 0 {
                RegionTf.text = RegionArray[row].block_name
                Region_id = "\(RegionArray[row].block_id ?? 0)"
                
            }
        }
    }
}

//MARK:- CollectionView Contoller

extension EditDetailsVD: UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FeatureArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddDetailsCell", for: indexPath) as! AddDetailsCell
        
        setShadow(view: cell , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        if FeatureData {
            
            let model = FeatureArray[indexPath.row]
            
            var x = 0
            for item in CurrentFeatureArray {
                if FeatureArray[indexPath.row].feature_id == item.specification_section_feature?.feature_id {
                    
                    cell.DetailTf.text = CurrentFeatureArray[x].specification_answer ?? ""
                    
                    if FeatureArray[indexPath.row].feature_type == "choose" {
                        
                        
                        print("dssd")
                        
                        for item1 in FeatureArray[indexPath.row].feature_data ?? [] {
                                                        
                            if item1.data_title == item.specification_answer {
                                self.SelectedFeature[indexPath.row] = item1
                            }
                            
                        }
                        
                     
                    }
                }
                x = x + 1
            }
            if cell.DetailTf.text == "" {
                cell.DetailTf.placeholder = model.feature_name ?? ""
            }
           
            
            if model.feature_type == "choose" {
                cell.ChoseDetailsBtn.isHidden = false
                cell.arrow_doun.isHidden = false
            }else{
                cell.ChoseDetailsBtn.isHidden = true
                cell.arrow_doun.isHidden = true
            }
            
            
            cell.ChoseDetails = {
                let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "ChoseFeaturePopupVC") as! ChoseFeaturePopupVC
                vc.modalPresentationStyle = .fullScreen
                vc.Delegte = self
                vc.index = indexPath.row
                vc.FeatureData = self.FeatureArray[indexPath.row].feature_data ?? []
                vc.pageTitle = self.FeatureArray[indexPath.row].feature_name ?? ""
                self.addChild(vc)
                vc.view.frame = self.view.frame
                self.view.addSubview(vc.view)
                vc.didMove(toParent: self)
            }
            
        }
        
        for item in SelectedFeature {
            if item.key == indexPath.row {
                cell.DetailTf.text = item.value.data_title
            }
        }
        
        return cell
    }
    
}

extension EditDetailsVD : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        return CGSize.init(width: width , height:56)
        
    }
}

//MARK:- Protocol Controller

extension EditDetailsVD : ChoseFromFeature {
    func choseFeature(data: Feature_data, index: Int) {
        SelectedFeature[index] = data
        print(SelectedFeature)
        let indexPath = IndexPath.init(row: index, section: 0)
        let cell = DetailsCollectionView.cellForItem(at: indexPath) as! AddDetailsCell
        cell.DetailTf.text = data.data_title
    }
}

extension EditDetailsVD : ChooseLocation {
    func ChooseLocation(lat: Double, lng: Double, Address: String) {
        self.lat = lat
        self.lng = lng
        self.Address = Address
        self.LocationTf.text = Address
    }
}

//MARK:-API

extension EditDetailsVD {
    
    
    func updateDetail() {
        
        self.view.lock()
        
        
        var Parameters = [
            "advertisement_id": Ad_id,
            "title" : OrderTitleTf.text ?? "",
            "description" : desTxt.text ?? "",
            "location" : Address,
            "lat" : "\(lat)",
            "lng" : "\(lng)",
            "price" : PriceTf.text ?? "",
            "side_id" : Direction_id,
            "block_id" : Region_id,
        ] as [String : Any]
        
        var features = self.SelectedFeature.values
        var selected_ides = [Int]()
        
        
        
        var x = 0
        
        
        for item in SelectedFeature {
            
            Parameters["features[\(x)]['feature_id']"] = "\(self.FeatureArray[item.key].feature_id ?? 0)"
            Parameters["features[\(x)]['answer']"] = "\(item.value.data_id ?? 0)"
            
            
            print(self.FeatureArray[item.key].feature_id ?? 0 , item.value.data_id ?? 0)
            x = x + 1
        }
        
        var y = 0
        for item in FeatureArray {
            
            let indexPath = IndexPath.init(row: y, section: 0)
            let cell = DetailsCollectionView.cellForItem(at: indexPath) as! AddDetailsCell
            
            
            if FeatureArray[y].feature_type == "text" {
                
                if cell.DetailTf.text == "" {
//                    Parameters["features[\(x)]['feature_id']"] = ""
//                    Parameters["features[\(x)]['answer']"] = ""
                    
                }else{
                    Parameters["features[\(x)]['feature_id']"] = "\(FeatureArray[y].feature_id ?? 0)"
                    Parameters["features[\(x)]['answer']"] = cell.DetailTf.text ?? ""
                    
                    x = x + 1
                }
            }
            y = y + 1
            
        }
        
        print(Parameters)
        
        ApiServices.instance.uploadImage(methodType: .post, parameters: Parameters as [String : AnyObject], url: "\(hostName)business-update-advertisement/update-details", imagesArray: nil, profileImage: nil, commercial_register_image: nil, office_license_image: nil, id_image: nil, VediosArray: nil, VediosDuration: nil) { (data : SuccessEditSectionModel?, String) in
            
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
    
    
    func getAdvDetails() {
        
        self.view.lock()
        self.MainView.isHidden = true
        print(Ad_id)
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)business-update-advertisement/edit-details?advertisement_id=\(Ad_id)") { (data : AdvEditDetailsModel?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                self.view.unlock()
                
            }else {
                
                guard let data = data else {
                    return
                }
                self.MainView.isHidden = false
                self.DetialsData = data.data
                
                self.OrderTitleTf.text = data.data?.adv_title ?? ""
                self.desTxt.text = data.data?.adv_description ?? ""
                self.LocationTf.text = data.data?.adv_location ?? ""
                self.PriceTf.text = data.data?.adv_price ?? ""
                self.Region_id = "\(data.data?.adv_block_id ?? 0)"
                self.Direction_id = "\(data.data?.adv_side_id ?? 0)"
                self.Address = "\(data.data?.adv_latitude ?? "")"
                self.lat = Double(data.data?.adv_latitude ?? "") ?? 0.0
                self.lng = Double(data.data?.adv_longitude ?? "") ?? 0.0
                
                if self.desTxt.text?.isEmpty == true {
                    
                    if L102Language.currentAppleLanguage() == "en" {
                        self.desTxt.text = "Description of the Advertising"
                        
                    }else {
                        
                        self.desTxt.text = "وصف الاعلان"
                    }
                    
                    self.desTxt.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5)
                }
                
                
                self.Region_id = "\(data.data?.adv_block_id ?? 0)"
                self.Direction_id = "\(data.data?.adv_side_id ?? 0)"
                
                self.getRegion()
                self.getDirection()
                
                print(data)
                
            }
        }
    }
    
    
    func getRegion() {
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)blocks") { (data : BlocksModel?, String) in
            
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.RegionArray = data.data ?? []
                
//                if self.RegionArray.count > 0 {
//
//
//
//                    self.RegionTf.text = self.RegionArray[0].block_name ?? ""
//                    self.Region_id = "\(self.DetialsData?.adv_block_id ?? 0)"
//
//                }
                
                
                for item in self.RegionArray {
                    
                    if "\(item.block_id ?? 0)" == self.Region_id {
                        
                        self.RegionTf.text = item.block_name ?? ""
                      
                    }
                    
                }
                
                print(data)
                
            }
        }
    }
    
    
    func getDirection() {
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)sides") { (data : SidesModel?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                self.view.unlock()
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.DirectionArray = data.data ?? []
                
                
               
                
                
                for item in self.DirectionArray {
                    
                    if "\(item.side_id ?? 0)" == self.Direction_id {
                        
                        self.directionTf.text = item.side_name ?? ""
                      
                    }
                    
                }
                
                print(data)
                
            }
        }
    }
    
    func getFeature() {
        
        let Parameters = [
            "advertisement_id": Ad_id,
        ] as [String : Any]
        
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject], url: "\(hostName)business-add-advertisement/show-advertisement-features") { (data : FeaturesModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                if data.data?.count ?? 0 > 0 {
                    self.FeatureArray = data.data ?? []
                    self.FeatureData = true
                }
                
                self.DetailsCollectionView.reloadData()
                print(data)
            }
        }
    }
    
}

