//
//  ServicesVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/2/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class ServicesVC: UIViewController {
    
    
    var status = "Contracts"
    
    @IBOutlet var BackGround: UIView!
    
    @IBOutlet weak var TopBar: UIView!
    
    @IBOutlet weak var LeasecontractsView: UIView!
    @IBOutlet weak var LeasecontractsBtn: UIButton!

    @IBOutlet weak var ContractsView: UIView!
    @IBOutlet weak var ContractsBtn: UIButton!
    
    @IBOutlet weak var OtherBtn: UIButton!
    @IBOutlet weak var OtherView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var ServicesArray : [ServicesData] = []
    var ServicesData = false
    var currentPg = ["contracts","rent-contracts","others"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        setShadow(view: tableView, width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        BackGround.backgroundColor =  Colors.ViewBackGroundColoer
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.RegisterNib(cell: ContractCell.self)
        
        ContractsView.roundCorners(.topLeft, radius: 4)
        ContractsView.roundCorners(.topRight, radius: 4)
        OtherView.roundCorners(.topLeft, radius: 4)
        OtherView.roundCorners(.topRight, radius: 4)
        LeasecontractsView.roundCorners(.topLeft, radius: 4)
        LeasecontractsView.roundCorners(.topRight, radius: 4)
        
        
        defaultView()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    func defaultView() {
        
        getServices(page_id: "contracts")
        ContractsView.isHidden = false
        
        ContractsView.backgroundColor = UIColor(hexString: "#39CDEE")
        ContractsBtn.setTitleColor(#colorLiteral(red: 0.007843137255, green: 0.2901960784, blue: 0.5333333333, alpha: 1) , for: .normal)
        OtherView.isHidden = true
        OtherBtn.setTitleColor(#colorLiteral(red: 0.007843137255, green: 0.2901960784, blue: 0.5333333333, alpha: 0.5)  , for: .normal)
        LeasecontractsView.isHidden = true
        LeasecontractsBtn.setTitleColor(#colorLiteral(red: 0.007843137255, green: 0.2901960784, blue: 0.5333333333, alpha: 0.5) , for: .normal)

        status = "Contracts"
        
    }
    
    
    @IBAction func ContractsBtnPressed(_ sender: Any) {
        defaultView()
    }
    
    
    @IBAction func OtherBtnPressed(_ sender: Any) {
        
        getServices(page_id: "other")
        
        OtherView.isHidden = false

        ContractsView.isHidden = true
        ContractsBtn.setTitleColor(#colorLiteral(red: 0.007843137255, green: 0.2901960784, blue: 0.5333333333, alpha: 0.5) , for: .normal)
        LeasecontractsView.isHidden = true
        LeasecontractsBtn.setTitleColor(#colorLiteral(red: 0.007843137255, green: 0.2901960784, blue: 0.5333333333, alpha: 0.5) , for: .normal)
        
        
        OtherView.backgroundColor = UIColor(hexString: "#39CDEE")
        OtherBtn.setTitleColor(#colorLiteral(red: 0.007843137255, green: 0.2901960784, blue: 0.5333333333, alpha: 1) , for: .normal)
        status = "Other"
        
        
    }
    
    
    @IBAction func LeasecontractsBtnPressed(_ sender: Any) {
        
        getServices(page_id: "rental_contracts")
        
        LeasecontractsView.isHidden = false
        

        ContractsView.isHidden = true
        ContractsBtn.setTitleColor(#colorLiteral(red: 0.007843137255, green: 0.2901960784, blue: 0.5333333333, alpha: 0.5) , for: .normal)
        OtherView.isHidden = true
        OtherBtn.setTitleColor(#colorLiteral(red: 0.007843137255, green: 0.2901960784, blue: 0.5333333333, alpha: 0.5) , for: .normal)
        
        
        LeasecontractsView.backgroundColor = UIColor(hexString: "#39CDEE")
        LeasecontractsBtn.setTitleColor(#colorLiteral(red: 0.007843137255, green: 0.2901960784, blue: 0.5333333333, alpha: 1) , for: .normal)
        status = "Leasecontracts"
        
    }
    
    
    @IBAction func BackAction(_ sender: Any) {
        
        guard let window = UIApplication.shared.keyWindow else{return}
        let sb = UIStoryboard(name: Home, bundle: nil)
        var vc : UIViewController
        vc = sb.instantiateViewController(withIdentifier: "HomeVC")
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        
    }
    
    
}
extension ServicesVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return ServicesArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as ContractCell
        
        if ServicesData {
            
            var Model = ServicesArray[indexPath.row]
            
            cell.contreactTitle.text = Model.service_title ?? ""
            cell.Date.text = Model.service_custom_added_date ?? ""
            
            if (ServicesArray.count-1) == indexPath.row {
                cell.LineView.isHidden = true
            }
            
            cell.DownloadFile = {
                
                self.downloadFileFromURL(url: URL(string: Model.service_file ?? "") as! NSURL)
                
            }
            
        }
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        return tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension ServicesVC {
    
    func getServices(page_id : String) {
        
        self.view.lock()

        print("\(hostName)services/\(page_id)")
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)services/\(page_id)") { (data : ServicesModel?, String) in
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.ServicesArray = data.data ?? []
                self.ServicesData = true
                
                self.tableView.reloadData()

                print(data)
                
                
            }
        }
    }
    
}
