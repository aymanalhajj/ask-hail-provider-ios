//
//  BusinessProfile.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/6/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class BusinessProfileVC: UIViewController {
    
    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet weak var TableView: UITableView!

    @IBOutlet weak var CompanyName: UILabel!
    @IBOutlet weak var AdsNumber: UILabel!
    
    var AdvArray : [AdvertiserData] = []
    var AdvData = false
    var isSaved = false
    
    var User_id = ""
    var User_Name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAdvertiserProfile()
        
        CompanyName.text = User_Name
        
        TableView.dataSource = self
        TableView.delegate = self
        TableView.RegisterNib(cell: BusinessSubAdsCell.self)
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        TableView.backgroundColor = Colors.ViewBackGroundColoer

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func PhoneCallAction(_ sender: Any) {
        
        
        
    }
    
    @IBAction func WhatsAppAction(_ sender: Any) {
        
        
        
    }
}

extension BusinessProfileVC : UITableViewDataSource ,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AdvArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue() as BusinessSubAdsCell
       
        if AdvData {
            
            var Model = AdvArray[indexPath.row]
            
            cell.ImagesUrl = Model.adv_media ?? []
            cell.pageControl.numberOfPages =  Model.adv_media?.count ?? 0
            cell.PagerView.reloadData()
            cell.CellTitle.text = Model.adv_title
            cell.Price.text = Model.adv_price
            cell.distance.text = Model.adv_distance
            cell.ViewsNumber.text = Model.adv_views
            
            
            cell.StarAdView.isHidden = true
            if Model.adv_special_status == "special" || Model.adv_special_status == "مميز" {
                cell.StarAdView.isHidden = false
            }
            
            cell.SelectCell = {
                
                let storyboard = UIStoryboard(name: Home, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "BusinessAdsDetailsVC") as! BusinessAdsDetailsVC
                vc.AdId = "\(self.AdvArray[indexPath.row].adv_id ?? 0)"
                vc.isProfile = 1
                vc.isHome = 1
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1.0)
        UIView.animate(
            withDuration: 0.4,
            animations: {
                cell.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
            }, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        navigationController?.popToViewController(ofClass: BusinessAdsDetailsVC.self, animated: true)
        
    }
}


extension BusinessProfileVC {
    
    func getAdvertiserProfile() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)advertiser-page/\(User_id)") { (data : AdvertiserProfileModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.AdsNumber.text = data.data?.advertisements_count ?? ""
                
                if data.data?.data?.count ?? 0 >= 0 {
                    self.AdvArray = data.data?.data ?? []
                    self.AdvData = true
                }
                
                self.TableView.reloadData()
                
                print(data)
                
                
            }
        }
        
    }
    
}
