//
//  PaymenSuccessesVC.swift
//  AskHail
//
//  Created by bodaa on 12/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit

class PaymenSuccessesVC: UIViewController {

    @IBOutlet weak var SuccessesPayment: UILabel!
    @IBOutlet weak var Desc: UILabel!
    @IBOutlet var BackGround: UIView!
    
    var messege = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        SuccessesPayment.text = "Payment was successful".localized
        Desc.text = messege
        
    }
    

    @IBAction func BackTohome(_ sender: Any) {
        
        guard let window = UIApplication.shared.keyWindow else{return}
        let sb = UIStoryboard(name: Home, bundle: nil)
        var vc : UIViewController
        vc = sb.instantiateViewController(withIdentifier: "HomeVC")
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        
    }
    
}
