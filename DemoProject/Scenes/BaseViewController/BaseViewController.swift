//
//  BaseViewController.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/7/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit



class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(showPopUp), name: NSNotification.Name(rawValue: NotificationCenterpreePlusBtn), object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
      
        
    }
    
    @objc func showShatScreen(){
        
        let storyboard = UIStoryboard(name: Chat, bundle: nil)
        
        let popupVC = storyboard.instantiateViewController(withIdentifier: "MessagesVC") as! MessagesVC
        
        navigationController?.pushViewController(popupVC, animated: false)
        
    }
    
    @objc func showAskHail(){
        
        let storyboard = UIStoryboard(name: AskHail, bundle: nil)
        
        let popupVC = storyboard.instantiateViewController(withIdentifier: "AskHailVC") as! AskHailVC
        
        navigationController?.pushViewController(popupVC, animated: false)
        
    }
    
    @objc func showHome(){
        
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    @objc func showMore(){
        
        let storyboard = UIStoryboard(name: More, bundle: nil)
        
        guard let popupVC = storyboard.instantiateViewController(withIdentifier: "MoreVC") as? MoreVC else { return }
        
        //popupVC.Delegate = self
        popupVC.height = (self.view.frame.height-120)
        popupVC.topCornerRadius = 8
        popupVC.presentDuration = 0.7
        popupVC.dismissDuration = 0.7
      //  popupVC.modalPresentationStyle = .overCurrentContext
        self.present(popupVC, animated: true, completion: nil)
        
    }
    
    @objc func showPopUp(){
      //  self.tabBarController?.selectedIndex = 0
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "AddNewPopUpVC") as! AddNewPopUpVC
        vc.Delegate = self
        vc.modalPresentationStyle = .fullScreen
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
//
    }
    

}

extension BaseViewController :AddNewProtocl {
    func AddNew(status: Int ) {
        
        print(status)
        if status == 1 {
            
            let storyboard = UIStoryboard(name: AddAds , bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "AdsTermsVC") as! AdsTermsVC
            navigationController?.pushViewController(vc, animated: true)
        } else if status == 3 {
            
            let storyboard = UIStoryboard(name: AddAskHail, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "AskTermsVC") as! AskTermsVC
            navigationController?.pushViewController(vc, animated: true)
            
            
        }
    }
}
