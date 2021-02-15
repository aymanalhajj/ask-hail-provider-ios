//
//  SocketManager.swift
//  DemoProject
//
//  Created by Mohab on 4/20/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

//import Foundation
//import SocketIO
//
//
//class SocketIOManager: NSObject {
//    static let sharedInstance = SocketIOManager()
//    
//    // Socket variables
//  
//    
//    override init() {
//        super.init()
//        
//    }
//    
//    
//    func establishConnection(lat : String , lng : String) {
//       
//        socket.on(clientEvent: .connect) {data, ack in
//            print("socket connected right now")
//            
//        let param = ["user_id": Helper.getaUser_id() ?? "" , "lat" :lat , "lng" : lng , "channel" :"search_drivers"] as! [String:Any]
//             print(param)
//            self.socket.emit("search_drivers", param)
//
//        }
//        
//        socket.on("search_drivers-\(Helper.getaUser_id() ?? "")") { data , ack in
//            
//            print("search_drivers = \(data)")
//            guard var data = data[0] as? NSArray else {return}
//            
//            
//            
//            print(data)
////            self.arr.removeAll()
////            if data.count > 0 {
////                self.driver_exist = true
////            }
////            
////            
////            
////            for item in data {
////                var mohab = item as? NSDictionary
////                
////                self.arr.append(mohab!)
////                print(mohab?["id"] as? Int)
////                
////                var lat = mohab!["lat"] as! String
////                
////                var lng = mohab!["lng"] as! String
////                print("driver \(lat)")
////                
////                
////                
////                self.CreateMarker( Double(lat) ?? 0.0, Double(lng) ?? 0.0)
////            }
////            
////            print(self.arr)
////            
////            if self.arr.count != 0 {
////                
////                self.confirmationButton.isHidden = false
////                self.SkibButton.isHidden = false
////                
////                
////                
////                
////            }else {
////                
////                
////                self.confirmationButton.isHidden = true
////                self.SkibButton.isHidden = true
////                
////            }
////            
//            
//        }
//        
//        
//    }
//    
//  
//    
//    func checkSocketConnection()-> SocketIOStatus {
//        return socket.status
//    }
//    
//    func closeConnection() {
//        socket.disconnect()
//        print("socket disconnected right now")
//    }
//    
//    
//
////    func getAllOnDrivers( _ userId: String, _ carTypeId: String,  complete: @escaping (DriversLocations)->()) {
////
////        let emitData = ["to" : "\(userId)", "carType": "\(carTypeId)"]
////        self.socket.emit("drivers_location", with: [emitData])
////        socket.on("drivers_location") { (data: DriversLocations) in
////
//////            print("socket status is: \(data.status!)")
//////            print("socket status is: \(data)")
////
////
////            print(data)
////
////            complete(data)
////        }
////
////
////        socket.on("drivers_location") { (data, aka) in
////            print(data)
////
////
////            if let nodeDictionary = data as? [[String: Any]] {
////                print(nodeDictionary)
////
////                for dict in nodeDictionary[0] {
////                    print(dict.key)
////                    print(dict.value)
////
////                    if let userDict = dict as? [String:Any] {
////
////                        if let locations = userDict["locations"] as? [String:Any] {
////
////                            print(locations)
////                            if let lat = locations["lat"] as? String {
////                                print(lat)
////                            }
////                        }
////                    }
////                }
////            }
////        }
////
////
////    }
//    
////    func updateLocationScoket(_ userId: String, _ lat: String, _ long: String ,  complete: @escaping (ScocketResponse)->()) {
////        let emitData = ["userId" : "\(userId)", "lat": "\(lat)", "long":"\(long)"]
////        self.socket.emit("update_location", with: [emitData])
////        socket.on("update_location") { (data: ScocketResponse) in
////            
////            //            print("socket status is: \(data.status!)")
////            //            print("socket status is: \(data)")
////            complete(data)
////        }
////        
////    }
////    
////    func observeAcceptedOrder(complete: @escaping (UserDataSocket)->()){
////       
////        socket.on("notifyAcceptedOrder") { (data: UserDataSocket) in
////            print(data)
////            complete(data)
////        }
//// 
////    }
//    
//    
//    
//    
//    
//}
//
//extension SocketIOClient {
//    
//    func on<T: Decodable>(_ event: String, callback: @escaping (T)-> Void) {
//        self.on(event) { (data, _) in
//            guard !data.isEmpty else {
//                print("[SocketIO] \(event) data empty")
//                return
//            }
//            
//            guard let decoded = try? T(from: data[0]) else {
//                print("[SocketIO] \(event) data \(data) cannot be decoded to \(T.self)")
//                return
//            }
//            print(decoded)
//            
//            callback(decoded)
//        }
//    }
//}
//
//extension Decodable {
//    init(from any: Any) throws {
//        let data = try JSONSerialization.data(withJSONObject: any)
//        self = try JSONDecoder().decode(Self.self, from: data)
//    }
//}
//
////extension Data {
////    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
////        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
////            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
////            let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
////
////        return prettyPrintedString
////    }
////}
