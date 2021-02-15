//
//  DetermineTimeVC.swift
//  DemoProject
//
//  Created by Mohab on 4/25/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit


class DetermineTimeVC: UIViewController {
    
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    
    @IBOutlet weak var DatePicker: UIDatePicker!
    
    var dateTime = [String:String]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        
    }
    
    @IBAction func CAncelAction(_ sender: Any) {
        
        self.view.removeFromSuperview()
        
    }
    
    
    
    @IBAction func ConfirmAction(_ sender: Any) {
      
        DatePicker.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let selectedDate = dateFormatter.string(from: DatePicker.date)
        print(selectedDate)
        
        print(selectedDate)
        dateTime["date"] = selectedDate
        
         DatePicker.datePickerMode = UIDatePicker.Mode.time
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let selectedtime = dateFormatter.string(from: DatePicker.date)
        
        print(selectedtime)
        dateTime["time"] = selectedtime
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: Notification_Determine_time), object: dateTime)
   
        
     print("later")
         print(selectedtime)
        
        self.view.removeFromSuperview()
        
    }
    
    
   
    

}



