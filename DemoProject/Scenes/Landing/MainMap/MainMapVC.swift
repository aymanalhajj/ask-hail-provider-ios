//
//  MainMapVC.swift
//  DemoProject
//
//  Created by Mohab on 4/13/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import BottomPopup
import MapKit
import CoreLocation
import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftyJSON
import SocketIO

class MainMapVC: BaseViewController , GMSMapViewDelegate {
    
    var IsLocated = 0
    var Trip_status = 0
    
var Address = ""
    var end_address = ""
    var src_located = false
      var dest_located = false
    @IBOutlet weak var PinImage: UIImageView!
    @IBOutlet weak var StartView: UIView!
    @IBOutlet weak var MenueBtn: UIButton!
    @IBOutlet weak var endView: UIView!
    @IBOutlet weak var MapView: GMSMapView!
    @IBOutlet weak var StartAddressLabel: UILabel!
    @IBOutlet weak var endAddreessLabel: UILabel!
    @IBOutlet weak var ConfirmBtn: UIButton!
    @IBOutlet weak var SkipView: UIView!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var ChooseView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var makeTripBtn: UIButton!
    
    var lat : Double?
          var lng : Double?
          var locationManager = CLLocationManager()
          var currentLocation: CLLocation?
          var placesClient: GMSPlacesClient!
          var zoomLevel: Float = 15.0
    var src_marker = GMSMarker()
    var dest_marker = GMSMarker()
    var markers = [GMSMarker]()
    var driver_marker = GMSMarker()
    var cars = [GMSMarker]()
    
    var start_lat : Double = 0.0
    var start_lng : Double = 0.0
    var end_lat : Double = 0.0
    var end_lng : Double = 0.0
    var Trip_Id : String?
    
    let manager = SocketManager(socketURL: URL(string: SocketURL)!, config: [.log(true), .compress])
      var socket: SocketIOClient!
    var connected = false
    var driver_exist = false
    var DriversArray = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
       
     
        setUpViews()
        
          NotificationCenter.default.addObserver(self, selector: #selector(AcceptTrip(_:)), name: NSNotification.Name(rawValue: Notification_accept_trip), object: nil)
    
    }
    @objc func AcceptTrip(_ notification: Notification){
         
             cancelBtn.isHidden = true
         
         let storyboard = UIStoryboard(name: PopView, bundle: nil)
                                                  

                                             
         guard let popupVC = storyboard.instantiateViewController(withIdentifier: "DriverProfileVC") as? DriverProfileVC else { return }
                
         popupVC.Driver_id = trip.did
                                                             
         popupVC.height = 160
                                                                  
         popupVC.topCornerRadius = 8
                                                                  
         popupVC.presentDuration = 1
                                                                  
         popupVC.dismissDuration = 1
                                                                 // popupVC.popupDelegate = self
                                                     
         self.present(popupVC, animated: true, completion: nil)
            
         
         print("accept_Trip")
         
        }
     
    
    
   
    
    
    
    @IBAction func SkipAction(_ sender: Any) {
        
        
        if Trip_status == 0 {
            
            let storyboard = UIStoryboard(name: Landing, bundle: nil)
                  
                    let vc  = storyboard.instantiateViewController(withIdentifier: "DetermineTimeVC") as! DetermineTimeVC
                         vc.modalPresentationStyle = .fullScreen
                         self.addChild(vc)
                         vc.view.frame = self.view.frame
                         self.view.addSubview(vc.view)
                         vc.didMove(toParent: self)
            
        }else if Trip_status == 1 {
            
             Trip_status = 2
                      SkipView.isHidden = true
                      ConfirmBtn.isHidden = true
                      makeTripBtn.isHidden = false
                        MapView.addSubview(ChooseView)
                      
            
        }
        
        
    }
    
    
 
    
    @IBAction func MakeTripAction(_ sender: Any) {
        
        guard let car_id = self.carType_id else {
            
            self.showAlertWithTitle(title: "", message: "Please choose car type".localized, type: .error)
            return
        }
        
        makeTrip(time_type: Time_type, car_type_id: car_id, start_address: StartAddressLabel.text ?? "", end_address: end_address)
      
        
    }
    
    
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        
        // trip_status = 0 thats mean you have two choice first select date of trip then the trip will make when your date come or confirm first point
        
