//
//  AppDelegate.swift
//  DemoProject
//
//  Created by MOHAB on 2/29/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import FirebaseMessaging
import UserNotifications
import GoogleMaps
import GooglePlaces
import Cosmos
import FirebaseDynamicLinks

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate  {
    
    var window: UIWindow?
    
    let gcmMessageIDKey = "gcm.message_id"
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        UIApplication.shared.statusBarStyle = .lightContent
        
        GMSServices.provideAPIKey("AIzaSyCwOy-NiunTQ7Q8D_d6eCUAeX2caw6oqQ0")
        GMSPlacesClient.provideAPIKey("AIzaSyCwOy-NiunTQ7Q8D_d6eCUAeX2caw6oqQ0")
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        registerForNotifications()
        
        if #available(iOS 10.0, *) {
            
            
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        L102Localizer.DoTheMagic()
        
        if Helper.getisFirst() == nil {
            
            Helper.SaveisFirst(token: "true")
            
            L102Language.setAppleLAnguageTo(lang: arabicLang)
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            
            
            
        }
        
        
        if L102Language.currentAppleLanguage() == arabicLang {
            
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UITabBar.appearance().semanticContentAttribute = .forceRightToLeft
            
        }else {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UITabBar.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
        
        
        
      
        
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore{
            var subscribeTopic = "business_advertisers_en"
            var unsubscribeTopic = "business_advertisers_ar"
            let languageKey = L102Language.currentAppleLanguage()
            if languageKey == "ar"{
                subscribeTopic = "business_advertisers_ar"
                unsubscribeTopic = "business_advertisers_en"
            }
            Messaging.messaging().unsubscribe(fromTopic: unsubscribeTopic)
            Messaging.messaging().subscribe(toTopic: subscribeTopic)
            
            
            
            var allsubscribeTopic = "all_advertisers_en"
            var allunsubscribeTopic = "all_advertisers_ar"
            
            if languageKey == "ar"{
                subscribeTopic = "all_advertisers_ar"
                unsubscribeTopic = "all_advertisers_en"
            }
            
            Messaging.messaging().unsubscribe(fromTopic: allunsubscribeTopic)
            Messaging.messaging().subscribe(toTopic: allsubscribeTopic)
            
            
        }
        
        
        
        return true
    }
    
    
    
    
    
    
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        let handled = DynamicLinks.dynamicLinks().handleUniversalLink(userActivity.webpageURL!) { (dynamiclink, error) in
            
            self.handleDynamicLink(dynamiclink: dynamiclink)
            
            // ...
        }
        
        return handled
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        
        
        
        
        
        
        return application(app, open: url,
                           sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                           annotation: "")
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) {
            // Handle the deep link. For example, show the deep-linked content or
            // apply a promotional offer to the user's account.
            // ...
            return true
        }
        return false
    }
    
    
    func handleDynamicLink(dynamiclink:DynamicLink?){
        if dynamiclink != nil{
            
            print(dynamiclink?.url)
            
            
      
           
            
            guard var dynamicUrl = dynamiclink?.url?.absoluteString else { return }
            print("dynamicUrldynamicUrl",dynamicUrl)
            
            if dynamicUrl.first == "1" {
                
                dynamicUrl.removeFirst()
                DynamicLinkModel.Product_id = dynamicUrl
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "BusinessAdsDetailsVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }else {
               
                dynamicUrl.removeFirst()
                DynamicLinkModel.Product_id = dynamicUrl
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "AskHailDetailsVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }
        
            
         
            
            
        }
    }
    
    func registerForNotifications() {
        // Register for notification: This will prompt for the user's consent to receive notifications from this app.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            
        }
    }
    
    func createBackgroundNotificationRequest() -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = "askHail"
        content.subtitle = "Just so you are aware."
        content.body = "We'll be waiting for you back in askHail"
        
        let request = UNNotificationRequest(identifier: "BackgroundNotification", content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: 200, repeats: false))
        
        return request
    }
    
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID2: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID3: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        
        ///You have a new trip request
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        let def = UserDefaults.standard
        def.setValue(token, forKey: "mobileToken")
        def.synchronize()
        Manager.DevicToken = token
        
        
        Messaging.messaging().apnsToken = deviceToken
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        
        var subscribeTopic = "business_advertisers_en"
        var unsubscribeTopic = "business_advertisers_ar"
        let languageKey = L102Language.currentAppleLanguage()
        if languageKey == "ar"{
            subscribeTopic = "business_advertisers_ar"
            unsubscribeTopic = "business_advertisers_en"
        }
        Messaging.messaging().unsubscribe(fromTopic: unsubscribeTopic)
        Messaging.messaging().subscribe(toTopic: subscribeTopic)
        
        
        
        var allsubscribeTopic = "all_advertisers_en"
        var allunsubscribeTopic = "all_advertisers_ar"
        
        if languageKey == "ar"{
            subscribeTopic = "all_advertisers_ar"
            unsubscribeTopic = "all_advertisers_en"
        }
        
        Messaging.messaging().unsubscribe(fromTopic: allunsubscribeTopic)
        Messaging.messaging().subscribe(toTopic: allsubscribeTopic)
        
        
        
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        
        print("When lock Screen")
        
        NotificationCenter.default.post(name: Notification.Name(Notification_lock_Screen), object: nil)
        
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("applicationDidEnterBackground")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
        NotificationCenter.default.post(name: Notification.Name(Notification_Unlock_Screen), object: nil)
        
        print("When Unlock Screen")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        NotificationCenter.default.post(name: Notification.Name(Notification_Unlock_Screen), object: nil)
        print("First Launch")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
        print("applicationWillTerminate")
        
    }
    
    // MARK: - Core Data stack
    
    
    
    
    
    
}


