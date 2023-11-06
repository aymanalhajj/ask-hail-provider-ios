//
//  ExtraMore.swift
//  AskHail
//
//  Created by bodaa on 08/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class ExtraMore: UIViewController {
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
  
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
       
    }
   
    
    @objc func fireTimer() {
        
        tabBarController?.selectedIndex = 0
        timer.invalidate()
    }
    

}