        //trip_status = 1 thats mean you have two choice select end_point or skip
        
        
    
        if Trip_status == 0 {
            
            
            guard start_lat != 0 , start_lng != 0  else {
                
                self.showAlertWithTitle(title: "", message: "you should select start point first", type: .error)
                
                return
            }
            
            Trip_status = 1
            skipBtn.setImage(nil, for: .normal)
            skipBtn.setTitle("Skip", for: .normal)
            ConfirmBtn.setTitle("Confirm end Point", for: .normal)
             endView.isHidden = false
           
            src_located = true
            
            print(start_lat , start_lng)
            
            CreatePin(self.start_lat, self.start_lng)
        }else if Trip_status == 1 {
            
            
            guard end_lat != 0 , end_lng != 0  else {
                          
                          self.showAlertWithTitle(title: "", message: "you should select end point first", type: .error)
                          
                          return
                      }
            Trip_status = 2
            SkipView.isHidden = true
            ConfirmBtn.isHidden = true
            makeTripBtn.isHidden = false
              MapView.addSubview(ChooseView)
           
            
            
            CreatePin(self.end_lat, self.end_lng)
            
            
        }else if Trip_status == 2 {
            
            Trip_status = 3
            cancelBtn.isHidden = false
           
            
        }
    
        
    
    }
    

    @IBAction func MenueAction(_ sender: Any) {
        
      
//PaymentMethode(amount: "3", trip_id: "640", subscription_id: "3", country_code: "+966", mobile: "01008226145")
        
        if L102Language.currentAppleLanguage() == englishLang {
                   panel?.openLeft(animated: true)
               }else{
                   panel?.openRight(animated: true)
               }
        
    }
    
    
    
    
    @IBAction func carTypeAction(_ sender: Any) {
        
        if self.start_lat != 0.0 , self.start_lng != 0.0 ,  self.end_lat != 0.0 ,  self.end_lng != 0.0 {
            
            
            let coordinate0 = CLLocation(latitude: self.start_lat, longitude: self.start_lng)
            let coordinate1 = CLLocation(latitude: self.end_lat, longitude: self.end_lng)
            let distanceInMeters = coordinate0.distance(from: coordinate1)
            
            let storyboard = UIStoryboard(name: PopView, bundle: nil)
                                                             

                                                           guard let popupVC = storyboard.instantiateViewController(withIdentifier: "CarTypesVC") as? CarTypesVC else { return }
                           
            popupVC.Distance = distanceInMeters
                                                                             popupVC.height = 600
                                                                             popupVC.topCornerRadius = 8
                                                                             popupVC.presentDuration = 1
                                                                             popupVC.dismissDuration = 1
                                                                            // popupVC.popupDelegate = self
                                                                 self.present(popupVC, animated: true, completion: nil)
            
        }else {
            
            let storyboard = UIStoryboard(name: PopView, bundle: nil)
                                                    

                                                  guard let popupVC = storyboard.instantiateViewController(withIdentifier: "CarTypesVC") as? CarTypesVC else { return }
                  
                  
                                                                    popupVC.height = 600
                                                                    popupVC.topCornerRadius = 8
                                                                    popupVC.presentDuration = 1
                                                                    popupVC.dismissDuration = 1
                                                                   // popupVC.popupDelegate = self
                                                        self.present(popupVC, animated: true, completion: nil)
            
        }
        
        
        
    }
    
    @IBAction func PayWayAction(_ sender: Any) {
        
        
    }
    
    
    @IBAction func PromoCodeAction(_ sender: Any) {
        
            let storyboard = UIStoryboard(name: PopView, bundle: nil)
        guard let popupVC = storyboard.instantiateViewController(withIdentifier: "PromoCodeVc") as? PromoCodeVc else { return }
              
              
                                                                popupVC.height = 250
                                                                popupVC.topCornerRadius = 8
                                                                popupVC.presentDuration = 1
                                                                popupVC.dismissDuration = 1
                                                               // popupVC.popupDelegate = self
                                                    self.present(popupVC, animated: true, completion: nil)
          }
   
    @IBAction func cancelAction(_ sender: Any) {
        
        
           let storyboard = UIStoryboard(name: PopView, bundle: nil)
             guard let popupVC = storyboard.instantiateViewController(withIdentifier: "EndReasonsVC") as? EndReasonsVC else { return }
                   
        popupVC.Trip_Id = self.Trip_Id ?? ""
                                                                 
        popupVC.height = 400
                                                                     
        popupVC.topCornerRadius = 8
                                                                     
        popupVC.presentDuration = 1
                                                                     
        popupVC.dismissDuration = 1
                                                           
        // popupVC.popupDelegate = self
                                                        
        self.present(popupVC, animated: true, completion: nil)
      
        
    }
    
    
    
    
}
extension MainMapVC: CLLocationManagerDelegate {

