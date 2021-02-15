//
//  TempVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/1/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class TempVC: UIViewController {

    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var TempText: UITextView!
    @IBOutlet var TopBar: UIView!
    @IBOutlet weak var TermsTextView: UITextView!
    
    var isCreateAccount = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTerms()
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        TempText.textColor = Colors.DarkBlue
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    
    @IBAction func BackAction(_ sender: Any) {
        
        if isCreateAccount == true {
            
            navigationController?.popViewController(animated: true)
            isCreateAccount = false
        }else{
         
            guard let window = UIApplication.shared.keyWindow else{return}
            let sb = UIStoryboard(name: Home, bundle: nil)
            var vc : UIViewController
            vc = sb.instantiateViewController(withIdentifier: "HomeVC")
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        }
        
    }
    
}


extension TempVC{
    
    func getTerms() {
        
        self.view.lock()
        
       ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)fixed-page/terms-and-conditions") { (data : FixedPagesModel?, String) in
        self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
               self.view.unlock()
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                let style = NSMutableParagraphStyle()
                style.lineSpacing = 10
                let attributes = [NSAttributedString.Key.paragraphStyle : style]
                self.TermsTextView.attributedText = NSAttributedString(string: data.data?.fixed_page_body?.html2String ?? "", attributes:attributes)
                self.TermsTextView.textColor = Colors.DarkBlue
                self.TermsTextView.font = UIFont(name: "Tajawal-Regular", size: 16)
                
                print(data)
                
                
            }
        }
    }
    
}
