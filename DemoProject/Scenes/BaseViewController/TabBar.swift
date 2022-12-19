//
//  TabBar.swift
//  AskHail
//
//  Created by bodaa on 07/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
import STTabbar

extension Helper {
    
    static func openZoomAbleImage(image: UIImage, vc: UIViewController) {
        let zoomVC = UIStoryboard(name: "ZoomAbleImage", bundle: nil).instantiate(identifier: "PhotoDetialsVC", asClass: PhotoDetialsVC.self)
        zoomVC.theImage = image
        vc.modalPresentationStyle = .fullScreen
        vc.present(zoomVC, animated: true, completion: nil)
    
    }
}

protocol AddButtonProtocol {
    func AddButton()
}

class CustomTabViewController: UITabBarController , UITabBarControllerDelegate {
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
          print("ddd")
      }
    
    var Delegate : AddNewProtocl?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        if let myTabbar = tabBar as? STTabbar {
            
            myTabbar.centerButtonColor = UIColor.init(hexString: "#39CDEE")
            myTabbar.selectionColor = UIColor.init(hexString: "#034B89")
            myTabbar.buttonImage = UIImage.init(named: "plus")

            guard Helper.getapitoken() != nil else {
                alertSkipLogin()
                return
            }
            
            myTabbar.centerButtonActionHandler = {
                NotificationCenter.default.post(name: Notification.Name(NotificationCenterpreePlusBtn), object: nil)
                print("Center Button Tapped")
            }
        }
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

           let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
           if selectedIndex == 4 {
            let storyboard = UIStoryboard(name: More, bundle: nil)
            
            guard let popupVC = storyboard.instantiateViewController(withIdentifier: "MoreVC") as? MoreVC else { return }
            
            //popupVC.Delegate = self
            popupVC.height = (self.view.frame.height-120)
            popupVC.topCornerRadius = 8
            popupVC.presentDuration = 0.7
            popupVC.dismissDuration = 0.7
          //  popupVC.modalPresentationStyle = .overCurrentContext
            self.present(popupVC, animated: true, completion: nil)
           } else {
               //do whatever
           }
       }
}