  // Handle incoming location events.
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location: CLLocation = locations.last!
    print("Location: \(location)")
    
    self.lat = location.coordinate.latitude
    self.lng = location.coordinate.longitude
    SetUpSocket(lat: "\(self.lat ?? 0.0)", Lng: "\(self.lng ?? 0.0)")
    self.start_lat = self.lat ?? 0.0
    self.start_lng = self.lng ?? 0.0
    if IsLocated == 0 {
    getLocation(start_lat, start_lng)
    
    IsLocated = 1
    }
//  src_marker.map = nil
//    
//    src_marker = GMSMarker(position: CLLocationCoordinate2D(latitude: self.start_lat, longitude: self.start_lng))
//    src_marker.icon = #imageLiteral(resourceName: "ic_place")
//      src_marker.map = MapView
    

    let camera = GMSCameraPosition.camera(withLatitude: self.lat ?? 0.0,
                                          longitude: self.lng ?? 0.0,
                                          zoom: zoomLevel)

    if MapView.isHidden {
      MapView.isHidden = false
      MapView.camera = camera
    } else {
      MapView.animate(to: camera)
    }

    
  }

  // Handle authorization for the location manager.
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .restricted:
      print("Location access was restricted.")
    case .denied:
      print("User denied access to location.")
      // Display the map using the default location.
      MapView.isHidden = false
    case .notDetermined:
      print("Location status not determined.")
    case .authorizedAlways: fallthrough
    case .authorizedWhenInUse:
      print("Location status is OK.")
    }
  }

  // Handle location manager errors.
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    locationManager.stopUpdatingLocation()
    print("Error: \(error)")
  }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
          if connected  && driver_exist {
              
              if  !src_located{
                  src_marker.map = nil
                  src_marker = GMSMarker(position: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
                  
                  src_marker.map = mapView
                  self.start_lat = coordinate.latitude
                  self.start_lng = coordinate.longitude
                  getLocation(start_lat, start_lng)
                  self.search_near_driver("\(self.start_lat)","\(self.start_lng)")
              }else if (!dest_located){
                  dest_marker.map = nil
                  dest_marker = GMSMarker(position: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
                  dest_marker.map = mapView
                  self.end_lat = coordinate.latitude
                  self.end_lng = coordinate.longitude
                  
                  getLocation(end_lat, end_lng)
              }else{
                  
              }
              
          }else {
              
            showAlertWithTitle(title: "", message: "no drivers exist".localized, type: .error)
          }
          
          
      }
    
//    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//
//          lat = mapView.camera.target.latitude
//
//
//         lng = mapView.camera.target.longitude
//           print("\(self.lat ?? 0.0)","\(self.lng ?? 0.0)")
//
//         SetUpSocket(lat: "\(self.lat ?? 0.0)", Lng: "\(self.lng ?? 0.0)")
//        if Trip_status == 0 {
//            self.start_lat = mapView.camera.target.latitude
//                   self.start_lng = mapView.camera.target.longitude
//
//
//        }
//
//
//     //   else if Trip_status == 1 {
//        //
//        //            self.end_lat = mapView.camera.target.latitude
//        //            self.end_lng = mapView.camera.target.longitude
//        //
//        //        }
//
//
//         getLocation(lat ?? 0.0, lng ?? 0.0)
////
////        if connected  && driver_exist {
////
////            if  !src_located{
////                src_marker.map = nil
////                src_marker = GMSMarker(position: CLLocationCoordinate2D(latitude: mapView.camera.target.latitude, longitude: mapView.camera.target.longitude))
////
////                src_marker.map = mapView
////                self.start_lat = mapView.camera.target.latitude
////                self.start_lng = mapView.camera.target.longitude
////                getLocation(start_lat, start_lng)
////                self.search_near_driver(self.start_lat,self.start_lng)
////            }else if (!dest_located){
////                dest_marker.map = nil
////                dest_marker = GMSMarker(position: CLLocationCoordinate2D(latitude: mapView.camera.target.latitude, longitude: mapView.camera.target.longitude))
////                dest_marker.map = mapView
////                self.end_lat = mapView.camera.target.latitude
////                self.end_lng = mapView.camera.target.longitude
////
////                getLocation(end_lat, end_lng)
////            }else{
////
////            }
////
////        }else {
////
////            showAlertWithTitle(title: "", message: "no drivers exist", type: .error)
////        }
//
//
//
//
//     }
//

}

