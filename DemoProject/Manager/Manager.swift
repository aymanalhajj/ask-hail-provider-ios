//
//  Manager.swift
//  DemoProject
//
//  Created by MOHAB on 2/29/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import Alamofire


private func checkConnection() -> Bool {
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    return (reachabilityManager?.isReachable)!
}
let hostName = "https://askhail.com/api/v1/"







enum ServiceName: String {
    
   case login = "login"
    case register = "register"
    case check_code_activemail = "check_code_activemail"
    case change_password = "change_password"
    case check_forget = "check_forget"
     case check_code = "check_code"
    case logout = "logout"
     case UpdateProfile = "update_profile"
    case terms = "policy"
    case notifications = "notifications"
    case wating_Trips = "my_trip/waiting"
       case last_Trips = "my_trip/last"
    case contact = "add_msg"
    case car_types = "car_types"
    case complaints = "complaints"
    case makeTrip = "trips"
    case calculate_promo = "calculate_promo"
  case subscriptions = "subscriptions"
    case transfers = "transfers"
    case empty = ""
}

class Manager  : UIViewController {
    var lang : String = "ar"
    
    static var DevicToken : String?
    
    func perform(methodType: HTTPMethod = .post, useCustomeURL: Bool = false, urlStr: String = "", serviceName: ServiceName, parameters: [String: AnyObject]? = nil, completionHandler: @escaping (Any?, String?) -> Void)-> Void {
        
        if L102Language.currentAppleLanguage() == arabicLang {
            self.lang = "ar"
        }else{
            self.lang = "en"
        }
        
        var urlString: String = ""
        var headers: HTTPHeaders? = nil
        
        if useCustomeURL {
            urlString = urlStr
        }else {
            urlString = "\(hostName)\(serviceName.rawValue)"
        }
        
        
        print("ServiceName:\(serviceName)  parameters: \(String(describing: parameters))")
        
        
        if Helper.getapitoken() != "" && Helper.getapitoken() != nil {
            headers = [
                "Accept-Language": self.lang,
                "Authorization": "Bearer \(Helper.getapitoken()!)"
            ]
        }else{
            headers = [
                "Accept-Language": self.lang
            ]
        }
        let net = NetworkReachabilityManager()
        net?.startListening()
        
        net?.listener =
            { status in
                
                if  net?.isReachable ?? false
                {
                    
                    Alamofire.request(urlString, method: methodType, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
                        print(urlString , methodType , parameters)
                        
                        debugPrint(response)
                        
                        if response.result.isSuccess {
                            
                            let dict = response.result.value! as! [String: Any]
                            print(dict)
                            
                            if dict["value"] as? Bool == true || dict["value"] as? String == "true" {


                                print(response.data)
                                completionHandler(response.data!, nil)
                            }else{
                                if let dictError = dict["error"] as? String {
                                    completionHandler(nil, dictError)
                                }else {
                                    guard let errorStr = dict["msg"] as? String else {
                                        let errorsDict = dict["msg"] as! [String: Any]
                                        let errorsArr = errorsDict.values.first as! [String]
                                        
                                        completionHandler(nil, errorsArr[0])
                                        return
                                    }
                                    completionHandler(nil, errorStr)
                                }
                            }
                            
                        } else { //FAILURE
                            print("error \(String(describing: response.result.error)) in serviceName: \(serviceName)")
                            completionHandler(nil, response.result.error?.localizedDescription)
                        }}
                }
                else
                {
                    
                    self.showStatus(image: #imageLiteral(resourceName: "images"), message: "No internet")
                    
                }
        }
        
        
    }
    func uploadImage(serviceName: ServiceName,imagesArray: [UIImage]? = nil, profileImage: UIImage? = nil,commercial_register_image: UIImage? = nil,office_license_image:UIImage? = nil,id_image:UIImage? = nil, parameters: [String: AnyObject]? = nil, progress: @escaping (_ percent: Float) -> Void, completionHandler: @escaping (Any?, String?) -> Void) {
        
        var headers: HTTPHeaders? = nil
        
        if Helper.getapitoken() != "" && Helper.getapitoken() != nil{
            headers = [
                "Accept-Language": "en",
                "Authorization": "bearer \(Helper.getapitoken()!)"
            ]
        }else{
            headers = [
                "Accept-Language": "en"
            ]
        }
        
        let urlString: String =  "\(hostName)\(serviceName.rawValue)"
        
        
        
        let URL = try! URLRequest(url: urlString, method: .post, headers: headers)
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                if(profileImage != nil ){
                    if  let profileImageData = profileImage?.jpegData(compressionQuality: 0.3) {
                        multipartFormData.append(profileImageData , withName: "image", fileName: "image.jpg", mimeType: "image/jpg")
                    }
                }
                
                if imagesArray != nil{
                    for (image) in imagesArray! {
                        
                        if  let imageData = image.jpegData(compressionQuality: 0.3) {
                            multipartFormData.append(imageData , withName: "images[]", fileName: "image\(image).jpg", mimeType: "image/jpg")
                        }
                    }
                }
                if(commercial_register_image != nil ){
                    if  let profileImageData = commercial_register_image?.jpegData(compressionQuality: 0.3) {
                        multipartFormData.append(profileImageData , withName: "commercial_register_image", fileName: "image.jpg", mimeType: "image/jpg")
                    }
                }
                if(office_license_image != nil ){
                    if  let profileImageData = office_license_image?.jpegData(compressionQuality: 0.3) {
                        multipartFormData.append(profileImageData , withName: "office_license_image", fileName: "image.jpg", mimeType: "image/jpg")
                    }
                }
                if(id_image != nil ){
                    if  let profileImageData = id_image?.jpegData(compressionQuality: 0.3) {
                        multipartFormData.append(profileImageData , withName: "id_image", fileName: "image.jpg", mimeType: "image/jpg")
                    }
                }
                
                for (key, value) in parameters! {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
                
        },
            with: URL,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let request, _, _):
                    print("success")
                    request.uploadProgress(closure: { (progress_) in
                        print("Upload Progress: \(progress_.fractionCompleted)")
                        print("Upload totalUnitCount: \(progress_.totalUnitCount)")
                    })
                    request.validate(statusCode: 200..<500)
                    request.responseJSON { response in
                        
                        debugPrint("uploadRegistration: \(response)")
                        if response.result.isSuccess {
                            request.uploadProgress(closure: { (progress_) in
                                print("Upload Progress: \(progress_.fractionCompleted)")
                                print("Upload totalUnitCount: \(progress_.totalUnitCount)")
                            })
                            let dict = response.result.value! as! Dictionary<String, Any>
                            
                            print(response.result)
                            print(response)
                            
                            if (dict["value"] as! Bool == false){
                                let errorMsg = dict["msg"] as! String
                                completionHandler(nil,errorMsg)
                                
                            }else{
                                let statusCode = response.response?.statusCode
                                if statusCode! >= 200 && statusCode! <= 300 {
                                    print(response)
                                      completionHandler(response.data!, nil)
                                }else{
                                    completionHandler(nil, "Something Went Wrong.")
                                }
                                
                            }
                        }else { //FAILURE
                            print("error \(String(describing: response.result.error)) in serviceName: Upload Image")
                            completionHandler(nil, response.result.error?.localizedDescription)
                        }
                        
                    }
                case .failure(let errorType):
                    print("encodingError:\(errorType)")
                }
        })
        
    }
    func performJson(methodType: HTTPMethod = .post, useCustomeURL: Bool = false, urlStr: String = "", serviceName: ServiceName, parameters: [String: Any]? = nil, completionHandler: @escaping (Any?, String?) -> Void)-> Void {
        
        
        
        
        
        print("ServiceName:\(serviceName)  parameters: \(String(describing: parameters))")
        
        
       if L102Language.currentAppleLanguage() == arabicLang {
                   self.lang = "ar"
               }else{
                   self.lang = "en"
               }
               
               var urlString: String = ""
                     var headers: HTTPHeaders? = nil
                     
                     if useCustomeURL {
                         urlString = urlStr
                     }else {
                         urlString = "\(hostName)\(serviceName.rawValue)"
                     }
               
               if useCustomeURL {
                   urlString = urlStr
               }else {
                   urlString = "\(hostName)\(serviceName.rawValue)"
               }
               
        let net = NetworkReachabilityManager()
               net?.startListening()
               
               net?.listener =
                   { status in
                       
                       if  net?.isReachable ?? false
                       {
        
        Alamofire.request(urlString, method: methodType, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            
            
            debugPrint(response)
            
          if response.result.isSuccess {
                                    
                                    let dict = response.result.value! as! [String: Any]
                                    print(dict)
                                    
                                    if dict["value"] as? Bool == true || dict["value"] as? String == "true" {


                                        print(response.data)
                                        completionHandler(response.data!, nil)
                                    }else{
                                        if let dictError = dict["error"] as? String {
                                            completionHandler(nil, dictError)
                                        }else {
                                            guard let errorStr = dict["msg"] as? String else {
                                                let errorsDict = dict["msg"] as! [String: Any]
                                                let errorsArr = errorsDict.values.first as! [String]
                                                
                                                completionHandler(nil, errorsArr[0])
                                                return
                                            }
                                            completionHandler(nil, errorStr)
                                        }
                                    }
                                    
                                } else { //FAILURE
                                    print("error \(String(describing: response.result.error)) in serviceName: \(serviceName)")
                                    completionHandler(nil, response.result.error?.localizedDescription)
                                }}
                        }
                        else
                        {
                            
                            self.showStatus(image: #imageLiteral(resourceName: "images"), message: "No internet")
                            
                        }
                }
                
                
            }
    
}
