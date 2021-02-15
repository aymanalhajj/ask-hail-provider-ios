//
//  DeleteNotification.swift
//  AskHail
//
//  Created by Mohab on 11/14/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//


import UIKit

protocol DeletOneNotification {
    func Delet()
}

class DeleteNotification: UIViewController {
    
    var Delegate : DeletOneNotification?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAnimate()
    }
    
    @IBAction func DeleteAction(_ sender: Any) {
        Delegate?.Delet()
        removeAnimate()
    }
    
    @IBAction func backAction(_ sender: Any) {
        removeAnimate()
    }
    
}
