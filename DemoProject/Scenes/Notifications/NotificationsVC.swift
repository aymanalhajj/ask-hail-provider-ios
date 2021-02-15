//
//  NotificationsVC.swift
//  AskHail
//
//  Created by Mohab on 11/14/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {
    
    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var DeleteAllBtn: UIButton!
    @IBOutlet weak var TopBar: UIView!
    
    
    var NotificationArray : [NotificationData] = []
    var notificationData = false
    var notifi_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        DeleteAllBtn.isHidden = true
        
        tabBarController?.tabBar.isHidden = true
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        tableView.backgroundColor = Colors.ViewBackGroundColoer
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.RegisterNib(cell: NotificationCells.self)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getNotification()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    
    @IBAction func BackAction(_ sender: Any) {
        
        tabBarController?.tabBar.isHidden = false
        navigationController?.popToRootViewController(animated: true)
        
        
    }
    
    
    @IBAction func DeleteAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Notification_Stry, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "DeleteAllNotificationsVC") as! DeleteAllNotificationsVC
        vc.Delegate = self
        vc.modalPresentationStyle = .fullScreen
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
    
}

extension NotificationVC : deleteAllNotification {
    
    func deleteNotifications() {
        
        deletAllNotification()
        tableView.isHidden = true
        tableView.reloadData()
        
    }
}



//MARK:TableView Controller

extension NotificationVC : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NotificationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue() as NotificationCells
        
        if notificationData {
            
            tableView.isHidden = false
            
            var Model = NotificationArray[indexPath.row]
            
            cell.CellTitle.text = Model.notify_text ?? ""
            cell.CellDec.text = Model.notify_type_title ?? ""
            cell.CellTime.text = Model.notify_custom_date ?? ""
            
            cell.lineView.isHidden = false
            if indexPath.row == NotificationArray.count {
                
                cell.lineView.isHidden = true
                
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if NotificationArray[indexPath.row].notify_type == "adv" {
            
            let storyboard = UIStoryboard(name: Home, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "BusinessAdsDetailsVC") as! BusinessAdsDetailsVC
            vc.AdId = "\(NotificationArray[indexPath.row].notify_type_id ?? 0)"
            navigationController?.pushViewController(vc, animated: true)
            
            
        }else if NotificationArray[indexPath.row].notify_type == "subscription"{
            
            let storyboard = UIStoryboard(name: MyProfile, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "MyPackgeVC") as! MyPackgeVC
            navigationController?.pushViewController(vc, animated: true)
            
        }else if NotificationArray[indexPath.row].notify_type == "special_subscription"{
            
            let storyboard = UIStoryboard(name: Home, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "StarAdDetailsVC") as! StarAdDetailsVC
            vc.Ad_id = "\(NotificationArray[indexPath.row].notify_type_id ?? 0)"
            navigationController?.pushViewController(vc, animated: true)
            
        } else if NotificationArray[indexPath.row].notify_type == "question" {
            
            let storyboard = UIStoryboard(name: Home, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "AskHailDetailsVC") as! AskHailDetailsVC
            vc.ask_id = "\(NotificationArray[indexPath.row].notify_type_id ?? 0)"
            navigationController?.pushViewController(vc, animated: true)
            
        }else if NotificationArray[indexPath.row].notify_type == "chat" {
            
            let storyboard = UIStoryboard(name: Home, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "chatVC") as! chatVC
            vc.chat_type_id = "\(NotificationArray[indexPath.row].notify_id ?? "")"
            navigationController?.pushViewController(vc, animated: true)
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == .delete {
            print("Deleted")
            
            deletNotification(notification_id: NotificationArray[indexPath.row].notify_id ?? "")
            NotificationArray.remove(at: indexPath.row) //Remove element from your array
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            if NotificationArray.count == 0 {
                tableView.isHidden = true
                DeleteAllBtn.isHidden = true
            }
            
            tableView.reloadData()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1.0)
        UIView.animate(
            withDuration: 0.4,
            animations: {
                cell.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
            }, completion: nil)
    }
    
}

extension NotificationVC {
    
    func getNotification() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)notification-operations/my-notifications") { (data : NotificationModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                self.tableView.isHidden = true
                
                self.NotificationArray = data.data ?? []
                
                if self.NotificationArray.count > 0 {
                    self.notificationData = true
                    self.tableView.isHidden = false
                    self.DeleteAllBtn.isHidden = false
                }
                
                self.tableView.reloadData()
                
                print(data)
                
                
            }
        }
    }
    
    func deletNotification(notification_id : String) {
        
        ApiServices.instance.getPosts(methodType: .post, parameters: nil , url: "\(hostName)notification-operations/delete-notification/\(notification_id)") { (data : Level_6_Model?, String) in
                        
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                print(data)
                
                
            }
        }
    }
    
    func deletAllNotification() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .post, parameters: nil , url: "\(hostName)notification-operations/delete-all-notifications") { (data : Level_6_Model?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                self.NotificationArray.removeAll()
                self.DeleteAllBtn.isHidden = true
                self.tableView.isHidden = true
                self.tableView.reloadData()
                
                print(data)
                
                
            }
        }
    }
}


