//
//  AskSuccessAddVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/9/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class AskSuccessAddVC: UIViewController {
    
    
    @IBOutlet weak var messgeData: UILabel!
    
    var messege = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messgeData.text = messege
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        navigationController?.popToViewController(ofClass: AskHailVC.self, animated: true)
        
    }
    
    @IBAction func BackToAskHail(_ sender: Any) {
        
        guard let window = UIApplication.shared.keyWindow else{return}
        let sb = UIStoryboard(name: Home, bundle: nil)
        var vc : UIViewController
        vc = sb.instantiateViewController(withIdentifier: "HomeVC")
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        tabBarController?.selectedIndex = 2
        
    }

}