extension MainMapVC  {
    
   
    
    func getLocation(_ latitude: Double,_ longitude : Double) {
        let url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&key=\(GoogleKey)&language=en"
        
        print(url)
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success:
                
                let responseJson = response.result.value! as! NSDictionary
                
                if let results = responseJson.object(forKey: "results")! as? [NSDictionary] {
                    print(results.count)
                    if results.count > 0 {
                   
                        if self.Trip_status == 0 {
                            
                            self.StartAddressLabel.text = results[0]["formatted_address"] as? String
                                                   self.Address = results[0]["formatted_address"] as? String ?? ""
                                                   
                                                   
                                                   self.lat = latitude
                                                   self.lng = longitude
                            
                        }else if self.Trip_status == 1 {
                            
                            self.endAddreessLabel.text = results[0]["formatted_address"] as? String
                                                                             self.end_address = results[0]["formatted_address"] as? String ?? ""
                                                                             
                                                                             
                                                                             self.lat = latitude
                                                                             self.lng = longitude
                            
                        }
                       
                            
                        
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    

}

extension MainMapVC {
    
    func makeTrip(time_type : String , car_type_id : String  , start_address : String , end_address : String)  {
                            
        
       
        
                        
                      var  param = [
                
                  
                        "start_lat" : "\(self.start_lat)",
                        "start_lng" : "\(self.start_lng)",
                        "start_address" : start_address,
                         "car_type_id" : car_type_id ,
                         "initial_price" : self.Initial_Price ,
                        "payment_id" : "1",
                        "wallet_first" : "true",
                         
                         
                      
                      ]
        
        if time_type == "now" {
            
            param["time_type"] = time_type
            
        }else if time_type == "later" {
            param["time_type"] = time_type
            param["time"] = time
            param["date"] = date
            
        }
                 
        if end_lat != 0.0 , end_lng != 0.0 {
            
            param["end_lat"] = "\(end_lat)"
            param["end_lng"] = "\(end_lng)"
            param["end_address"] = end_address
            
        }
                
        if let cupone = Cupon {
            
            param["coupon"] = cupone
            
        }
    
        
                             
        
        
                      
                          DispatchQueue.main.async {
                                                       //            self.subjectLabel.showAnimatedSkeleton()
                                                       
                            self.view.lock()
                                 
                        
                                                       let manager = Manager()
                                                       
                                                    
                                                       
                              manager.perform(methodType: .post, serviceName: .makeTrip, parameters: param as [String : AnyObject] ) { (JSON, String) -> Void in
                                                           
                                              
                                self.view.unlock()
                                                           
                                                    
                                 if String != nil {
                                                               
                                                               
                                                    
                                     self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                                                               
                                                               
                                                           }else {
                                                              
                                                             guard let dt = JSON else {
                                                                 return
                                                             }
                                                            do {
                                                               
                                                             let data = try JSONDecoder().decode(makeTripModel.self, from: JSON as! Data)
                                                           
                                                              print(data)
                                                             
                                                                Helper.SaveTrip_id(Tripid: "\(data.data?.id ?? 0)")
                                                                
                                                                self.ChooseView.isHidden = true
                                                                self.makeTripBtn.isHidden = true
                                                                
                                                                self.cancelBtn.isHidden = false
                                                        
                                                                self.Trip_Id = "\(data.data?.id ?? 0)"
                                                                
                                                            }catch {
                                    
                                                              }
                                   
                                                          }

                                                          
                                  }
                           
                              }

                              
                          }
          
    
    func SingleTrip(trip_id : String)  {
                               
                           
                       
        
                   
                    
                         
                             DispatchQueue.main.async {
                                                          //            self.subjectLabel.showAnimatedSkeleton()
                                                          
                               self.view.lock()
                                    
                           
                                                          let manager = Manager()
                                                          
                                                       
                                                          
                              let urlll = "\(hostName)trips/\(trip_id)"
                                                                                    
                                                            print(urlll)
                                                                             
                                                            
                                manager.perform(methodType: .get, useCustomeURL: true, urlStr: urlll, serviceName: .empty, parameters: nil) { (JSON, String) -> Void in
                                                              
                                                 
                                   self.view.unlock()
                                                              
                                                       
                                    if String != nil {
                                                                  
                                                                  
                                                       
                                        self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                                                                  
                                                                  
                                                              }else {
                                                                 
                                                                guard let dt = JSON else {
                                                                    return
                                                                }
                                                               do {
                                                                  
                                                                let data = try JSONDecoder().decode(SingleTripModel.self, from: JSON as! Data)
                                                              
                                                                 print(data)
                                                                
                                                                 
                                                           
                                                               }catch {
                                       
                                                                 }
                                      
                                                             }

                                                             
                                     }
                              
                                 }

                                 
                             }
   
   
    func PaymentMethode(amount : String ,trip_id : String , subscription_id : String , country_code : String , mobile : String)  {
                              
                          
                      
       
                  
                   
                        
                            DispatchQueue.main.async {
                                                         //            self.subjectLabel.showAnimatedSkeleton()
                                                         
                              self.view.lock()
                                   
                          
                                                         let manager = Manager()
                                                         
                                                      
                                                         
                                let param = [
                                
                                    "amount" : amount,
                                    "trip_id" : trip_id ,
                                    "subscription_id" : subscription_id ,
                                    "country_code" : country_code ,
                                    "mobile" : mobile
                                   
                                    
                                    
                                ]
                             let urlll = "\(hostName)payment"
                                                                                   
                                                           print(urlll)
                                                                            
                                                           
                                manager.perform(methodType: .post, useCustomeURL: true, urlStr: urlll, serviceName: .empty, parameters: param as [String : AnyObject]) { (JSON, String) -> Void in
                                                             
                                                
                                  self.view.unlock()
                                                             
                                                      
                                   if String != nil {
                                                                 
                                                                 
                                                      
                                       self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                                                                 
                                                                 
                                                             }else {
                                                                
                                                               guard let dt = JSON else {
                                                                   return
                                                               }
                                                              do {
                                                                 
                                                               let data = try JSONDecoder().decode(PaymentModel.self, from: JSON as! Data)
                                                             
                                                                print(data)
                                                               
                                                  let storyboard = UIStoryboard(name: PopView, bundle: nil)
                                                           let vc  = storyboard.instantiateViewController(withIdentifier: "PayWebViewVC") as! PayWebViewVC
                                                         vc.modalPresentationStyle = .fullScreen
                                                                vc.PaymetUrl = data.data
                                                                
                                    self.present(vc, animated: true, completion: nil)
                                                          
                                                              }catch let error {
                                      
                                                                
                                                                print(error)
                                                                
                                                                }
                                     
                                                            }

                                                            
                                    }
                             
                                }

                                
                            }
}

extension MainMapVC: BottomPopupDelegate {
    
    func bottomPopupViewLoaded() {
        print("bottomPopupViewLoaded")
    }
    
    func bottomPopupWillAppear() {
        print("bottomPopupWillAppear")
    }
    
    func bottomPopupDidAppear() {
        print("bottomPopupDidAppear")
    }
    
    func bottomPopupWillDismiss() {
        print("bottomPopupWillDismiss")
    }
    
    func bottomPopupDidDismiss() {
        print("bottomPopupDidDismiss")
    }
    
    func bottomPopupDismissInteractionPercentChanged(from oldValue: CGFloat, to newValue: CGFloat) {
        print("bottomPopupDismissInteractionPercentChanged fromValue: \(oldValue) to: \(newValue)")
    }
}
extension MainMapVC {
    
    
    func CreateMarker(_ lat : Double ,_ lng : Double ){
           let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lng))
         
           marker.tracksViewChanges = true
           marker.appearAnimation = .pop
           marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
             marker.icon = #imageLiteral(resourceName: "car_pin")
           marker.map = MapView
         
       }
    
    func CreatePin(_ lat : Double ,_ lng : Double ){
              let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lng))
            
