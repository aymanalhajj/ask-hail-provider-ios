//
//  MyInfoVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/14/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class MyInfoVC: UIViewController {

    @IBOutlet var BackGround: UIView!
    
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet weak var View1: UIView!
    
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        setShadow(view: View1 , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        UserName.text = Helper.getaUser_name()
        Email.text = Helper.getauser_Email()
        phoneNumber.text = Helper.getauser_Phone()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func EditInfoAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: MyProfile, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "EditMyInfoVC") as! EditMyInfoVC
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func EditPasswordAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: MyProfile, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "EditPasswordVC") as! EditPasswordVC
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    

}


