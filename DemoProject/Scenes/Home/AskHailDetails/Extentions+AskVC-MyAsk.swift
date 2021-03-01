//
//  Extentions+AskVC-MyAsk.swift
//  AskHailBusiness
//
//  Created by Abdullah Tarek on 01/03/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import Foundation
import UIKit

extension AskHailDetailsVC {
    
    func CheckIfMyAsk() {
        
        if Helper.getaUser_id() == "\(self.AskData?.question_advertiser_id ?? 0)" {
            self.buttomView.backgroundColor = UIColor(hexString: "ffffff")
            self.EditView.backgroundColor = UIColor(hexString: "ffffff")
            self.EditView.isHidden = false
            print("My ask")

        }else{
            self.buttomView.backgroundColor = UIColor(hexString: "E5F2F7")
            self.EditView.backgroundColor = UIColor(hexString: "E5F2F7")
            self.EditView.isHidden = true
            print("normal ask")

            
        }
        
    }
    
}

