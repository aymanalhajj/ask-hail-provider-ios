//
//  Extention+ContactWay.swift
//  AskHail
//
//  Created by bodaa on 13/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
import UIKit

func MakeCall(number : String) {

 if let url = URL(string: "tel://\(number)"),
   UIApplication.shared.canOpenURL(url) {
      if #available(iOS 10, *) {
        UIApplication.shared.open(url, options: [:], completionHandler:nil)
       } else {
           UIApplication.shared.openURL(url)
       }
   } else {
            // add error message here
   }
}

func OpenWhatsApp(number : String)  {
    
    let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(number)")!
    print(appURL)
    if UIApplication.shared.canOpenURL(appURL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        }
        else {
            UIApplication.shared.openURL(appURL)
        }
    } else {
        // WhatsApp is not installed
    }
}


func OpenUrl(url : String)  {
    
    let appURL = URL(string: "\(url)")!
    print(appURL)
    if UIApplication.shared.canOpenURL(appURL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        }
        else {
            UIApplication.shared.openURL(appURL)
        }
    } else {
        // WhatsApp is not installed
    }
}

func openUrl(link: String){
        var url = NSURL(string: link)

        if UIApplication.shared.canOpenURL(url! as URL) {
            UIApplication.shared.openURL(url! as URL)
        }
    }
