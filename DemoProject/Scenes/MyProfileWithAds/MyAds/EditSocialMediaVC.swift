//
//  EditSocialMediaVC.swift
//  AskHailBusiness
//
//  Created by bodaa on 06/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit

class EditSocialMediaVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var MainView: UIScrollView!
    
    @IBOutlet weak var FaceBookTf: UITextField!
    @IBOutlet weak var FaceBookImage: UIImageView!
    @IBOutlet weak var FaceBookLineView: UIView!
    @IBOutlet weak var FaceBookView: UIView!
    
    @IBOutlet weak var SnapChatTf: UITextField!
    @IBOutlet weak var SnapChatImage: UIImageView!
    @IBOutlet weak var SnapChatLineView: UIView!
    @IBOutlet weak var SnapChatView: UIView!
    
    @IBOutlet weak var InstgrameTf: UITextField!
    @IBOutlet weak var InstgrameImage: UIImageView!
    @IBOutlet weak var InstgrameLineView: UIView!
    @IBOutlet weak var InstgrameView: UIView!
    
    @IBOutlet weak var TwitterTf: UITextField!
    @IBOutlet weak var TwitterImage: UIImageView!
    @IBOutlet weak var TwitterLineView: UIView!
    @IBOutlet weak var TwitterView: UIView!
    
    @IBOutlet weak var WebSiteTf: UITextField!
    @IBOutlet weak var WebSiteImage: UIImageView!
    @IBOutlet weak var WebSiteLineView: UIView!
    @IBOutlet weak var WebSiteView: UIView!
    
    
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet var BackGround: UIView!
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    var Ad_id = ""
    
    var isHome = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetSocialMedia()
        
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
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        
        setShadow(view: TwitterView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: InstgrameView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: SnapChatView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: FaceBookView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: WebSiteView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))

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

extension EditSocialMediaVC {
    
    func GetSocialMedia() {
        
        self.MainView.isHidden = true
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)business-update-advertisement/edit-social-links?advertisement_id=\(Ad_id)") { (data : EditSocialMediaModel?, String) in
            
            self.MainView.isHidden = false
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.TwitterTf.text = data.data?.adv_twitter ?? ""
                self.InstgrameTf.text = data.data?.adv_instagram ?? ""
                self.SnapChatTf.text = data.data?.adv_snapchat ?? ""
                self.FaceBookTf.text = data.data?.adv_facebook ?? ""
                self.WebSiteTf.text = data.data?.adv_website ?? ""
                
                self.view.unlock()
                
                print(data)
                
            }
        }
    }
    
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
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject], url: "\(hostName)business-update-advertisement/update-social-links") { (data : SuccessEditSectionModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }

                self.navigationController?.popViewController(animated: true)
                self.navigationController?.view.makeToast("\(data.data?.message ?? "")")
                
                print(data)
                
                
            }
        }
    }
    
}
