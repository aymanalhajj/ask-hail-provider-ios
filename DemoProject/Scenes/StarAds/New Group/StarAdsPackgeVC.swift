//
//  StarAdsPackgeVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/12/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
class StarAdsPackgeVC: UIViewController {
    
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var PackageTableView: UITableView!
    @IBOutlet weak var TopBarTitle: UILabel!
    
    var packagesArray : [PackagesData] = []
    
    var packageData = false
    var state = ""
    var displayPlace = ""
    var Adv_Id = ""
    var topTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TopBarTitle.text = "Change Package".localized
        
            getPackages()
       
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        PackageTableView.dataSource = self
        PackageTableView.delegate = self
        PackageTableView.RegisterNib(cell: packageCell.self)
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func ComplitePackageAction(_ sender: Any) {
        

        
    }
    
}
extension StarAdsPackgeVC : UITableViewDelegate , UITableViewDataSource {
    
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
       
        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsPaymentDetailsVC") as! AdsPaymentDetailsVC
        vc.state = self.state
        vc.Model = packagesArray[indexPath.row]
        vc.displayPlace = displayPlace
        vc.Adv_Id = Adv_Id
        navigationController?.pushViewController(vc, animated: true)
        
        } else {
            UpdatePackage(package_id: "\(packagesArray[indexPath.row].package_id ?? 0)")
        }
        return tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

extension StarAdsPackgeVC {
    
    func getPackages() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)packages") { (data : PackagesModel?, String) in
            
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
    
    func UpdatePackage(package_id : String) {
        
        self.view.lock()
        
        let param = [
            "package_id": package_id ,
            "payment_way": "no_payment",
        ] as [String : Any]
        
        
        ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)update-package") { (data : Level_6_Model?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.navigationController?.popToViewController(ofClass: MyPackgeVC.self)
                self.navigationController?.view.makeToast("\(data.data ?? "")")
                print(data)
                
                
            }
        }
    }
}
