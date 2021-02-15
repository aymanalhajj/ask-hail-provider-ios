//
//  BusinessAdsPopUpVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/6/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class BusinessAdsPopUpVC: UIViewController {
    
    var image = ""
    @IBOutlet weak var ImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImageView.loadImage(URL(string: image))
        
        showAnimate()
        
    }
    
    @IBAction func BAckAction(_ sender: Any) {
        
        removeAnimate()
    }

}
