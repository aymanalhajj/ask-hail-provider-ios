//
//  SettingVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/1/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var TopBar: UIView!
    @IBOutlet var BackGround: UIView!
    
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var View2: UIView!
    
    @IBOutlet weak var NotificationSwitch: UISwitch!
    @IBOutlet weak var NewCommentSwitch: UISwitch!
    @IBOutlet weak var PrivteMessgeSwitch: UISwitch!
    @IBOutlet weak var ReplayCommentSwitch: UISwitch!
    @IBOutlet weak var OtherOneSaveAdsSwitch: UISwitch!
    
    @IBOutlet weak var ChangeLangBnt: UIButton!
    @IBOutlet weak var CurrentLan: UILabel!
    
    var notificationState = ""
    var newCommentState = ""
    var privteMassegeState = ""
    var replayCommentState = ""
    var othertSaveState = ""
    
    var id = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSetting()
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        setShadow(view: View1,width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        setShadow(view: View2 ,width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        NotificationSwitch.transform = CGAffineTransform(scaleX: 0.80, y: 0.80)
        NewCommentSwitch.transform = CGAffineTransform(scaleX: 0.80, y: 0.80)
        PrivteMessgeSwitch.transform = CGAffineTransform(scaleX: 0.80, y: 0.80)
        ReplayCommentSwitch.transform = CGAffineTransform(scaleX: 0.80, y: 0.80)
        OtherOneSaveAdsSwitch.transform = CGAffineTransform(scaleX: 0.80, y: 0.80)
        
        
        if L102Language.currentAppleLanguage() == englishLang {
            
            ChangeLangBnt.setTitle("تحويل اللغة الى العربي", for: .normal)
            CurrentLan.text = "English"
            
        }
        
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }

    
    @IBAction func BackAction(_ sender: Any) {
        
        id = 1
        updateSetting()
        
    }

    @IBAction func SwitchLangugeAvtion(_ sender: Any) {
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Your Language", preferredStyle: .actionSheet)

          let saveAction = UIAlertAction(title: "English", style: .default, handler:
          {
              (alert: UIAlertAction!) -> Void in
            
            if L102Language.currentAppleLanguage() == "ar" {
                self.changeLanguage(vcId: .login)
                              }
       
             print("English")
          })

          let deleteAction = UIAlertAction(title: "عربي", style: .default, handler:
          {
              (alert: UIAlertAction!) -> Void in
              print("عربي")
            if L102Language.currentAppleLanguage() == "en" {
                self.changeLanguage(vcId: .home)
            }
            
         
          })

          let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
          {
              (alert: UIAlertAction!) -> Void in
             print("Cancel")
          })
          optionMenu.addAction(deleteAction)
          optionMenu.addAction(saveAction)
          optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
        
        
    }
    
    func goHome() {
        guard let window = UIApplication.shared.keyWindow else{return}
        let sb = UIStoryboard(name: Home, bundle: nil)
        var vc : UIViewController
        vc = sb.instantiateViewController(withIdentifier: "HomeVC")
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
    }
    
}

extension SettingVC {
    
    func getSetting() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)edit-my-settings") { (data : EditSettingModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.NotificationSwitch.isOn = false
                self.NewCommentSwitch.isOn = false
                
                
                if data.data?.advertiser_all_notifications_status == "active" {
                    self.NotificationSwitch.isOn = true
                    self.notificationState = "active"
                }else{
                    self.NotificationSwitch.isOn = false
                    self.notificationState = "block"
                }
                
                if data.data?.advertiser_new_comments_status == "active" {
                    self.NewCommentSwitch.isOn = true
                    self.newCommentState = "active"
                }else{
                    self.NewCommentSwitch.isOn = false
                    self.newCommentState = "block"
                }
                
                if data.data?.advertiser_chat_status == "active" {
                    self.PrivteMessgeSwitch.isOn = true
                    self.privteMassegeState = "active"
                }else{
                    self.PrivteMessgeSwitch.isOn = false
                    self.privteMassegeState = "block"
                }
                
                if data.data?.advertiser_question_replies_status == "active" {
                    self.ReplayCommentSwitch.isOn = true
                    self.replayCommentState = "active"
                }else{
                    self.ReplayCommentSwitch.isOn = false
                    self.replayCommentState = "block"
                }
                
                if data.data?.advertiser_favorite_status == "active" {
                    self.OtherOneSaveAdsSwitch.isOn = true
                    self.othertSaveState = "active"
                }else{
                    self.OtherOneSaveAdsSwitch.isOn = false
                    self.othertSaveState = "block"
                }
                
                print(data)
                
            }
        }
    }
    
    func updateSetting() {
        
        if self.NotificationSwitch.isOn == true {
            self.notificationState = "active"
        }else{
            self.notificationState = "block"
        }
        
        if self.NewCommentSwitch.isOn == true {
            self.newCommentState = "active"
        }else{
            self.newCommentState = "block"
        }
        
        if self.PrivteMessgeSwitch.isOn == true {
            self.privteMassegeState = "active"
        }else{
            self.privteMassegeState = "block"
        }
        
        if self.ReplayCommentSwitch.isOn == true {
            self.replayCommentState = "active"
        }else{
            self.replayCommentState = "block"
        }
        
        if self.OtherOneSaveAdsSwitch.isOn == true {
            self.othertSaveState = "active"
        }else{
            self.othertSaveState = "block"
        }
        
        self.view.lock()
        
        var Parameters = [
            "all_notifications_status" : notificationState,
            "new_comments_status" : newCommentState,
            "chat_status" : privteMassegeState,
            "question_replies_status" : replayCommentState,
            "favorite_status" : othertSaveState,
            "language_used" : L102Language.currentAppleLanguage()
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)update-my-settings") { (data : Level_6_Model?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                if self.id == 1 {
                    self.goHome()
                }
                
                print(data)
                
            }
        }
    }
}

