//
//  AskHailVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/10/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class AskHailVC: BaseViewController {
    
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet weak var AsksTableView: UITableView!
    
    var AskHailArray : [AskData] = []
    var askData = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    var isActive = true
    
    private func createSpinnerFooter() -> UIView {
        let FooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        FooterView.backgroundColor = .clear
        let spinner = UIActivityIndicatorView()
        
        spinner.style = .large
        spinner.color = #colorLiteral(red: 0, green: 0.2846388221, blue: 0.497141242, alpha: 1)
        
        spinner.center = FooterView.center
        FooterView.addSubview(spinner)
        spinner.startAnimating()
        
        return FooterView
        
    }
    
    var CurrentPage = 1
    var lastPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Tajawal-Regular", size: 12)!], for: .normal)
        
        tabBarController?.tabBar.items?[0].title = "Home".localized
        tabBarController?.tabBar.items?[1].title = "Chat".localized
        tabBarController?.tabBar.items?[4].title = "More".localized
        tabBarController?.tabBar.items?[3].title = "Ask Hail".localized
      
        tabBarController?.tabBar.isHidden = false
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        AsksTableView.backgroundColor = Colors.ViewBackGroundColoer
        
        AsksTableView.delegate = self
        AsksTableView.dataSource = self
        
        AsksTableView.RegisterNib(cell: AskHailWithPhotoCell.self)
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(showPopUp), name: NSNotification.Name(rawValue: NotificationCenterpreePlusBtn), object: nil)
        self.CurrentPage = 1
        self.lastPage = 1
        self.AskHailArray.removeAll()
        getAskHail()
    }
    
    @IBAction func NotificationAction(_ sender: Any) {
        
        guard let token = Helper.getapitoken() else {
            
            alertSkipLogin()
            return
        }
        
        let storyboard = UIStoryboard(name: Notification_Stry, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        // present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func PrayTimeAction(_ sender: Any) {
        
        guard Helper.getapitoken() != nil else {
            
            alertSkipLogin()
            return
        }
        
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "PrayTimeVC") as! PrayTimeVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    
}

extension AskHailVC : UITableViewDataSource , UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let ContentHeight = scrollView.contentSize.height
        // print(position , tableView.contentSize.height)
        if isActive {
            if position > ContentHeight - scrollView.frame.height {
                
                print("Done")
                isActive = false
                
                //numberofitem
                
                //  print(CurrentPage , lastPage)
                if CurrentPage < lastPage {
                    
                    CurrentPage = CurrentPage + 1
                    
                    self.getAskHail()
                    
                }
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AskHailArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeue() as AskHailWithPhotoCell
        
        if AskHailArray.count > indexPath.row {
            
            var Model = AskHailArray[indexPath.row]
            
            cell.CellName.isHidden = true
            if Model.question_show_name_status == "active" {
                cell.CellName.isHidden = false
                cell.CellName.text = Model.question_advertiser_name ?? ""
            }
            
            cell.ImageHight.constant = 0
            if Model.question_image != "" {
                cell.askImage.loadImage(URL(string: Model.question_image ?? ""))
                cell.ImageHight.constant = 100
            }
            
            cell.IsNewView.isHidden = false
            if Model.question_date_status ?? "" == "" {
                cell.IsNewView.isHidden = true
            }
            
            cell.CellTime.text = Model.question_custom_date ?? ""
            cell.CellTitle.text = Model.question_title ?? ""
            cell.cellHaveComment.text = Model.question_replies_text ?? ""
            
            
        }
        
        
        setShadow(view: cell, width: 5, height: 5, shadowRadius: 7, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.905375392, green: 0.905375392, blue: 0.905375392, alpha: 1))
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: AskHail, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "AskHailDetailsVC") as! AskHailDetailsVC
        vc.height = 0
        vc.ask_id = "\(AskHailArray[indexPath.row].question_id ?? 0)"
        vc.imageUrl = "\(AskHailArray[indexPath.row].question_image ?? "")"
        
        navigationController?.pushViewController(vc, animated: true)
        
        return tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension AskHailVC {
    
    func getAskHail() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)ask-hail?page=\(CurrentPage)") { (data : AskHailModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.CurrentPage = data.data?.pagination?.current_page ?? 1
                self.lastPage = data.data?.pagination?.last_page ?? 1
                
                if data.data?.data?.count ?? 0 == 0 {
                    self.AsksTableView.isHidden = true
                    self.askData = false
                }else {
                    self.AsksTableView.isHidden = false
                    self.askData = true
                }
                
                
                for item in data.data?.data ?? [] {
                    self.AskHailArray.append(item)
                }
                
                self.AsksTableView.reloadData()
                self.isActive = true
                
                print(data)
                
                
            }
        }
    }
}

