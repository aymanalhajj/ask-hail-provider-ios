//
//  DeleteAllNotificationsVC.swift
//  AskHail
//
//  Created by Mohab on 11/14/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
protocol deleteAllNotification {
    func deleteNotifications()
}

class DeleteAllNotificationsVC: UIViewController {

    var Delegate : deleteAllNotification?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       showAnimate()
        
    }
    
    @IBAction func DeleteAction(_ sender: Any) {
        Delegate?.deleteNotifications()
        removeAnimate()
    }
    
 
    @IBAction func backActin(_ sender: Any) {
        removeAnimate()
    }
    

}
