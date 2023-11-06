//
//  EditAdsPopUpVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/15/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

protocol selectEditSection {
    
    func SelectEdit(select : Int)
    
}

class EditAdsPopUpVC: UIViewController {
    
    var deleget : selectEditSection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAnimate()
        
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        removeAnimate()
    }
    
    
    @IBAction func CategoryAction(_ sender: Any) {
        
        deleget?.SelectEdit(select: 0)
        removeAnimate()
    }
    
    @IBAction func ImageAction(_ sender: Any) {
        
        deleget?.SelectEdit(select: 1)
        removeAnimate()
    }
    
    @IBAction func DetailsAction(_ sender: Any) {
        
        deleget?.SelectEdit(select:2)
        removeAnimate()
    }
    
    @IBAction func ContactWayAction(_ sender: Any) {
        
        deleget?.SelectEdit(select: 3)
        removeAnimate()
    }
    
    @IBAction func ContactSocialMediaAction(_ sender: Any) {
        
        deleget?.SelectEdit(select: 4)
        removeAnimate()
    }
    
    @IBAction func CancelAction(_ sender: Any) {
        
        removeAnimate()
        
    }
    
}
