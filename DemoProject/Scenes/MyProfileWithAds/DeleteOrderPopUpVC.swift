//
//  DeleteOrderPopUpVC.swift
//  AskHail
//
//  Created by bodaa on 11/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class DeleteOrderPopUpVC: UIViewController {
    
    var Ad_Id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAnimate()
        
    }
    
    
    @IBAction func DeleteAction(_ sender: Any) {
        
        guard let window = UIApplication.shared.keyWindow else{return}
        let sb = UIStoryboard(name: Home, bundle: nil)
        var vc : UIViewController
        vc = sb.instantiateViewController(withIdentifier: "HomeVC")
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        
        DeletOrder()
        removeAnimate()
        
    }
    
    @IBAction func CancelAction(_ sender: Any) {
        
        removeAnimate()
        
    }
    
    
}

extension DeleteOrderPopUpVC {
    
    func DeletOrder() {
        
        self.view.lock()
        
        let Parameters = [
            
            "order_id" : Ad_Id
            
        ]
        
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)user/delete-order") { (data : Level_6_Model?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.showStatus(image: #imageLiteral(resourceName: "delete"), message: data.data ?? "")
                
                print(data)
                
                
            }
        }
    }
    
}
