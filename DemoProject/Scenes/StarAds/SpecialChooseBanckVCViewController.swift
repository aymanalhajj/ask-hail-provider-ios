//
//  SpecialChooseBanckVC.swift
//  AskHail
//
//  Created by bodaa on 13/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit

class SpecialChooseBanckVC: UIViewController {
    
    
    
    var displayPlace = ""
    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var DetailView: UIView!
    
    @IBOutlet weak var LoadingView: UIView!
    @IBOutlet weak var Titlee: UILabel!
    @IBOutlet weak var StarRight: UIImageView!
    @IBOutlet weak var StarLeft: UIImageView!
    
    @IBOutlet weak var AdsPrice: UILabel!
    @IBOutlet weak var AdsTime: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var BankTableView: UITableView!
    var Model : SpecialPackageData?
    
    
    var BanksArray : [AllBankData] = []
    var bankData = false
    
    var state = ""
    var PaymentWay = ""
    var Adv_Id = ""
    
    var Package_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Model?.package_id != nil {
            Package_id = "\(Model?.package_id ?? 0)"
        }
        
        getPackageData()
        getAllBank()
        //getPackageDetails()
        
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        LoadingView.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: DetailView, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        BankTableView.delegate = self
        BankTableView.dataSource = self
        BankTableView.RegisterNib(cell: BankCell.self)
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    func getPackageData() {
        
        Titlee.text = Model?.package_name
       
        AdsPrice.text = Model?.package_price
        AdsTime.text = Model?.package_duration_in_days
        desc.text = Model?.package_description
        
        if self.Model?.package_rate == "1" {
            
            self.StarRight.image = #imageLiteral(resourceName: "feature-1")
            self.StarLeft.image = #imageLiteral(resourceName: "feature-1")
            
        }
        
        if self.Model?.package_rate == "2" {
            
            self.StarRight.image = #imageLiteral(resourceName: "Blue-Star")
            self.StarLeft.image = #imageLiteral(resourceName: "Blue-Star")
        }
        
        if self.Model?.package_rate == "3" {
            
            self.StarRight.image = #imageLiteral(resourceName: "Gold-Star")
            self.StarLeft.image = #imageLiteral(resourceName: "Gold-Star")
            
        }
        
        
    }
    
    @IBAction func BankAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
}

extension SpecialChooseBanckVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BanksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue() as BankCell
        setShadow(view: cell, width: 1, height: 1, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.9552423358, green: 0.9655665755, blue: 0.9771843553, alpha: 1))
        
        if self.bankData{
            
            var Model = BanksArray[indexPath.row]
            cell.bankImage.loadImage(URL(string: Model.bank_account_logo ?? "" ))
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: StarAds, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "SpecialConfirmTransActionVC") as! SpecialConfirmTransActionVC
        vc.Model = self.Model
        vc.state = self.state
        vc.Adv_Id = self.Adv_Id
        vc.displayPlace = self.displayPlace
        vc.PaymentWay = self.PaymentWay
        vc.Package_id = Package_id
        vc.bankId = "\(BanksArray[indexPath.row].bank_account_id ?? 0)"
        self.navigationController?.pushViewController(vc, animated: true)
        
        return tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}


extension SpecialChooseBanckVC {
    
    func getPackageDetails() {
        
        
        self.view.lock()

        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)package/\(Package_id)") { (data : PackageModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.Titlee.text = data.data?.package_name ?? ""
                
            
                self.AdsPrice.text = data.data?.package_price ?? ""
                
                self.AdsTime.text = data.data?.package_duration_in_days ?? ""
                self.desc.text = data.data?.package_description ?? ""
                
                if self.Model?.package_rate == "1" {
                    
                    self.StarRight.image = #imageLiteral(resourceName: "feature-1")
                    self.StarLeft.image = #imageLiteral(resourceName: "feature-1")
                    
                }
                
                if self.Model?.package_rate == "2" {
                    
                    self.StarRight.image = #imageLiteral(resourceName: "Blue-Star")
                    self.StarLeft.image = #imageLiteral(resourceName: "Blue-Star")
                }
                
                if self.Model?.package_rate == "3" {
                    
                    self.StarRight.image = #imageLiteral(resourceName: "Gold-Star")
                    self.StarLeft.image = #imageLiteral(resourceName: "Gold-Star")
                    
                }
                
                
                
                print(data)
                
                
            }
        }
    }
    
    func getAllBank() {
        
        view.lock()
        self.LoadingView.isHidden = false
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)all-bank-accounts") { (data : AllBankModel?, String) in
            
            self.view.unlock()
            self.LoadingView.isHidden = true
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                self.view.unlock()
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.BanksArray = data.data ?? []
                self.bankData = true
                
                print(data.data)
                
                self.BankTableView.reloadData()
                
            }
        }
    }
    
}
