//
//  AddNewPopUpVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/7/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import PMAlertController

protocol AddNewProtocl {
    func AddNew(status : Int)
}

class AddNewPopUpVC: UIViewController {
    
    var Delegate : AddNewProtocl?
    var Ad_id = ""
    var Order_id = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        
        showAnimate()
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        tabBarController?.tabBar.isHidden = false
        removeAnimate()
    }
    
    @IBAction func AddNewAdsAction(_ sender: Any) {
        tabBarController?.tabBar.isHidden = false
        CkeckIfHaveOldAds()
        
    }
    
    
    @IBAction func NewQuestion(_ sender: Any) {
        tabBarController?.tabBar.isHidden = false
        
        Delegate?.AddNew(status: 3)
        removeAnimate()
        
    }
    
    
}

//MARK:API Service

extension AddNewPopUpVC {

    
    func CkeckIfHaveOldAds() {
        self.view.lock()
        ApiServices.instance.getPosts(methodType: .post, parameters: nil , url: "\(hostName)business-add-advertisement/level1-check-last-not-completed-advertisement") { (data : Level_1_Model?, String) in
            
            self.view.unlock()
            if String != nil {
                
                self.Delegate?.AddNew(status: 1)
                self.removeAnimate()
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.removeAnimate()
                
                
                let alertVC = PMAlertController(title: "اعلان", description: data.message ?? "", image: nil, style: .alert)
                
                alertVC.addAction(PMAlertAction(title: "Complete now".localized, style: .default, action: { () -> Void in
                    
                    self.getAdvNewOrContinue(state: "continue")
                    
                    if data.data?.next_level == 2 {
                        
                        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "ChoseGradeVC") as! ChoseGradeVC
                        vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                        vc.isHome = 1
                        self.tabBarController?.tabBar.isHidden = true
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    } else if data.data?.next_level == 3 {
                        
                        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsPlaceTypeVC") as! AdsPlaceTypeVC
                        vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                        vc.isHome = 1
                        self.tabBarController?.tabBar.isHidden = true
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    } else if data.data?.next_level == 4 {
                        
                        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsAddPhotoVC") as! AdsAddPhotoVC
                        vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                        vc.isHome = 1
                        self.tabBarController?.tabBar.isHidden = true
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                    } else if data.data?.next_level == 5 {
                        
                        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsDetailsVC") as! AdsDetailsVC
                        vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                        vc.isHome = 1
                        self.tabBarController?.tabBar.isHidden = true
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                    } else if data.data?.next_level == 6 {
                        
                        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsContactNumberVC") as! AdsContactNumberVC
                        vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                        vc.isHome = 1
                        self.tabBarController?.tabBar.isHidden = true
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }else if data.data?.next_level == 7 {
                        
                        let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                        let vc  = storyboard.instantiateViewController(withIdentifier: "AdsSocialMediaVC") as! AdsSocialMediaVC
                        vc.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                        vc.isHome = 1
                        self.tabBarController?.tabBar.isHidden = true
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }
                    
                    print("Complete")
                }))
                
                alertVC.addAction(PMAlertAction(title:  "New one".localized, style: .default, action: { () in
                    self.getAdvNewOrContinue(state: "new")
                    self.Delegate?.AddNew(status: 1)
                    self.removeAnimate()
                    print("Complite now")
                }))
                
                alertVC.addAction(PMAlertAction(title:  "Cancel".localized, style: .cancel, action: { () in
                    
                }))
                
                self.present(alertVC, animated: true, completion: nil)
                
                print(data)
                

            }
        }
        
    }


    
    func getAdvNewOrContinue(state : String) {
        
        let Parameters = [
            "desire" : state
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)business-add-advertisement/choose-continue-or-new") { (data : Level_1_Model?, String) in
            
            if String != nil {
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.Ad_id = "\(data.data?.advertisement_id ?? 0)"
                
                print(data)
                
            }
        }
    }
}