              marker.tracksViewChanges = true
              marker.appearAnimation = .pop
              marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        marker.icon = #imageLiteral(resourceName: "pin-red")
              marker.map = MapView
            
          }
    
    
}
extension MainMapVC {
    
    func SetUpSocket(lat : String , Lng : String){
         
         socket = manager.defaultSocket
                 socket.connect()
                
                socket.on(clientEvent: .connect) {data, ack in
                                   print("socket connected")
                                   self.connected = true
                    self.search_near_driver(lat,Lng)
                               }
                
                socket.on("search_drivers-\(Helper.getaUser_id() ?? "")") { data , ack in
                            
                            print("search_drivers = \(data)")
                            guard var data = data[0] as? NSArray else {return}
                            
                            
                            
                            print(data)
                            self.DriversArray.removeAll()
                    self.SkipView.isHidden = true
                    self.ConfirmBtn.isHidden = true
                            if data.count > 0 {
                                self.driver_exist = true
                                self.SkipView.isHidden = false
                                self.ConfirmBtn.isHidden = false
                            }
                            
                            
                            
                            for item in data {
                                var diverData = item as? NSDictionary
                                
                                self.DriversArray.append(diverData!)
                                print(diverData?["id"] as? Int)
                                
                                var lat = diverData!["lat"] as! String
                                
                                var lng = diverData!["lng"] as! String
                                print("driver \(lat)")
                                
                                
                                
                                self.CreateMarker( Double(lat) ?? 0.0, Double(lng) ?? 0.0)
                            }
                            
                    
                }
                
              
         
         
     }
     
