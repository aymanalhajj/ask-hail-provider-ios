//
//  AdsSocialMediaVC.swift
//  AskHailBusiness
//
//  Created by Abdulaah Tarek on 03/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit

class AdsSocialMediaVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var FaceBookTf: UITextField!
    @IBOutlet weak var FaceBookImage: UIImageView!
    @IBOutlet weak var FaceBookLineView: UIView!
    
    @IBOutlet weak var SnapChatTf: UITextField!
    @IBOutlet weak var SnapChatImage: UIImageView!
    @IBOutlet weak var SnapChatLineView: UIView!
    
    @IBOutlet weak var InstgrameTf: UITextField!
    @IBOutlet weak var InstgrameImage: UIImageView!
    @IBOutlet weak var InstgrameLineView: UIView!
    
    @IBOutlet weak var TwitterTf: UITextField!
    @IBOutlet weak var TwitterImage: UIImageView!
    @IBOutlet weak var TwitterLineView: UIView!
    
    @IBOutlet weak var WebSiteTf: UITextField!
    @IBOutlet weak var WebSiteImage: UIImageView!
    @IBOutlet weak var WebSiteLineView: UIView!
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    var Ad_id = ""
    
    var isHome = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FaceBookTf.delegate = self
        SnapChatTf.delegate = self
        InstgrameTf.delegate = self
        TwitterTf.delegate = self
        WebSiteTf.delegate = self
        
        
        FaceBookTf.placeHolderColor = Colors.PlaceHolderColoer
        SnapChatTf.placeHolderColor = Colors.PlaceHolderColoer
        InstgrameTf.placeHolderColor = Colors.PlaceHolderColoer
        TwitterTf.placeHolderColor = Colors.PlaceHolderColoer
        WebSiteTf.placeHolderColor = Colors.PlaceHolderColoer
        
        FaceBookTf.setPadding(left: 16, right: 16)
        SnapChatTf.setPadding(left: 16, right: 16)
        InstgrameTf.setPadding(left: 16, right: 16)
        TwitterTf.setPadding(left: 16, right: 16)
        WebSiteTf.setPadding(left: 16, right: 16)
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        if isHome == 0 {
            navigationController?.popViewController(animated: true)
        }
        else{
            guard let window = UIApplication.shared.keyWindow else{return}
            let sb = UIStoryboard(name: Home, bundle: nil)
            var vc : UIViewController
            vc = sb.instantiateViewController(withIdentifier: "HomeVC")
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        }
    }
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        AddSocialMedia()
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == FaceBookTf {
            
            EnableLineAnimite(text: FaceBookTf, ImageView: FaceBookImage, imageEnable: #imageLiteral(resourceName: "social_facebook"), lineView: FaceBookLineView, ishidden: false)
            
        } else if textField == InstgrameTf {
            
            EnableLineAnimite(text: InstgrameTf, ImageView: InstgrameImage, imageEnable: #imageLiteral(resourceName: "social_instagram"), lineView: InstgrameLineView, ishidden: false)
            
        } else if textField == SnapChatTf {
            EnableLineAnimite(text: SnapChatTf, ImageView: SnapChatImage, imageEnable: #imageLiteral(resourceName: "social_snapchat"), lineView: SnapChatLineView, ishidden: false)
        } else if textField == WebSiteTf {
            EnableLineAnimite(text: WebSiteTf, ImageView: WebSiteImage, imageEnable: #imageLiteral(resourceName: "social_website"), lineView: WebSiteLineView, ishidden: false)
        }else if textField == TwitterTf {
            EnableLineAnimite(text: TwitterTf, ImageView: TwitterImage, imageEnable: #imageLiteral(resourceName: "social_twitter"), lineView: TwitterLineView, ishidden: false)
        }
        return true;
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text == "" {
            if textField == FaceBookTf {
                EnableLineAnimite(text: FaceBookTf, ImageView: FaceBookImage, imageEnable: #imageLiteral(resourceName: "social_facebook"), lineView: FaceBookLineView, ishidden: false)
            } else if textField == InstgrameImage {
                
                EnableLineAnimite(text: InstgrameTf, ImageView: InstgrameImage, imageEnable: #imageLiteral(resourceName: "social_instagram"), lineView: InstgrameLineView, ishidden: false)
                
            } else if textField == SnapChatTf {
                EnableLineAnimite(text: SnapChatTf, ImageView: SnapChatImage, imageEnable: #imageLiteral(resourceName: "social_snapchat"), lineView: SnapChatLineView, ishidden: false)
            } else if textField == WebSiteTf {
                EnableLineAnimite(text: WebSiteTf, ImageView: WebSiteImage, imageEnable: #imageLiteral(resourceName: "social_website"), lineView: WebSiteLineView, ishidden: false)
            }else if textField == TwitterTf {
                EnableLineAnimite(text: TwitterTf, ImageView: TwitterImage, imageEnable: #imageLiteral(resourceName: "social_twitter"), lineView: TwitterLineView, ishidden: false)
            }
            
        }
        
        return true;
    }
    
}


//MARK:-API

extension AdsSocialMediaVC {
    
    func AddSocialMedia() {
        
        self.view.lock()
        
        var Parameters = [
            "advertisement_id": Ad_id,
            "twitter" : TwitterTf.text ?? "",
            "instagram" : InstgrameTf.text ?? "",
            "snapchat" : SnapChatTf.text ?? "",
            "facebook" : FaceBookTf.text ?? "",
            "website" : WebSiteTf.text ?? ""
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject], url: "\(hostName)business-add-advertisement/level7-add-social-links") { (data : Level_6_Model?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }

                let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "AdsSuccessAddVC") as! AdsSuccessAddVC
                vc.Ad_Id = self.Ad_id
                vc.Message = data.data ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
                
                print(data)
                
                
            }
        }
    }
    
}
