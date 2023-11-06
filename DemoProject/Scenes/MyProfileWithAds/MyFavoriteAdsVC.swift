//
//  MyFavoriteAdsVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/14/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class MyFavoriteAdsVC: UIViewController {

    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet var BackGround: UIView!
    
    var MyFavoriteArray : [MyFavoriteAdvData] = []
    var MyFavoriteData = false

    
    var isSaved = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMyFavoriteAdv()
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        TableView.backgroundColor = Colors.ViewBackGroundColoer
        
        
        setShadow(view: TopView, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        TableView.RegisterNib(cell: SubAdsCell.self)
        TableView.delegate = self
        TableView.dataSource = self
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func RemoveAllAdsAction(_ sender: Any) {
        RemoveAllFavourite()
    }
}

extension MyFavoriteAdsVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyFavoriteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableView.dequeue() as SubAdsCell
        
        if MyFavoriteData {
            
            setShadow(view: cell, width: 0, height: 2, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
            
            var Model = MyFavoriteArray[indexPath.row]
            
            cell.ImagesUrl = Model.adv_media ?? []
            cell.pageControl.numberOfPages =  Model.adv_media?.count ?? 0
            cell.PagerView.reloadData()
            cell.name.text = Model.adv_title
            cell.Price.text = Model.adv_price
            cell.distance.text = Model.adv_distance
            cell.ViewsNumber.text = Model.adv_views
            
            cell.StarAdView.isHidden = true
            
            if Model.adv_special_status == "مميز" || Model.adv_special_status == "special" {
                cell.StarAdView.isHidden = false
            } else {
                cell.StarAdView.isHidden = true
            }
            
            
            cell.SaveBtn.setBackgroundImage(UIImage(named: "save_white"), for: .normal)
            
            if Model.adv_is_favorite == true {
                cell.SaveBtn.setBackgroundImage(UIImage(named: "save_white-1"), for: .normal)
            }else{
                cell.SaveBtn.setBackgroundImage(UIImage(named: "save_white"), for: .normal)
            }
            
            cell.SelectCell = {
//                let storyboard = UIStoryboard(name: Home, bundle: nil)
//                let vc  = storyboard.instantiateViewController(withIdentifier: "AdsVC") as! AdsVC
//                vc.AdId = "\(self.MyFavoriteArray[indexPath.row].adv_id ?? 0)"
//                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
            cell.SaveAcrion = {
                
                self.AddToFavourite(advertisement_id: "\(Model.adv_id ?? 0)")
                
                if Model.adv_is_favorite == false {
                    cell.SaveBtn.setBackgroundImage(UIImage(named: "save_white-1"), for: .normal)
                    Model.adv_is_favorite = true
                }else{
                    cell.SaveBtn.setBackgroundImage(UIImage(named: "save_white"), for: .normal)
                    Model.adv_is_favorite = false
                }
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: BusinessAds, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "BusinessAdsVC") as! BusinessAdsDetailsVC
        navigationController?.pushViewController(vc, animated: true)
         
        return tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}


extension MyFavoriteAdsVC {
    
    func getMyFavoriteAdv() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)user/my-favorite-advertisements") { (data : MyFavoriteAdvModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.TableView.isHidden = true
                self.MyFavoriteArray = data.data ?? []
                if self.MyFavoriteArray.count > 0 {
                    self.TableView.isHidden = false
                    self.MyFavoriteData = true
                    self.TableView.reloadData()
                }

                
                print(data)
                
                
            }
        }
    }
    
    func AddToFavourite(advertisement_id : String) {
        
        let param = [
            "advertisement_id" : advertisement_id
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)advertisement-operations/add-remove-favorite") { (data : ContactUsModel?, String) in
            
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
    
    func RemoveAllFavourite() {
        
        ApiServices.instance.getPosts(methodType: .post, parameters: nil , url: "\(hostName)user/remove-all-favorite-advertisements") { (data : ContactUsModel?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                self.navigationController?.popViewController(animated: true)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.navigationController?.popViewController(animated: true)
                
                print(data)
                
            }
        }
    }
    
}


