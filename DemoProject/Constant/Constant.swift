//
//  Constant.swift
//  DemoProject
//
//  Created by MOHAB on 2/29/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

let arabicLang = "ar"
let englishLang = "en"


let Authontication = "Auth"
let Home = "MainAndAds"
let More = "More"
let Order = "OrederAndAddOreder"
let BusinessAds = "BusinessAds"
let AddAds = "AddAds"
let AddAskHail = "AddAskHail"
let AskHail = "MainAndAds"
let MyProfile = "MyProfileWithMyAds"
let StarAds = "StarAds"
let Notification_Stry = "Notification"
let EditAds_Story = "EditAds"
let EditOrder_srory = "EditOrder"
let Chat = "MainAndAds"
let EditAsk_story = "EditAsk"


let NotificationCenterpreeHome = "preeHome"
let NotificationCenterpreePlusBtn = "preePlusBtn"
let NotificationCenterpreeMore = "preeMore"
let NotificationCenterpreeMoreAppear = "preeMoreAppear"
let NotificationCenterpreeAskHail = "preeAskHail"
let NotificationCenterpreesChat = "preesChat"
let NotificationCenterpressHome = "pressHome"
let NotificationCenterpressHomeLast = "pressHomeLast"
let AskHailNotification = "AskNotification"
let ChatNotification = "ChatNotification"
let NotificationCenterpressChat = "preeChat"


let Notification_Unlock_Screen = "Unlock_Screen"
let Notification_lock_Screen = "lock_Screen"


let Notification_Determine_time = "Determine_Time"
let Notification_Pay_time = "SelectBalance"
let Currency = "دينار"


let GoogleKey = "AIzaSyBY08SqhqCzeLdDgeK2_zeOh4ikGQr7R9E"



let appDelegate = UIApplication.shared.delegate as! AppDelegate

import UIKit

enum storyBoardName: String {
    case authentication = "Authentication"
    case landing = "Landing"
    case menu = "Menu"
    
}

enum storyBoardVCIDs: String {
    case IntroVC = "IntroVC"
    case signUp = "signUpVc"
    case home = "mainMapsVC"
    case login = "logInVc"
    case Logout = "logout"
    case contactUsVc = "contactUsVc"
    case termsAndConditionVc = "termsAndConditionVc"
    case SideMenueVC = "SideMenueVC"
    case SendComplianceVC = "SendComplianceVC"
}
extension UIStoryboard {
    class func instantiateInitialViewController(_ board: storyBoardName) -> UIViewController {
        let story = UIStoryboard(name: board.rawValue, bundle: nil)
        return story.instantiateInitialViewController()!
    }
}
