//
//  SplashVC.swift
//  AskHailBusiness
//
//  Created by Mohab on 1/20/21.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces
import Lottie

class SplashVC: UIViewController {
    let animationView = AnimationView()
    let animationView1 = AnimationView()
    @IBOutlet weak var imageView: UIView!
    
    @IBOutlet weak var imageview1: UIView!
    
    var lat : Double?
       var lon : Double?
    
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      animationView.play(fromProgress: 0,
                         toProgress: 1,
                         loopMode: LottieLoopMode.playOnce,
                         completion: { (finished) in
                          if finished {


                            guard let window = UIApplication.shared.keyWindow else{return}
                            if Helper.getapitoken() != nil {
                                
                                
                                
                                let sb = UIStoryboard(name: Home, bundle: nil)
                                var vc : UIViewController
                                vc = sb.instantiateViewController(withIdentifier: "HomeVC")
                                window.rootViewController = vc
                                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                            }else {
                                
                                let sb = UIStoryboard(name: Authontication, bundle: nil)
                                var vc : UIViewController
                                vc = sb.instantiateViewController(withIdentifier: "WelcomeVC")
                                window.rootViewController = vc
                                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                                
                            }
                            
                            
                          } else {
                            print("Animation cancelled")
                          }
      })
      
    }
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
 var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    override func viewDidLoad() {
        super.viewDidLoad()
      
    
        
        locationManager = CLLocationManager()
          locationManager.desiredAccuracy = kCLLocationAccuracyBest
          locationManager.requestAlwaysAuthorization()
          locationManager.distanceFilter = 50
          locationManager.startUpdatingLocation()
          locationManager.delegate = self

     let animation = Animation.named("splacsh2", subdirectory: "TestAnimations")
        
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFill
        imageView.addSubview(animationView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.translatesAutoresizingMaskIntoConstraints = false
       animationView.topAnchor.constraint(equalTo: imageView.layoutMarginsGuide.topAnchor).isActive = true
        animationView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        
        animationView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true
        animationView.trailingAnchor.constraint(equalTo: imageView .trailingAnchor).isActive = true
        animationView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        
        
        if let coor = locationManager.location?.coordinate{
            
            
            let camera = GMSCameraPosition.camera(withLatitude: coor.latitude,
                                                  longitude: coor.longitude,
                                                  zoom: zoomLevel)
            self.lat = coor.latitude
            self.lon = coor.longitude
            
            Helper.SaveUser_lat(phone: "\(self.lat ?? 0)")

            Helper.SaveUser_Lng(phone: "\(self.lon ?? 0)")
            
            
        }
        
    }
    
    

}
extension SplashVC : CLLocationManagerDelegate {

      // Handle incoming location events.
      func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")

        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
//        self.lat = location.coordinate.latitude
//        self.lon = location.coordinate.longitude
//        print(self.lat , self.lon)
//
//        Helper.SaveUser_lat(phone: "\(self.lat ?? 0)")
//
//        Helper.SaveUser_Lng(phone: "\(self.lon ?? 0)")
        
      }

      // Handle authorization for the location manager.
      func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
          print("Location access was restricted.")
        case .denied:
          print("User denied access to location.")
          // Display the map using the default location.
         
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
        
      
        

    }


