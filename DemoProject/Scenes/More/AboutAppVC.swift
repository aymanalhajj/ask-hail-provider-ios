//
//  AboutAppVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 10/31/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class AboutAppVC: UIViewController {

    @IBOutlet weak var TwxtView: UITextView!
    
    @IBOutlet var backGround: UIView!
    @IBOutlet weak var viewtitle: UILabel!
    
    @IBOutlet weak var Topview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        setShadow(view: Topview, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        backGround.backgroundColor = Colors.ViewBackGroundColoer
        if L102Language.currentAppleLanguage() == englishLang {
            viewtitle.text = "About App"
        }else {
            viewtitle.text = "عن التطبيق"
        }
        
        AboutUs()
        
        
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
    
}

extension AboutAppVC {
    
    func AboutUs() {
        self.view.lock()
        
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)fixed-page/about-app") { (data : FixedPagesModel?, String) in
            
            self.view.unlock()
            
            //  self.AdsCollectionVoew.showLoader()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                let style = NSMutableParagraphStyle()
                style.lineSpacing = 10
                let attributes = [NSAttributedString.Key.paragraphStyle : style]
                self.TwxtView.attributedText = NSAttributedString(string: data.data?.fixed_page_body?.html2String ?? "", attributes:attributes)
                self.TwxtView.textColor = Colors.DarkBlue
                self.TwxtView.font = UIFont(name: "Tajawal-Regular", size: 16)
                
                print(data)
                
                
            }
        }
    }
    
}
