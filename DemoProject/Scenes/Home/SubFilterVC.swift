//
//  SubFilterVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 18/12/2020.

import UIKit

protocol refreshData {
    func refresh(state : Int , Order : String , sidee : String , regionn : String)
}

class SubFilterVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var OrderByTf: UITextField!
    @IBOutlet weak var OrderByImage: UIImageView!
    @IBOutlet weak var OrderByLineView: UIView!
    @IBOutlet weak var OrderByView: UIView!
    
    @IBOutlet weak var directionTf: UITextField!
    @IBOutlet weak var directionImage: UIImageView!
    @IBOutlet weak var directionLineView: UIView!
    @IBOutlet weak var directionView: UIView!
    
    @IBOutlet weak var RegionTf: UITextField!
    @IBOutlet weak var RegionImage: UIImageView!
    @IBOutlet weak var RegionLineView: UIView!
    @IBOutlet weak var RegionView: UIView!
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    var DirectionPicker = UIPickerView()
    var RegionPicker = UIPickerView()
    var OrderByPicker = UIPickerView()
    
    var OrderByArray : [String] = ["latest" , "nearest" , "most_viewed"]
    var ar_OrderTitles : [String] = ["الاخيرة" , "الاقرب" , "الاكثر مشاهدة"]
    var en_OrderTitles: [String] = ["Latest" , "Nearest" , "Most Viewed"]
    
    var DirectionArray : [SidesData] = []
    var RegionArray : [BlocksData] = []
    
    var OrderBy_id = ""
    var Direction_id = ""
    var Region_id = ""
    
    var currentPage = ""
        
    var Delegte : refreshData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAnimate()
        getDirection()
        getRegion()
        
        OrderByTf.placeHolderColor = Colors.PlaceHolderColoer
        directionTf.placeHolderColor = Colors.PlaceHolderColoer
        RegionTf.placeHolderColor = Colors.PlaceHolderColoer
        
        directionTf.delegate = self
        RegionTf.delegate = self
        OrderByTf.delegate = self
        
        OrderByTf.setPadding(left: 16, right: 16)
        directionTf.setPadding(left: 16, right: 16)
        RegionTf.setPadding(left: 16, right: 16)
        
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
       
        setShadow(view: OrderByView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: directionView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: RegionView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        
        self.OrderByTf.inputView = OrderByPicker
        self.directionTf.inputView = DirectionPicker
        self.RegionTf.inputView = RegionPicker
        
        self.initPickers(picker: self.OrderByPicker)
        self.initPickers(picker: self.DirectionPicker)
        self.initPickers(picker: self.RegionPicker)
        
    }
    
    @IBAction func SetFilterAction(_ sender: Any) {
        
        if currentPage == "advertisements" {
            Delegte?.refresh(state: 1, Order: OrderBy_id, sidee: Direction_id, regionn: Region_id )
        } else if currentPage == "orders" {
            Delegte?.refresh(state: 2, Order: OrderBy_id, sidee: Direction_id, regionn: Region_id )
        }
        currentPage = ""
        removeAnimate()
    }
    
    @IBAction func DefualtACtion(_ sender: Any) {
        
        if currentPage == "advertisements"  {
            Delegte?.refresh(state: 1, Order: OrderBy_id, sidee: Direction_id, regionn: Region_id )
        } else if currentPage == "orders" {
            Delegte?.refresh(state: 2, Order: "", sidee: "", regionn: "" )
        }
        currentPage = ""
        removeAnimate()
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        removeAnimate()
        
    }
    
}

//MARK:Picker Controller

extension SubFilterVC : UIPickerViewDelegate, UIPickerViewDataSource  {
    
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
            
        }else if pickerView == OrderByPicker {
            return OrderByArray.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if pickerView == DirectionPicker{
            
            if DirectionArray.count != 0 {
                Direction_id = "\(DirectionArray[row].side_id ?? 0)"
                return DirectionArray[row].side_name
            }
            
        }else if pickerView == RegionPicker{
            
            if RegionArray.count != 0 {
                Region_id = "\(RegionArray[row].block_id ?? 0)"
                return RegionArray[row].block_name
            }
            
        } else if pickerView == OrderByPicker {
            
            //Check it
            if OrderByArray.count != 0 {
                OrderBy_id = "\(OrderByArray[row])"
                
                if L102Language.currentAppleLanguage() == englishLang {
                    return en_OrderTitles[row]
                } else {
                    return ar_OrderTitles[row]
                }
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
        } else if pickerView == OrderByPicker {
            
            if OrderByArray.count != 0 {
                
                if L102Language.currentAppleLanguage() == englishLang {
                    OrderByTf.text = en_OrderTitles[row]
                } else {
                    OrderByTf.text = ar_OrderTitles[row]
                }
                OrderBy_id = "\(OrderByArray[row])"
            }
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == OrderByTf {
            
            EnableLineAnimite(text: OrderByTf, ImageView: OrderByImage, imageEnable: #imageLiteral(resourceName: "arrange"), lineView: OrderByLineView, ishidden: false)
            
            if OrderByArray.count > 0 {
                if L102Language.currentAppleLanguage() == englishLang {
                    OrderByTf.text = en_OrderTitles[0]
                }else{
                    OrderByTf.text = ar_OrderTitles[0]
                }
                
            }
            
        } else if textField == directionTf {
            
            EnableLineAnimite(text: directionTf, ImageView: directionImage, imageEnable: #imageLiteral(resourceName: "direction"), lineView: directionLineView, ishidden: false)
            
            if DirectionArray.count > 0 {
                directionTf.text = DirectionArray[0].side_name
            }
            
        } else if textField == RegionTf {
            
            EnableLineAnimite(text: RegionTf, ImageView: RegionImage, imageEnable: #imageLiteral(resourceName: "distance-1"), lineView: RegionLineView, ishidden: false)
            
            if RegionArray.count > 0 {
                RegionTf.text = RegionArray[0].block_name
            }
            
        }
        
        return true
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField == OrderByTf {
            
            EnableLineAnimite(text: OrderByTf, ImageView: OrderByImage, imageEnable: #imageLiteral(resourceName: "arrange"), lineView: OrderByLineView, ishidden: false)
            
        } else if textField == directionTf {
            
            EnableLineAnimite(text: directionTf, ImageView: directionImage, imageEnable: #imageLiteral(resourceName: "direction"), lineView: directionLineView, ishidden: false)
            
        } else if textField == RegionTf {
            
            EnableLineAnimite(text: RegionTf, ImageView: RegionImage, imageEnable: #imageLiteral(resourceName: "distance-1"), lineView: RegionLineView, ishidden: false)
            
        }
        
        return true
    }
}



//MARK:API
extension SubFilterVC {
    
    func getRegion() {
        
        
        
       ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)blocks") { (data : BlocksModel?, String) in
        self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)

                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.RegionArray = data.data ?? []
                
               
                print(data)
                
                
            }
        }
    }
    
    func getDirection() {
        
        self.view.lock()
        
       ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)sides") { (data : SidesModel?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.DirectionArray = data.data ?? []
                
               
                print(data)
                
                
            }
        }
    }
    
}
