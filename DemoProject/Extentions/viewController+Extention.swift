//
//  viewController+Extention.swift
//  DemoProject
//
//  Created by Mohab on 3/15/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import MBProgressHUD


extension UIViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    func showAllImageToChose(){
          let picker = UIImagePickerController()
          picker.sourceType = .photoLibrary
          picker.delegate = self
          picker.allowsEditing = true
          present(picker, animated: true, completion: nil)
          
          
      }
    
    func validateEmail(_ email:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    func isValidPhone(phone:String) -> Bool {
           let phoneRegEx = "[01]{2}+[0-9]{9}"
           let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
           return phoneTest.evaluate(with: phone)
       }
    
    func showIndicator(title : String , Describtions : String){
        
        let inidicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        inidicator.label.text = title
        inidicator.isUserInteractionEnabled = false
        inidicator.detailsLabel.text = Describtions
        inidicator.show(animated: true)
        self.view.isUserInteractionEnabled = false
        
        
    }
    
    func hideIndicator(){
        
        MBProgressHUD.hide(for: self.view, animated: true)
        self.view.isUserInteractionEnabled = true
        
    }
    

    
}
