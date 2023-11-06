//
//  ChoseGradeVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/7/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class ChoseGradeVC: UIViewController {
    
    var isHome = 0
    var state = ""
    
    @IBOutlet weak var PackageTableView: UITableView!
    
    var packagesArray : [PackagesData] = []
    var packageData = false
    var Model : PackagesData?
    var Ad_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPackages()
        
        PackageTableView.dataSource = self
        PackageTableView.delegate = self
        PackageTableView.RegisterNib(cell: packageCell.self)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        if isHome == 0 {
            navigationController?.popViewController(animated: true)
        }
        else{
            guard let window = UIApplication.shared.keyWindow else{return}
            let sb = UIStoryboard(name: Home, bundle: nil)
            var vc : UIViewController
            vc = sb.instantiateViewController(withIdentifier: "HomeVC")
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        }
        
    }
    
}


//MARK:TableView Extension
extension ChoseGradeVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue() as packageCell
        
        setShadow(view:cell, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        if self.packageData {
            
            var Model = packagesArray[indexPath.row]
            
            cell.packageName.text = Model.package_name ?? ""

            cell.PackageTime.text = Model.package_duration_in_days ?? ""
            cell.PackagePrice.text = Model.package_price ?? ""
            cell.AdsNumberLbl.text = Model.package_advertisements_count ?? ""
            cell.packageDesc.text = Model.package_description ?? ""
            
            if Int(Model.package_price ?? "") ?? 0 == 0 {
                cell.PackagePrice.text = "Free".localized
            }
            
            
            
            if Model.package_rate == "1" {
                
                cell.LImage.image = #imageLiteral(resourceName: "feature-1")
                cell.Rimage.image = #imageLiteral(resourceName: "feature-1")
                
            }
            
            if Model.package_rate == "2" {
                
                cell.LImage.image = #imageLiteral(resourceName: "Blue-Star")
                cell.Rimage.image = #imageLiteral(resourceName: "Blue-Star")
                
            }
            
            if Model.package_rate == "3" {
                
                cell.LImage.image = #imageLiteral(resourceName: "Gold-Star")
                cell.Rimage.image = #imageLiteral(resourceName: "Gold-Star")
                
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if Int(packagesArray[indexPath.row].package_price ?? "") ?? 0 != 0 {
            Model = packagesArray[indexPath.row]
            
            let storyboard = UIStoryboard(name: AddAds, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "AdsPaymentAlertVC") as! AdsPaymentAlertVC
            vc.Delegate = self
            vc.state = self.state
            vc.Package_id = "\(packagesArray[indexPath.row].package_id ?? 0)"
            vc.modalPresentationStyle = .fullScreen
            self.addChild(vc)
            vc.view.frame = self.view.frame
            self.view.addSubview(vc.view)
            vc.didMove(toParent: self)
        }else{
            
            ChosePackage(Package_id: "\(packagesArray[indexPath.row].package_id ?? 0)")
            
        }
        
        return tableView.deselectRow(at: indexPath, animated: true)
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

extension ChoseGradeVC : PayTime {
    func time(status: Int, adv_id: String, states: String) {
        print(status)
        
        if status == 1 {
            
            let storyboard = UIStoryboard(name: AddAds , bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "AdsPaymentDetailsVC") as! AdsPaymentDetailsVC
            vc.Model = self.Model
            vc.Adv_Id = self.Ad_id
            vc.state = states
            IsNew = 0
            navigationController?.pushViewController(vc, animated: true)
            
        } else if status == 2 {
            
            let storyboard = UIStoryboard(name: AddAds, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "AdsPlaceTypeVC") as! AdsPlaceTypeVC
            vc.Ad_id = adv_id
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}


//MARK:API
extension ChoseGradeVC {
    
    func getPackages() {
        self.view.lock()
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)business-packages") { (data : PackagesModel?, String) in
            
            self.view.unlock()
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.packagesArray = data.data ?? []
                
                self.packageData = true
                self.PackageTableView.reloadData()

                print(data)
                
                
            }
        }
    }
    
    func ChosePackage(Package_id : String) {
        
        self.view.lock()
        
        var Parameters = [
            "package_id": Package_id,
            "payment_way": "no_payment",
            "payment_time":"now",
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject], url: "\(hostName)business-add-advertisement/add-package") { (data : Level_1_Model?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "AdsPlaceTypeVC") as! AdsPlaceTypeVC
                vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                self.navigationController?.pushViewController(vc, animated: true)

                
                print(data)
                
                
            }
        }
    }
    
}

