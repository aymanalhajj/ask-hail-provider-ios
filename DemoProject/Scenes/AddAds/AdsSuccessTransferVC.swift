//
//  SuccessTransferVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/7/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

var IsNew = 0
var type = 0


class AdsSuccessTransferVC: UIViewController {
    
    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var BAckToBtn: UIButton!
    @IBOutlet weak var desTitle: UILabel!
    
    var Adv_Id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ChackBackWay()
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    
    func ChackBackWay() {
        
        if IsNew == 0 {
            
            BAckToBtn.setTitle("Back to add ad".localized, for: .normal)
            desTitle.text = "The transfer will be confirmed by the administration. You can return to continue publishing the advertisement.".localized
            
        } else if IsNew == 1 {
            
            BAckToBtn.setTitle("Back to add ad".localized, for: .normal)
            desTitle.text = "The transfer will be confirmed by the administration.".localized
            
        }else if IsNew == 2 {
            
            BAckToBtn.setTitle("Back to my packages page".localized, for: .normal)
            desTitle.text = "The transfer will be confirmed by the administration.".localized
            
        }
        
    }
    @IBAction func BackToPlaceTypeAction(_ sender: Any) {
        
        if IsNew == 0 {
            
            let storyboard = UIStoryboard(name: AddAds, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "AdsPlaceTypeVC") as! AdsPlaceTypeVC
            vc.isHome = 1
            vc.Ad_id = Adv_Id
            navigationController?.pushViewController(vc, animated: true)
            
        }else if IsNew == 1{
            
            if type == 1 {
                navigationController?.popToViewController(ofClass: MyAdsDetailsVC.self)
            } else if type == 2{
                navigationController?.popToViewController(ofClass: MyPackgeVC.self)
            }
        }
    }
    
    
}
