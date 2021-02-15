//
//  MenuBarVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/6/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class MenuBarVC: UIViewController {
    
    @IBOutlet weak var RightView: UIView!
    @IBOutlet weak var LEftView: UIView!
    
    @IBOutlet weak var HomeBtn: UIButton!
    @IBOutlet weak var HomeTitle: UILabel!
    @IBOutlet weak var HomeImage: UIImageView!
    @IBOutlet weak var HomeLineView: UIView!
    
    
    
    @IBOutlet weak var ChatBtn: UIButton!
    @IBOutlet weak var ChatTitle: UILabel!
    @IBOutlet weak var ChatImage: UIImageView!
    @IBOutlet weak var ChatLineView: UIView!
    
    
    @IBOutlet weak var AskHailBtn: UIButton!
    @IBOutlet weak var AskHailTitle: UILabel!
    @IBOutlet weak var AskHailImage: UIImageView!
    @IBOutlet weak var AskHailLineView: UIView!
    
    
    @IBOutlet weak var MoreBtn: UIButton!
    @IBOutlet weak var MoreTitle: UILabel!
    @IBOutlet weak var MoreImage: UIImageView!
    @IBOutlet weak var MoreLineView: UIView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       // home()
        
        RightView.roundCorners(.topRight, radius: 20)
        LEftView.roundCorners(.topLeft, radius: 20)
        
        NotificationCenter.default.addObserver(self, selector: #selector(chooseHome), name: Notification.Name(NotificationCenterpressHome), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(chooseHomeLast), name: Notification.Name(NotificationCenterpressHomeLast), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(chooseAskHail), name: Notification.Name(AskHailNotification), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showMore), name: NSNotification.Name(rawValue: NotificationCenterpreeMoreAppear ), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(chooseChat), name: NSNotification.Name(rawValue: ChatNotification), object: nil)
        

    }
    
    @objc func chooseHomeLast(){
    
        home()
        
        MoreLineView.isHidden = true
        HomeLineView.isHidden = false
        ChatLineView.isHidden = true
        AskHailLineView.isHidden = true
        
    }
    

    
    
    @objc func showMore(){
        
        More()
        
        MoreLineView.isHidden = false
        HomeLineView.isHidden = true
        ChatLineView.isHidden = true
        AskHailLineView.isHidden = true
    
        
    }
    
    @objc func chooseHome(){
        
        if IsMore == 1 {
            IsMore = 0
            dismiss(animated: true, completion: nil)
        }
        
        home()
        
        MoreLineView.isHidden = true
        HomeLineView.isHidden = false
        ChatLineView.isHidden = true
        AskHailLineView.isHidden = true
        
        navigationController?.popToRootViewController(animated: false)
        
    }
    
    
    
    @objc func chooseChat(){
        
        if IsMore == 1 {
            IsMore = 0
            dismiss(animated: true, completion: nil)
        }
        
        Chat()
        
        MoreLineView.isHidden = true
        HomeLineView.isHidden = true
        ChatLineView.isHidden = false
        AskHailLineView.isHidden = true
        
    }
    
    @objc func chooseAskHail(){
        
        if IsMore == 1 {
            IsMore = 0
            dismiss(animated: true, completion: nil)
        }
        
        AskHail()
        
        MoreLineView.isHidden = true
        HomeLineView.isHidden = true
        ChatLineView.isHidden = true
        AskHailLineView.isHidden = false
        
    }
  
    
    
    @IBAction func AddAction(_ sender: Any) {
        
        
        NotificationCenter.default.post(name: Notification.Name(NotificationCenterpreePlusBtn), object: nil)
        
        
    }
    
    
    
    @IBAction func HomeAction(_ sender: Any) {
        
        home()
        
        MoreLineView.isHidden = true
        HomeLineView.isHidden = false
        ChatLineView.isHidden = true
        AskHailLineView.isHidden = true
        
        NotificationCenter.default.post(name: Notification.Name(NotificationCenterpressHome), object: nil)
        
    }
    
    @IBAction func ChatAction(_ sender: Any) {
        
        Chat()
        
        MoreLineView.isHidden = true
        HomeLineView.isHidden = true
        ChatLineView.isHidden = false
        AskHailLineView.isHidden = true
        
        NotificationCenter.default.post(name: Notification.Name(NotificationCenterpreesChat), object: nil)
        Chat()
        
    }
    
    @IBAction func AskHailAction(_ sender: Any) {
        
        AskHail()
        
        MoreLineView.isHidden = true
        HomeLineView.isHidden = true
        ChatLineView.isHidden = true
        AskHailLineView.isHidden = false
        
        NotificationCenter.default.post(name: Notification.Name(NotificationCenterpreeAskHail), object: nil)
        
    }
    
    
    
    @IBAction func MoreAction(_ sender: Any) {
        
        NotificationCenter.default.post(name: Notification.Name(NotificationCenterpreeMore), object: nil)
        
    }
    
    func home() {
        
        HomeImage.image = #imageLiteral(resourceName: "home-1")
        HomeImage.alpha = 1
        HomeTitle.alpha = 1
        
        ChatImage.image = #imageLiteral(resourceName: "chat")
        ChatImage.alpha = 0.5
        ChatTitle.alpha = 0.5
        
        AskHailImage.image = #imageLiteral(resourceName: "ask")
        AskHailImage.alpha = 0.5
        AskHailTitle.alpha = 0.5
        
        MoreImage.image = #imageLiteral(resourceName: "more")
        MoreImage.alpha = 0.5
        MoreTitle.alpha = 0.5
        
    }
    
    func Chat() {
        
        
        
        HomeImage.image = #imageLiteral(resourceName: "home")
        HomeImage.alpha = 0.5
        HomeTitle.alpha = 0.5
        
        ChatImage.image = #imageLiteral(resourceName: "chat-1")
        ChatImage.alpha = 1
        ChatTitle.alpha = 1
        
        AskHailImage.image = #imageLiteral(resourceName: "ask")
        AskHailImage.alpha = 0.5
        AskHailTitle.alpha = 0.5
        
        MoreImage.image = #imageLiteral(resourceName: "more")
        MoreImage.alpha = 0.5
        MoreTitle.alpha = 0.5
        
    }
    
    func AskHail() {
        
        HomeImage.image = #imageLiteral(resourceName: "home")
        HomeImage.alpha = 0.5
        HomeTitle.alpha = 0.5
        
        ChatImage.image = #imageLiteral(resourceName: "chat")
        ChatImage.alpha = 0.5
        ChatTitle.alpha = 0.5
        
        AskHailImage.image = #imageLiteral(resourceName: "flyer")
        AskHailImage.alpha = 1
        AskHailTitle.alpha = 1
        
        MoreImage.image = #imageLiteral(resourceName: "more")
        MoreImage.alpha = 0.5
        MoreTitle.alpha = 0.5
        
    }
    
    func More() {
        
        HomeImage.image = #imageLiteral(resourceName: "home")
        HomeImage.alpha = 0.5
        HomeTitle.alpha = 0.5
        
        ChatImage.image = #imageLiteral(resourceName: "chat")
        ChatImage.alpha = 0.5
        ChatTitle.alpha = 0.5
        
        AskHailImage.image = #imageLiteral(resourceName: "ask-white")
        AskHailImage.alpha = 0.5
        AskHailTitle.alpha = 0.5
        
        MoreImage.image = #imageLiteral(resourceName: "more-1")
        MoreImage.alpha = 1
        MoreTitle.alpha = 1
        
    }
    
    
}
