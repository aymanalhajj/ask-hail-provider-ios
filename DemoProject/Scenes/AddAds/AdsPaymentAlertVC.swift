//
//  AdsPaymentAlertVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/7/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

protocol PayTime {
    func time(status : Int , adv_id : String ,states : String)
}

class AdsPaymentAlertVC: UIViewController {
    
    var Delegate : PayTime?
    var Package_id = ""
    var state = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        showAnimate()
    }
    
    
    @IBAction func BackAction(_ sender: Any) {
        
        removeAnimate()
    }
    
    @IBAction func PayNowAction(_ sender: Any) {
        
        Delegate?.time(status: 1, adv_id: "" , states: state)
        removeAnimate()
    }
    
    @IBAction func PayleaterAction(_ sender: Any) {
        
        ChosePackage()
        removeAnimate()
        
    }
 
    
}


//MARK:API
extension AdsPaymentAlertVC {
    
    func ChosePackage() {
        
        var Parameters = [
            "package_id": Package_id,
            "payment_time": "later"
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject], url: "\(hostName)user-add-advertisement/add-package") { (data : Level_1_Model?, String) in
            
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.Delegate?.time(status: 2, adv_id: "\(data.data?.advertisement_id ?? 0)",states: "")
                
                print(data)
                
                
            }
        }
    }
}

