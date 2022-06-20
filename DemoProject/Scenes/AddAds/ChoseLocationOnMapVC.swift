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
    var isFirstMap = true
    
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
    
    
    
    
    
    func CreateMarker(Lat : Double , lng : Double){
        let marker = GMSMarker()
        mapView.clear()
        marker.iconView = CustomMarkerView2(frame: CGRect(x: 0, y: 0, width: 36, height: 48), image: #imageLiteral(resourceName: "locationInAds"), borderColor: UIColor.darkGray, tag: 0)
        marker.position = CLLocationCoordinate2D(latitude: Lat, longitude: lng)
        let cameraPosition = GMSCameraPosition.camera(withLatitude: Lat, longitude: lng, zoom: 15.0)
        marker.map = mapView
        mapView.animate(to: cameraPosition)
        
        
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
            if isFirstMap {
                isFirstMap = false
                CreateMarker(Lat: location.coordinate.latitude, lng: location.coordinate.longitude)
                getLocation(location.coordinate.latitude,location.coordinate.longitude)
            }
        }
        
        
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .restricted:
            
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            
            let alertController = UIAlertController(title: "Ask Hail", message: "Ask Hail would like to access your Location to get Listings and search properties Near your Location".localized, preferredStyle: .alert)

            let settingsAction = UIAlertAction(title: "Settings".localized, style: .default) { (_) -> Void in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                     }
                }
            let cancelAction = UIAlertAction(title: "Cancel".localized, style: .default) { (_) -> Void in
                   // self.navigationController?.popViewController(animated: true)
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
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
       
        lat = coordinate.latitude
        print(lat)
        lon = coordinate.longitude
        let camera = GMSCameraPosition.camera(withLatitude: lat ?? 0.0,
                                              longitude: lon ?? 0.0,
                                              zoom: zoomLevel)
        mapView.animate(to: camera)
        
        CreateMarker(Lat: lat ?? 0.0, lng: lon ?? 0.0)
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

import Foundation
import Foundation
import Foundation
import UIKit

class CustomMarkerView2: UIView {
    var img: UIImage!
    var borderColor_Map: UIColor!
    
    init(frame: CGRect, image: UIImage?, borderColor: UIColor, tag: Int) {
        super.init(frame: frame)
        self.img = #imageLiteral(resourceName: "neighbourhood")
     
        setupViews()
    }
    
    func setupViews() {
        let imgView = UIImageView(image: img)
        imgView.frame=CGRect(x: 0, y: 0, width: 36, height: 36)
       
        imgView.clipsToBounds=false
       
        
        
        
        self.addSubview(imgView)
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}









