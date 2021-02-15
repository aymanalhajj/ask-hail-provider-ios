//
//  RealStateAppVC.swift
//  AskHailBusiness
//
//  Created by bodaa on 25/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class RealStateAppVC: UIViewController {

    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var TempText: UITextView!
    @IBOutlet var TopBar: UIView!
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTerms()
                
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.8974673004, green: 0.911144314, blue: 0.922011104, alpha: 1))
        
        TempText.textColor = Colors.DarkBlue
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func BackAction(_ sender: Any) {
         
            guard let window = UIApplication.shared.keyWindow else{return}
            let sb = UIStoryboard(name: Home, bundle: nil)
            var vc : UIViewController
            vc = sb.instantiateViewController(withIdentifier: "HomeVC")
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        
    }
    @IBAction func RealStateAppAction(_ sender: Any) {
       
        openUrl(link: "https://apps.apple.com/eg/app/ask-hail/id1542462594")
        
    }
    
}


extension RealStateAppVC{
    
    func getTerms() {
        
        self.view.lock()
        
       ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)fixed-page/real-estate-app") { (data : FixedPagesModel?, String) in
        self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                let style = NSMutableParagraphStyle()
                style.lineSpacing = 10
                let attributes = [NSAttributedString.Key.paragraphStyle : style]
                self.TempText.attributedText = NSAttributedString(string: data.data?.fixed_page_body?.html2String ?? "", attributes:attributes)
                self.TempText.textColor = Colors.DarkBlue
                self.TempText.font = UIFont(name: "Tajawal-Regular", size: 16)
                
                
                print(data)
                
                
            }
        }
    }
    
}
