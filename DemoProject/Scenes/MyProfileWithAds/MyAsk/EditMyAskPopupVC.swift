//
//  EditMyAskPopupVC.swift
//  AskHail
//
//  Created by bodaa on 17/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

protocol EditAsk {
    func openEditPopUp(state : Int)
}

class EditMyAskPopupVC: UIViewController {
    
    var deleget : EditAsk?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAnimate()
        
    }
    
    @IBAction func PhotoAction(_ sender: Any) {
        deleget?.openEditPopUp(state:2)
        removeAnimate()
    }
    
    
    @IBAction func DetailsAction(_ sender: Any) {
        deleget?.openEditPopUp(state:1)
        removeAnimate()
    }
    
    @IBAction func CancelAction(_ sender: Any) {
        removeAnimate()
    }
    
}
