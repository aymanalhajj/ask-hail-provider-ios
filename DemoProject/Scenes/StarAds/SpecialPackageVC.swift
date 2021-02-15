//
//  SpecialPackageVC.swift
//  AskHail
//
//  Created by bodaa on 12/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit

class SpecialPackageVC: UIViewController {

    @IBOutlet weak var TopBar: UIView!
    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var PackageTableView: UITableView!
    @IBOutlet weak var TopBarTitle: UILabel!
    
    var packagesArray : [SpecialPackageData] = []
    
    var packageData = false
    var state = ""
    var displayPlace = ""
    var Adv_Id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSpecialPackages()
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        PackageTableView.dataSource = self
        PackageTableView.delegate = self
        PackageTableView.RegisterNib(cell: SpicalPackageCell.self)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
}

//MARK:-TablbeView Controller
extension SpecialPackageVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue() as SpicalPackageCell
        
        setShadow(view:cell, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        if self.packageData {
            
            var Model = packagesArray[indexPath.row]
            
            cell.packageName.text = Model.package_name ?? ""

            cell.PackageTime.text = Model.package_duration_in_days ?? ""
            cell.PackagePrice.text = Model.package_price ?? ""
            cell.packageDesc.text = Model.package_description ?? ""
            
            
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
       
        let storyboard = UIStoryboard(name: StarAds, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "SpectailPaymentWayVC") as! SpectailPaymentWayVC
        vc.Model = packagesArray[indexPath.row]
        vc.Package_id = "\(packagesArray[indexPath.row].package_id ?? 0)"
        vc.Adv_Id = self.Adv_Id
        vc.displayPlace = self.displayPlace
        navigationController?.pushViewController(vc, animated: true)
        
        return tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension SpecialPackageVC {
    
    func getSpecialPackages() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)special-packages?special_with=\(displayPlace)") { (data : SpecialPackageModel?, String) in
            
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
    
}
