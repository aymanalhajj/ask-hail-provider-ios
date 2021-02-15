//
//  RequestSendedVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 10/30/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class RequestSendedVC: UIViewController {

    @IBOutlet var BackGround: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }

    @IBAction func BackToHomeAction(_ sender: Any) {
        
        guard let window = UIApplication.shared.keyWindow else{return}
        let sb = UIStoryboard(name: Home, bundle: nil)
        var vc : UIViewController
        vc = sb.instantiateViewController(withIdentifier: "HomeVC")
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        
    }
}
