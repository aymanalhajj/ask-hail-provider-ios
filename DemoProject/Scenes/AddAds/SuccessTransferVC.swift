//
//  SuccessTransferVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/7/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class AdsSuccessTransferVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func BackToPlaceTypeAction(_ sender: Any) {
        
        navigationController?.popToViewController(ofClass: AdsPlaceTypeVC.self, animated: true)
        
    }
    

}