@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        guard Helper.getNotification() != "false" else {
            return
        }
        
        let userInfo = notification.request.content.userInfo
        
        print(userInfo)
        let dict = userInfo[AnyHashable("aps")] as! [String : Any]
        let al = dict["alert"] as? String
        
        print(al)
        
        let body = userInfo[AnyHashable("type")] as? String
        print(body)
        
        
        
        
        
        
        completionHandler([.sound , .alert])
    }
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
        print("didReceiveRemoteNotification")
        
        
        
    }
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        print("didReceiveRemoteNotification")
        
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let application = UIApplication.shared
        
        let userInfo = response.notification.request.content.userInfo
        
        print(userInfo)
        let dict = userInfo[AnyHashable("aps")] as! [String : Any]
        let al = dict["alert"] as? String
        
        print(al)
        
        let body = userInfo[AnyHashable("type")] as? String
        
        let type_id = userInfo[AnyHashable("type_id")] as? String
        print(body , type_id)
        
    
        
        //
        
        
        if(application.applicationState == .active){
            print("user tapped the notification bar when the app is in foreground")
            
            if body == "public" {
                
                print(body)
                
                //                guard let window = UIApplication.shared.keyWindow else{return}
                //                let sb = UIStoryboard(name: Chat, bundle: nil)
                //                var vc : UIViewControlle
                //
                //                vc = sb.instantiateViewController(withIdentifier: "inChatVCNav")
                //                window.rootViewController = vc
                //                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }else if body == "adv" {
                
                DynamicLinkModel.Product_id = type_id ?? ""
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "BusinessAdsDetailsVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }else if body == "subscription" {
                
                DynamicLinkModel.Product_id = type_id ?? ""
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: MyProfile, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "MyPackgeVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }else if body == "subscription" {
                
                DynamicLinkModel.Product_id = type_id ?? ""
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "StarAdDetailsVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }else if body == "special_subscription" {
                
                DynamicLinkModel.Product_id = type_id ?? ""
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "StarAdDetailsVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }else if body == "question" {
                
                DynamicLinkModel.Product_id = type_id ?? ""
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "AskDetailsVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }else if body == "chat" {
                
                DynamicLinkModel.Product_id = type_id ?? ""
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "chatV")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }
            
        }
        
        if(application.applicationState == .inactive)
        {
            print("user tapped the notification bar when the app is in backround")
            
            
            if body == "public" {
                
                print(body)
                
                //                guard let window = UIApplication.shared.keyWindow else{return}
                //                let sb = UIStoryboard(name: Chat, bundle: nil)
                //                var vc : UIViewControlle
                //
                //                vc = sb.instantiateViewController(withIdentifier: "inChatVCNav")
                //                window.rootViewController = vc
                //                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }else if body == "adv" {
                
                DynamicLinkModel.Product_id = type_id ?? ""
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "BusinessAdsDetailsVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }else if body == "subscription" {
                
                DynamicLinkModel.Product_id = type_id ?? ""
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: MyProfile, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "MyPackgeVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }else if body == "subscription" {
                
                DynamicLinkModel.Product_id = type_id ?? ""
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "StarAdDetailsVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }else if body == "special_subscription" {
                
                DynamicLinkModel.Product_id = type_id ?? ""
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "StarAdDetailsVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }else if body == "question" {
                
                DynamicLinkModel.Product_id = type_id ?? ""
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "AskDetailsVC")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }else if body == "chat" {
                
                DynamicLinkModel.Product_id = type_id ?? ""
                DynamicLinkModel.isDynamic = true
                guard let window = UIApplication.shared.keyWindow else{return}
                let sb = UIStoryboard(name: Home, bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "chatV")
                window.rootViewController = vc
                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                
            }
            
            
        }
        
        
        
        
        completionHandler()
    }
    
    
}


extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(fcmToken)")
        Helper.SaveFcmtoken(Fcmtoken: fcmToken)
        
    }
    
}



