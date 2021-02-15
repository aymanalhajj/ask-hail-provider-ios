//
//  StopedAdvVC.swift
//  AskHail
//
//  Created by bodaa on 11/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class StopedAdvVC: UIViewController {
    
    @IBOutlet weak var AdvTableView: UITableView!
    
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet var BackGround: UIView!
    
    var MyAdvArray : [StopedAdvData] = []
    var AdvData = false
    
    override func viewWillAppear(_ animated: Bool) {
        
        getStopedAdv()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        AdvTableView.backgroundColor = Colors.ViewBackGroundColoer
        tabBarController?.tabBar.isHidden = true
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        AdvTableView.delegate = self
        AdvTableView.dataSource = self
        
        AdvTableView.RegisterNib(cell: SubAdsCell.self)
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    
    @IBAction func BackAction(_ sender: Any) {
        tabBarController?.tabBar.isHidden = false
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func ActiveAllAction(_ sender: Any) {
        
        ActiveAllAdv()
        
    }
    
    
}

extension StopedAdvVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        MyAdvArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue() as SubAdsCell
        
        if AdvData {
            
            cell.DeActiveBtn.isHidden = false
            
            let Model = MyAdvArray[indexPath.row]
            
            cell.ImagesUrl = Model.adv_media ?? []
            cell.pageControl.numberOfPages =  Model.adv_media?.count ?? 0
            cell.PagerView.reloadData()
            cell.name.text = Model.adv_title
            cell.Price.text = Model.adv_price
            cell.distance.text = Model.adv_distance
            cell.ViewsNumber.text = Model.adv_views
            
            cell.SaveBtn.isHidden = true
            
            if cell.ImagesUrl.count > 1 {
                cell.pageControl.isHidden = false
            }else{
                cell.pageControl.isHidden = true
            }
            
            cell.DeActive = {
                
                let storyboard = UIStoryboard(name: EditAds_Story , bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "DisableAdsPopUpVC") as! DisableAdsPopUpVC
                vc.Ad_id = Model.adv_id ?? 0
                vc.enable = 1
                vc.modalPresentationStyle = .fullScreen
                self.addChild(vc)
                vc.view.frame = self.view.frame
                self.view.addSubview(vc.view)
                vc.didMove(toParent: self)

            }
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        return AdvTableView.deselectRow(at: indexPath, animated: true)
        
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
    
}


extension StopedAdvVC {
    
    func getStopedAdv() {
        
        DispatchQueue.main.async {
            
            self.AdvTableView.layoutIfNeeded()
            self.AdvTableView.showLoader()
            
        }
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)business/my-blocked-advertisements") { (data : StopedAdvModel?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.AdvTableView.hideLoader()
                self.MyAdvArray = data.data ?? []
                self.AdvData = true
                self.AdvTableView.reloadData()
                
                if self.MyAdvArray.count == 0 {
                    
                    self.navigationController?.popToViewController(ofClass: HomeVC.self)

                }
                
               
                
                print(data)
                
            }
        }
    }
    
    
    func DeActioveAdv(id : Int) {
        
        let Parameters = [
            
            "advertisement_id" : id,
            "status" : "active"
            
        ] as [String : Any]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)business/active-or-block-advertisement") { (data : RealEstateShotModel?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.getStopedAdv()
                
                self.navigationController?.view.makeToast("\(data.data ?? "")")
                print(data)
                
            }
        }
    }
    
    func ActiveAllAdv() {
        
        ApiServices.instance.getPosts(methodType: .post, parameters: nil , url: "\(hostName)business/business/active-all-advertisements") { (data : RealEstateShotModel?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.navigationController?.popToViewController(ofClass: MyAdsVC.self)
                
                print(data)
                
            }
        }
    }
    
}
