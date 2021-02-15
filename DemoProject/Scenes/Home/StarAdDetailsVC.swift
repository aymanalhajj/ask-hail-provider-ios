//
//  StarAdDetailsVC.swift
//  AskHail
//
//  Created by bodaa on 27/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit

class StarAdDetailsVC: UIViewController {
    
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet var BackGround: UIView!
    
    @IBOutlet weak var packageName: UILabel!
    @IBOutlet weak var Rimage: UIImageView!
    @IBOutlet weak var LImage: UIImageView!
    @IBOutlet weak var PackagePrice: UILabel!
    @IBOutlet weak var PackageTime: UILabel!
    @IBOutlet weak var packageDesc: UILabel!
    
    @IBOutlet weak var UserBuyDate: UILabel!
    @IBOutlet weak var UserEndDate: UILabel!
    @IBOutlet weak var NumberDaysRemening: UILabel!

    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var View2: UIView!
    @IBOutlet weak var alertView: UIView!
    
    var Ad_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getStarDetails()
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        setShadow(view: View1 , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: View2 , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
       
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    

}

extension StarAdDetailsVC {
    
    func getStarDetails(){
        
        self.View1.isHidden = true
        self.View2.isHidden = true
        self.alertView.isHidden = true
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)advertisement-operations/show-special?advertisement_id=\(Ad_id)") { (data : SpecialAdModel?, String) in
            
                        
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                if data.data?.package_details == nil {
                    self.View2.isHidden = true
                    self.alertView.isHidden = false
                }else{
                    self.View2.isHidden = false
                    self.alertView.isHidden = true
                }
                
                self.packageName.text = data.data?.package_name ?? ""
                self.PackagePrice.text = data.data?.package_price ?? ""
                self.PackageTime.text = data.data?.package_duration_in_days ?? ""
                self.packageDesc.text = data.data?.package_description ?? ""
                self.UserBuyDate.text = data.data?.package_details?.subscription_custom_start_date ?? ""
                self.UserEndDate.text = data.data?.package_details?.subscription_custom_end_date ?? ""
                self.NumberDaysRemening.text = "\(data.data?.package_details?.subscription_rest_days ?? 0)"
                
                
                if data.data?.package_rate == "1" {
                    self.LImage.image = #imageLiteral(resourceName: "feature-1")
                    self.Rimage.image = #imageLiteral(resourceName: "feature-1")
                }
                
                if data.data?.package_rate == "2" {
                    self.LImage.image = #imageLiteral(resourceName: "Blue-Star")
                    self.Rimage.image = #imageLiteral(resourceName: "Blue-Star")
                }
                
                if data.data?.package_rate == "3" {
                    self.LImage.image = #imageLiteral(resourceName: "Gold-Star")
                    self.Rimage.image = #imageLiteral(resourceName: "Gold-Star")
                }
                
                self.View1.isHidden = false
                
                
                print(data)
            }
        }
    }
    
}
