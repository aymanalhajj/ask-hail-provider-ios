//
//  ShowAlert.swift
//  DemoProject
//
//  Created by MOHAB on 2/29/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import Kingfisher
import AudioToolbox
//import StatusAlert
import LXStatusAlert
import UIView_Shake
import AJMessage


extension UIViewController : UIGestureRecognizerDelegate {
    
    func alert(msg:String) {
        
        let alert = UIAlertController(title: "", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func isNotEmptyString(text: String, withAlertMessage message: String) -> Bool{
        if text == ""{
           
              AJMessage(title: "Error", message: message , status : .error ).show()
            self.view.shake()

            return false
        }
        else{
            return true
        }
    }
    func showStatus(image: UIImage , message: String){
        //        let statusAlert = StatusAlert()
        //        statusAlert.image = image
        //        statusAlert.title = title
        //        statusAlert.message = message
        ////        statusAlert.canBePickedOrDismissed = isUserInteractionAllowed
        //        statusAlert.canBePickedOrDismissed = true
        //        statusAlert.showInKeyWindow()
        let statusAlert = LXStatusAlert(image: image, title:message, duration: 3.0)
        statusAlert.show()
        
    }
    func alertSkipLogin(){
        let alert = UIAlertController.init(title: "Warning" , message: "please login first" ,  preferredStyle: .alert)
      alert.view.tintColor = Colors.DarkBlue
        
        
        let OkBtn = UIAlertAction.init(title: "Ok", style: .default, handler: { (nil) in
            guard let window = UIApplication.shared.keyWindow else{return}
            let sb = UIStoryboard(name: Authontication, bundle: nil)
            var vc : UIViewController
            vc = sb.instantiateViewController(withIdentifier: "WelcomeVC")
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        })
        let Cancel = UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.destructive, handler: { (nil) in
         
            
        })
       
        
        
        alert.addAction(OkBtn)
    
        
        alert.addAction(Cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func setShadow(view : UIView , width : Int , height: Int , shadowRadius: CGFloat , shadowOpacity: Float , shadowColor: CGColor){
        // to make the shadow with rounded corners and offset shadow form the bottom
        view.layer.shadowColor = shadowColor
        view.layer.shadowOffset = CGSize(width: width, height: height)
        view.layer.shadowRadius = shadowRadius
        view.layer.shadowOpacity = shadowOpacity
        view.clipsToBounds = true
        view.layer.masksToBounds = false
    }
    func setShadowButton(view : UIView , width : Int , height: Int , shadowRadius: CGFloat , shadowOpacity: Float , shadowColor: CGColor){
        // to make the shadow with rounded corners and offset shadow form the bottom
        view.layer.shadowColor = shadowColor
        view.layer.shadowOffset = CGSize(width: width, height: height)
        view.layer.shadowRadius = shadowRadius
        view.layer.shadowOpacity = shadowOpacity
        view.clipsToBounds = true
        view.layer.masksToBounds = true
    }
    enum Vibration {
        case error
        case success
        case warning
        case light
        case medium
        case heavy
        case selection
        case oldSchool
        func vibrate() {
            
            switch self {
            case .error:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
                
            case .success:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                
            case .warning:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.warning)
                
            case .light:
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
                
            case .medium:
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
                
            case .heavy:
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
                
            case .selection:
                let generator = UISelectionFeedbackGenerator()
                generator.selectionChanged()
                
            case .oldSchool:
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            
        }
        
    }
    func showAlertWithTitle(title: String, message: String, type: Vibration) {
    
        if type == .error {
             AJMessage(title: title, message: message , status : .error ).show()
        
        }else if type == .success {
            
              AJMessage(title: title, message: message , status : .success ).show()
        }else if type == .warning {
              AJMessage(title: title, message: message , status : .info ).show()
            
        }
        
      
     
        
        
        let attach = NSTextAttachment()
//attach.image = #imageLiteral(resourceName: "Unknown-1")
        
        if type == .error{
            self.view.shake()
        }
    }
 
    
        func changeLanguage() {
            let transition: UIView.AnimationOptions = .transitionCrossDissolve
    
            if L102Language.currentAppleLanguage() == englishLang {
                L102Language.setAppleLAnguageTo(lang: arabicLang)
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
            } else {
                L102Language.setAppleLAnguageTo(lang: englishLang)
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
            }
    
            let storyBoard: UIStoryboard = UIStoryboard.init(name: Home, bundle: nil)
    
    
            let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
            rootviewcontroller.rootViewController = storyBoard.instantiateViewController(withIdentifier: "MainTabBarVC")
            let mainwindow = (UIApplication.shared.delegate?.window!)!
            mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
            UIView.transition(with: mainwindow, duration: 0.55001, options: transition, animations: { () -> Void in
            }) { (finished) -> Void in
    
            }
        }
    
    func performSegueTo(storyBoard: storyBoardName, vc: storyBoardVCIDs) {
        let sb = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        let vcNew = sb.instantiateViewController(withIdentifier: vc.rawValue)
        self.navigationController?.pushViewController(vcNew, animated: true)
        //        show(vcNew, sender: self)
        
    }
    
    
    
}
extension UIScreen {
    var minEdge: CGFloat {
        return UIScreen.main.bounds.minEdge
    }
}
extension CGRect {
    var minEdge: CGFloat {
        return min(width, height)
    }
}
extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
