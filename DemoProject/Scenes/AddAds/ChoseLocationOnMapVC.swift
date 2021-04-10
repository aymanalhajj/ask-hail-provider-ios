//
//  ViewController.swift
//  Abddallah
//
//  Created by Mohab on 1/11/21.
//

import UIKit
import MapKit
import CoreLocation
import GoogleMaps
import GooglePlaces
import Alamofire


protocol ChooseLocation {
    func ChooseLocation(lat : Double , lng : Double , Address: String)
}



class ChoseLocationOnMapVC: UIViewController , GMSMapViewDelegate {
    var Address = ""
    var isPray = 0
    var lang = ""
    @IBOutlet weak var IMGView: UIImageView!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var selectBtn: UIButton!
    
    var Delegate : ChooseLocation?
    
    
    @IBOutlet weak var SelectView: UIView!
    
    @IBOutlet weak var addreesLabel : UILabel!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var lat : Double?
    var lon : Double?
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    
    
    override func viewWillAppear(_ animated: Bool) {
        if L102Language.currentAppleLanguage() == englishLang {
            lang = "en"
        }else{
            lang = "ar"
        }
    }
    @IBOutlet weak var getMyLocationBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.addSubview(getMyLocationBtn)
        
        
        mapView.addSubview(IMGView)
        mapView.addSubview(SelectView)
        mapView.addSubview(backBtn)
        
        
        mapView.delegate = self
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
        
        
        
        
    }
    
    @IBAction func CurrentLocation(_ sender: Any) {
        
        if let coor = locationManager.location?.coordinate{
            
            
            let camera = GMSCameraPosition.camera(withLatitude: coor.latitude,
                                                  longitude: coor.longitude,
                                                  zoom: zoomLevel)
            
            mapView.animate(to: camera)
            
            
        }
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        if isPray == 1  {
            dismiss(animated: true, completion: nil)
        }else{
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    
    
    
    func CreateMarker(_ lat : Double ,_ lng : Double ){
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lng))
        
        marker.tracksViewChanges = true
        marker.appearAnimation = .pop
        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        marker.icon = #imageLiteral(resourceName: "mapsAndFlags")
        marker.map = mapView
        
    }
    
    
    @IBAction func DoneAction(_ sender: Any) {
        
        if isPray == 1 {
            print(self.Address)
            Delegate?.ChooseLocation(lat: self.lat ?? 0.0, lng: self.lon ?? 0.0, Address: self.Address)
            dismiss(animated: true, completion: nil)
            isPray = 0
        }else{
            print(self.Address)
            Delegate?.ChooseLocation(lat: self.lat ?? 0.0, lng: self.lon ?? 0.0, Address: self.Address)
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    
    
    
}
extension ChoseLocationOnMapVC: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
        
        
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .restricted:
            
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            
            let alertController = UIAlertController(title: "Ask Hail", message: "Ask Hail would like to access your Location to get Listings and search properties Near your Location", preferredStyle: .alert)

                let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                     }
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (_) -> Void in
                    self.navigationController?.popViewController(animated: true)
                }

                alertController.addAction(cancelAction)
                alertController.addAction(settingsAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways:
            
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
                print("locations = \(locValue.latitude) \(locValue.longitude)")
            let camera = GMSCameraPosition.camera(withLatitude: Double(locValue.latitude),longitude: Double(locValue.longitude),zoom: self.zoomLevel)
            
            mapView.animate(to: camera)
            print("here")
            
        case .authorizedWhenInUse:
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
                print("locations = \(locValue.latitude) \(locValue.longitude)")
            let camera = GMSCameraPosition.camera(withLatitude: Double(locValue.latitude),longitude: Double(locValue.longitude),zoom: self.zoomLevel)
            mapView.animate(to: camera)
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        lat = mapView.camera.target.latitude
        print(lat)
        
        lon = mapView.camera.target.longitude
        print(lon)
        
        
        
        getLocation(lat ?? 0.0, lon ?? 0.0)
        
        
    }
    
    
}

extension ChoseLocationOnMapVC  {
    
    func getLocation(_ latitude: Double,_ longitude : Double) {
        let url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&key=\(GoogleKey)&language=\(lang)"
        
        print(url)
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success:
                
                let responseJson = response.result.value! as! NSDictionary
                
                if let results = responseJson.object(forKey: "results")! as? [NSDictionary] {
                    print(results.count)
                    if results.count > 0 {
                        
                        self.addreesLabel.text = results[0]["formatted_address"] as? String
                        self.Address = results[0]["formatted_address"] as? String ?? ""
                        
                        
                        
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
