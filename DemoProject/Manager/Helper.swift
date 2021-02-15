//
//  Helper.swift
//  DemoProject
//
//  Created by MOHAB on 2/29/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation

import UIKit

class Helper: NSObject {
    
    // Save Api Token
    
    class func api_toket()->String {
        let api_token = "token"
        return api_token
    }
    
    class func SaveApitoken(token : String?){
        let def = UserDefaults.standard
        def.setValue(token, forKey: api_toket())
        def.synchronize()
    }
    
    class func getapitoken()->String? {
        let def = UserDefaults.standard
        return def.object(forKey: api_toket()) as? String
    }
    
    
    // Save isFirst
  
    class func isFirst()->String {
        let api_token = "isFirst"
        return api_token
    }
    
    class func SaveisFirst(token : String?){
        let def = UserDefaults.standard
        def.setValue(token, forKey: isFirst())
        def.synchronize()
    }
    
    class func getisFirst()->String? {
        let def = UserDefaults.standard
        return def.object(forKey: isFirst()) as? String
    }
    
    
    // save user name
    
    class func user_name()->String {
        let user_name = "name"
        return user_name
    }
    
    class func Saveuser_namen(name : String?){
        let def = UserDefaults.standard
        def.setValue(name, forKey: user_name())
        def.synchronize()
    }
    
    class func getaUser_name()->String? {
        let def = UserDefaults.standard
        return def.object(forKey: user_name()) as? String
    }
    

    //save user id
    
    class func user_id()->String {
        
        let user_id = "user_id"
        return user_id
    }
    
    class func Saveuser_id(user_id : String?){
        let def = UserDefaults.standard
        def.setValue(user_id, forKey: self.user_id())
        def.synchronize()
    }
    
    class func getaUser_id()->String? {
        let def = UserDefaults.standard
        return def.object(forKey: user_id()) as? String
    }
    
    
    //User notification
    
    class func user_notification()->String {
        let user_notification = "user_notification"
        return user_notification
    }
    
    class func Saveuser_notification(notification : String?){
        let def = UserDefaults.standard
        def.setValue(notification, forKey: user_notification())
        def.synchronize()
    }
    
    class func getNotification()->String? {
        
        let def = UserDefaults.standard
        return def.object(forKey: user_notification()) as? String
        
    }
    
    
    //save user Wallet
    
    class func user_Wallet()->String {
        let user_Wallet = "Wallet"
        return user_Wallet
    }
    
    class func Saveuser_Wallet(Wallet : String?){
        let def = UserDefaults.standard
        def.setValue(Wallet, forKey: user_Wallet())
        def.synchronize()
    }
    
    class func getWallet()->String? {
        let def = UserDefaults.standard
        return def.object(forKey: user_Wallet()) as? String
    }
    
    
    //save user image
    
    class func user_image()->String {
        let user_image = "Profileimage"
        return user_image
    }
    
    class func Saveuser_Image(image : String?){
        let def = UserDefaults.standard
        def.setValue(image, forKey: user_image())
        def.synchronize()
    }
    
    class func getauser_Image()->String? {
        
        let def = UserDefaults.standard
        return def.object(forKey: user_image()) as? String
        
    }
    
    
    //save user email
    
    class func user_email()->String {
        let user_email = "email"
        return user_email
    }
    
    class func Saveuser_Email(email : String?){
        let def = UserDefaults.standard
        def.setValue(email, forKey: user_email())
        def.synchronize()
    }
    
    class func getauser_Email()->String? {
        let def = UserDefaults.standard
        return def.object(forKey: user_email()) as? String
    }
    
    
    // MARK: save user phone
    
    class func user_Phone()->String {
        let user_Phone = "phone"
        return user_Phone
    }
    
    class func Saveuser_phone(phone : String?){
        let def = UserDefaults.standard
        def.setValue(phone, forKey: user_Phone())
        def.synchronize()
    }
    
    class func getauser_Phone()->String? {
        let def = UserDefaults.standard
        return def.object(forKey: user_Phone()) as? String
    }
    
    
    // MARK: save firebase token
    
    class func Fcm_toket()->String {
        let Fcm_token = "Fcmtoken"
        return Fcm_token
    }
    
    class func SaveFcmtoken(Fcmtoken : String?){
        let def = UserDefaults.standard
        def.setValue(Fcmtoken, forKey: Fcm_toket())
        def.synchronize()
    }
    
    class func getFcmtoken()->String? {
        let def = UserDefaults.standard
        return def.object(forKey: Fcm_toket()) as? String
    }
    
    
    // MARK: save user id package
    
    class func Package_Id()->String {
        let Package_Id = "PackageId"
        return Package_Id
    }
    
    class func SavePackage_Id(PackageId : String?){
        let pId = UserDefaults.standard
        pId.setValue(PackageId, forKey: Package_Id())
        pId.synchronize()
    }
    
    class func getPackage_Id()->String? {
        let pId = UserDefaults.standard
        return pId.object(forKey: Package_Id()) as? String
    }
    
    // MARK: Lat
        
        class func User_lat()->String {
            let User_lat = "User_lat"
            return User_lat
        }
        
        class func SaveUser_lat(phone : String?){
            let def = UserDefaults.standard
            def.setValue(phone, forKey: User_lat())
            def.synchronize()
        }
        
        class func getUser_lat()->String? {
            let def = UserDefaults.standard
            return def.object(forKey: User_lat()) as? String
        }
        // MARK: Lng
        
        class func User_Lng()->String {
            let User_lat = "User_Lng"
            return User_lat
        }
        
        class func SaveUser_Lng(phone : String?){
            let def = UserDefaults.standard
            def.setValue(phone, forKey: User_Lng())
            def.synchronize()
        }
        
        class func getUser_Lng()->String? {
            let def = UserDefaults.standard
            return def.object(forKey: User_Lng()) as? String
        }
    
    
    //MARK: Save Chat Type
    class func Chat_State()->String {
        let Package_Id = "ChatState"
        return Package_Id
    }
    
    class func SaveChatType(ChatState : String?){
        let pId = UserDefaults.standard
        pId.setValue(ChatState, forKey: Chat_State())
        pId.synchronize()
    }
    
    class func getChateType()->String? {
        let pId = UserDefaults.standard
        return pId.object(forKey: Chat_State()) as? String
    }
    
    class func restartApp(_ id : String){
        
        guard let window = UIApplication.shared.keyWindow else{return}
        let sb = UIStoryboard(name: Home, bundle: nil)
        var vc : UIViewController
        vc = sb.instantiateViewController(withIdentifier: "HomeVC")
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        
    }
    
    
}