       func search_near_driver(_ lat:String,_ lng:String){
         let param = ["user_id": Helper.getaUser_id() ?? "" , "lat" :"30,881672828685186" , "lng" : "31,469722176062884" , "channel" :"search_drivers"] as! [String:Any]
           print(param)
           socket.emit("search_drivers", param)
           remAll()
       }
       
       func remAll(){
           for m in cars {
               m.map = nil
           }
       }
     
     
     
     
     func setUpViews(){
         
         
         
         MapView.delegate = self

                          locationManager = CLLocationManager()
                           locationManager.desiredAccuracy = kCLLocationAccuracyBest
                           locationManager.requestAlwaysAuthorization()
                           locationManager.distanceFilter = 50
                           locationManager.startUpdatingLocation()
                           locationManager.delegate = self
               
               MapView.addSubview(MenueBtn)
               MapView.addSubview(StartView)
               MapView.addSubview(endView)
               MapView.addSubview(ConfirmBtn)
         MapView.addSubview(SkipView)
         MapView.addSubview(cancelBtn)
         MapView.addSubview(PinImage)
         MapView.addSubview(makeTripBtn)
         makeTripBtn.isHidden = true
         cancelBtn.isHidden = true
         endView.isHidden = true
        SkipView.isHidden = true
        ConfirmBtn.isHidden = true
               
         
     }
     
     
    
    
}
