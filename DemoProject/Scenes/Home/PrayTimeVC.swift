//
//  PrayTimeVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/17/20.
//  Copyright © 2020 MOHAB. All rights reserved.

import UIKit
import Alamofire
import CoreLocation

class PrayTimeVC: UIViewController {
    
    @IBOutlet weak var MainView: UIScrollView!
    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var View3: UIView!
    @IBOutlet weak var View2: UIView!
    
    var lat = Helper.getUser_lat()
    var lng = Helper.getUser_Lng()
    
    @IBOutlet weak var WeatherCollectionView: UICollectionView!
    @IBOutlet weak var egDaylable: UILabel!
    @IBOutlet weak var egMonthLable: UILabel!
    @IBOutlet weak var egYearLable: UILabel!
    
    @IBOutlet weak var arDaylable: UILabel!
    @IBOutlet weak var arMonthLable: UILabel!
    @IBOutlet weak var arYearLable: UILabel!
    
    @IBOutlet weak var fajrLable: UILabel!
    @IBOutlet weak var DhuhrLable: UILabel!
    @IBOutlet weak var AsrLable: UILabel!
    @IBOutlet weak var MahgrebLable: UILabel!
    @IBOutlet weak var IshaLable: UILabel!
    
    @IBOutlet weak var fajrLbl: UILabel!
    @IBOutlet weak var DhuhrLbl: UILabel!
    @IBOutlet weak var AsrLbl: UILabel!
    @IBOutlet weak var MahgrebLbl: UILabel!
    @IBOutlet weak var IshaLbl: UILabel!
    
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var TempLbl: UILabel!
    @IBOutlet weak var prayTimeLbl: UILabel!
    
    var locationManager = CLLocationManager()
    
    var currentDayindex = 0
    var currentDay = ""
    var WeekDay : [String] = [ "Saturday".localized , "Sunday".localized , "Monday".localized , "Tuesday".localized , "Wednesday".localized , "Thursday".localized , "Friday".localized ,"Saturday".localized]
    
    var index : [Int] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    var TempArray = [Temp]()
    var WeatherArray = [Weather]()
    var dtArray = [Int?]()
    
    override func viewWillAppear(_ animated: Bool) {
        self.MainView.isHidden = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        topTitle.text = "Pray times".localized
        fajrLbl.text = "Fajer".localized
        DhuhrLbl.text = "Dohr".localized
        AsrLbl.text = "Asr".localized
        MahgrebLbl.text = "Maghreb".localized
        IshaLbl.text = "Isha".localized
        TempLbl.text = "Temperatures".localized
        prayTimeLbl.text = "Pray times".localized
        
        print(NSDate().timeIntervalSince1970)
        
        WeatherCollectionView.delegate = self
        WeatherCollectionView.dataSource = self
        WeatherCollectionView.RegisterNib(cell:PrayCell.self)
        
        WeatherCollectionView.flipX()
        
        tabBarController?.tabBar.isHidden = true
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        setShadow(view: View1 , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        setShadow(view: View2 , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        setShadow(view: View3 , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        //  print(myDate.dayOfTheWeek())
        
        let hijriCalendar = Calendar(identifier: .islamicTabular)

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.calendar = hijriCalendar
        formatter.dateFormat = "dd"
        arDaylable.text = formatter.string(from: Date())
        
        
       
        egDaylable.text = "\(Date().today())"

        print(formatter.string(from: Date()))
        
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        tabBarController?.tabBar.isHidden = false
        dismiss(animated: true, completion: nil)
    }
    
}

extension Date {

   func today(format : String = "dd") -> String{
      let date = Date()
      let formatter = DateFormatter()
      formatter.dateFormat = format
      return formatter.string(from: date)
   }
}

//MARK:Collectionview

extension PrayTimeVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return TempArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PrayCell", for: indexPath) as! PrayCell
        
        cell.flipX()
        
        cell.CellbackGround.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        if indexPath.row == 0 {
            cell.CellbackGround.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.8039215686, blue: 0.9333333333, alpha: 0.07)
        }
        
        self.currentDayindex = index[indexPath.row]
        cell.dayLabel.text = "\(WeekDay[currentDayindex])"
        
        cell.tempLabel.text = "\(Int(self.TempArray[indexPath.row].max ?? 0.0))"
        cell.tempIcom.loadImage(URL(string: "http://openweathermap.org/img/wn/\(self.WeatherArray[indexPath.row].icon ?? "")@2x.png" ))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            var width = (collectionView.frame.width - 16) / 3
            
            return CGSize.init(width: width , height:collectionView.frame.height)
            
        }
    
}

extension PrayTimeVC {
    
    func getPrayTime() {
        
        self.view.lock()
        ApiServices.instance.getPostsOayer(methodType: .get, parameters: nil , url: "http://api.aladhan.com/v1/timings/\(NSDate().timeIntervalSince1970)?latitude=\(lat ?? "")&longitude=\(lng ?? "")&method=4") { (data : PrayTimeModel?, String) in
            self.view.unlock()
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                
                var arrayTimes : [String] = []
                
                arrayTimes.append(data.data?.timings?.fajr ?? "")
                arrayTimes.append(data.data?.timings?.dhuhr ?? "")
                arrayTimes.append(data.data?.timings?.asr ?? "")
                arrayTimes.append(data.data?.timings?.maghrib ?? "")
                arrayTimes.append(data.data?.timings?.isha ?? "")
                
                self.checkNextPray(PrayTime: arrayTimes)
                
                
                let now = Date()
                let dateFormatterr = DateFormatter()
                dateFormatterr.dateFormat = "LLLL"
                let nameOfMonth = dateFormatterr.string(from: now)
                
                if L102Language.currentAppleLanguage() == englishLang {
                    self.arMonthLable.text = data.data?.date?.hijri?.month?.en ?? ""
                    self.egMonthLable.text = data.data?.date?.gregorian?.month?.en ?? ""
                }else {
                    self.arMonthLable.text = data.data?.date?.hijri?.month?.ar ?? ""
                    self.egMonthLable.text = nameOfMonth
                }
                
               // self.egDaylable.text = data.data?.date?.gregorian?.day ?? ""
                self.egYearLable.text = data.data?.date?.gregorian?.year ?? ""
                
          //      self.arDaylable.text = data.data?.date?.hijri?.day ?? ""
                self.arYearLable.text = data.data?.date?.hijri?.year ?? ""
                
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                for (index,time) in arrayTimes.enumerated() {
                    dateFormatter.dateFormat = "HH:mm"
                    if let inDate = dateFormatter.date(from: time) {
                        dateFormatter.dateFormat = "hh:mm a"
                        let outTime = dateFormatter.string(from:inDate)
                        print("in \(time)")
                        print("out \(outTime)")
                        
                        arrayTimes[index] = outTime
                    }
                }
                
                var times : [String] = []
                for item in arrayTimes {
                    if item.contains("AM") {
                        if L102Language.currentAppleLanguage() == englishLang {
                            times.append("AM")
                        }else{
                            times.append("ص")
                        }
                        
                        print("صباحاً")
                    }else{
                        if L102Language.currentAppleLanguage() == englishLang {
                            times.append("PM")
                        }else{
                            times.append("م")
                        }
                        print("مساء")
                    }
                }
                
                self.fajrLable.text =  "\(arrayTimes[0].prefix(5)) \(times[0])"
                self.DhuhrLable.text = "\(arrayTimes[1].prefix(5)) \(times[1])"
                self.AsrLable.text = "\(arrayTimes[2].prefix(5)) \(times[2])"
                self.MahgrebLable.text = "\(arrayTimes[3].prefix(5)) \(times[3])"
                self.IshaLable.text = "\(arrayTimes[4].prefix(5)) \(times[4])"
                
                self.MainView.isHidden = false
                self.WeatherCollectionView.reloadData()
                print(data)
            }
            
        }
    }
    
    func checkNextPray(PrayTime : [String]) {
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        print(date , calendar)
        
        let CurrentTime = "\(hour):\(minutes)"
        
        var x = 0
        
        for item in PrayTime {
            
            
            let payerHour = item.prefix(2)
            let payerMen = item.suffix(2)
            
            print("Current = \(hour) : \(minutes)")
            print("NextPray = \(payerHour) : \(payerMen)")
            
            
            
            
            if (Double(hour)) <= (Double(payerHour) ?? 0.0) {
                
                if (Double(hour)) == (Double(payerHour))
                {
                    
                    if (Double(minutes)) <= (Double(payerMen) ?? 0.0)
                    {
                        switch x {
                        case 0:
                            self.fajrLbl.textColor = #colorLiteral(red: 0.224101156, green: 0.8023044467, blue: 0.9319550395, alpha: 1)
                            self.fajrLable.textColor = #colorLiteral(red: 0.224101156, green: 0.8023044467, blue: 0.9319550395, alpha: 1)
                            print("Fajer")
                            return
                        case 2:
                            self.DhuhrLbl.textColor = #colorLiteral(red: 0.224101156, green: 0.8023044467, blue: 0.9319550395, alpha: 1)
                            self.DhuhrLable.textColor = #colorLiteral(red: 0.224101156, green: 0.8023044467, blue: 0.9319550395, alpha: 1)
                            print("Dohr")
                            
                            return
                        case 3:
                            
                            self.AsrLbl.textColor = #colorLiteral(red: 0.224101156, green: 0.8023044467, blue: 0.9319550395, alpha: 1)
                            self.AsrLable.textColor = #colorLiteral(red: 0.224101156, green: 0.8023044467, blue: 0.9319550395, alpha: 1)
                            
                            print("Asr")
                            return
                        case 5:
                            self.MahgrebLbl.textColor = #colorLiteral(red: 0.224101156, green: 0.8023044467, blue: 0.9319550395, alpha: 1)
                            self.MahgrebLable.textColor = #colorLiteral(red: 0.224101156, green: 0.8023044467, blue: 0.9319550395, alpha: 1)
                            print("Maghreb")
                            return
                        case 6 :
                            self.IshaLbl.textColor = #colorLiteral(red: 0.224101156, green: 0.8023044467, blue: 0.9319550395, alpha: 1)
                            self.IshaLable.textColor = #colorLiteral(red: 0.224101156, green: 0.8023044467, blue: 0.9319550395, alpha: 1)
                            print("Isha")
                            return
                        default:
                            print("Not")
                            
                        }
                    }
                    
                } else {
                    
                    switch x {
                    case 0:
                        self.fajrLbl.textColor = #colorLiteral(red: 0.224101156, green: 0.8023044467, blue: 0.9319550395, alpha: 1)
                        self.fajrLable.textColor = #colorLiteral(red: 0.224101156, green: 0.8023044467, blue: 0.9319550395, alpha: 1)
                        print("Fajer")
                        return
                    case 2:
                        self.DhuhrLbl.textColor = #colorLiteral(red: 0.224101156, green: 0.8023044467, blue: 0.9319550395, alpha: 1)
                        self.DhuhrLable.textColor = #colorLiteral(red: 0.224101156, green: 0.8023044467, blue: 0.9319550395, alpha: 1)
                        print("Dohr")
                        
                        return
                    case 3:
                        
                        self.AsrLbl.textColor = #colorLiteral(red: 0.224101156, green: 0.8023044467, blue: 0.9319550395, alpha: 1)
                        self.AsrLable.textColor = #colorLiteral(red: 0.224101156, green: 0.8023044467, blue: 0.9319550395, alpha: 1)
                        
                        print("Asr")
                        return
                    case 5:
                        self.MahgrebLbl.textColor = #colorLiteral(red: 0.224101156, green: 0.8023044467, blue: 0.9319550395, alpha: 1)
                        self.MahgrebLable.textColor = #colorLiteral(red: 0.224101156, green: 0.8023044467, blue: 0.9319550395, alpha: 1)
                        print("Maghreb")
                        return
                    case 6 :
                        self.IshaLbl.textColor = #colorLiteral(red: 0.224101156, green: 0.8023044467, blue: 0.9319550395, alpha: 1)
                        self.IshaLable.textColor = #colorLiteral(red: 0.224101156, green: 0.8023044467, blue: 0.9319550395, alpha: 1)
                        print("Isha")
                        return
                    default:
                        print("Not")
                        
                    }
                }
            }
            else{
                
            }
            x = x + 1
        }
        
        
    }
    
    
    func getWeather() {
        self.view.lock()
        Alamofire.request("https://api.openweathermap.org/data/2.5/onecall?appid=0b547e03fd739c2a9a45508500b97204&lat=\(lat ?? "")&lon=\(lng ?? "")&lang=ar&exclude=current,minutely,hourly&units=metric", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON{ [self] response in
            
            
            self.view.unlock()
            
            let data = response.result.value! as? [String: Any]
            print(data)
            
            
            
            let arrayW = data?["daily"] as? NSArray
            
            
            print(arrayW)
            
            for item in arrayW ?? [] {
                let item = item as? NSDictionary
                
                self.dtArray.append(item!["dt"] as? Int)
                
                
                let weatherIt = item?["weather"] as? NSArray
                let weatherItme = weatherIt![0] as? NSDictionary
                let TempItme = item?["temp"] as? NSDictionary
                
                self.WeatherArray.append(Weather(id: weatherItme?["id"] as? Int, main: weatherItme?["main"] as? String, description: weatherItme?["description"] as? String, icon: weatherItme?["icon"] as? String))
                self.TempArray.append(Temp(day: TempItme?["day"] as? Double, min: TempItme?["min"] as? Double, max: TempItme?["max"] as? Double, night: TempItme?["night"] as? Double, eve: TempItme?["eve"] as? Double, morn: TempItme?["morn"] as? Double))
                
            }
            
            var x = 0
            for item in dtArray {
                if let weekday = getDayOfWeek(getDateFromTimeStamp(timeStamp: Double(dtArray[x] ?? 0))) {
                    index.append(weekday)
                    print(weekday)
                } else {
                    print("bad input")
                }
                x = x + 1
            }
            
            print(index)
            
            
            MainView.isHidden = false
            WeatherCollectionView.reloadData()
            
            
            
            
            
        }
    }
    
}

//Convirt timezoon
func getDateFromTimeStamp(timeStamp : Double) -> String {
    
    let date = NSDate(timeIntervalSince1970: timeStamp)
    
    let dayTimePeriodFormatter = DateFormatter()
    dayTimePeriodFormatter.dateFormat = "yyyy-MM-dd"
    // UnComment below to get only time
    //  dayTimePeriodFormatter.dateFormat = "hh:mm a"
    
    let dateString = dayTimePeriodFormatter.string(from: date as Date)
    return dateString
}

func getDayOfWeek(_ today:String) -> Int? {
    let formatter  = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    guard let todayDate = formatter.date(from: today) else { return nil }
    let myCalendar = Calendar(identifier: .gregorian)
    let weekDay = myCalendar.component(.weekday, from: todayDate)
    return weekDay
}


//MARK:- Protocol Controller

extension PrayTimeVC : ChooseLocation {
    func ChooseLocation(lat: Double, lng: Double, Address: String) {
        self.lat = "\(lat)"
        self.lng = "\(lng)"
        
        print(lat,lng)
        getWeather()
        
    }
}


extension PrayTimeVC: CLLocationManagerDelegate {
    
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
            
        case .notDetermined:
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
                print("locations = \(locValue.latitude) \(locValue.longitude)")
            
            self.lat = String(locValue.latitude)
            self.lng = String(locValue.longitude)
            
        case .authorizedAlways:
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
                print("locations = \(locValue.latitude) \(locValue.longitude)")
            self.lat = String(locValue.latitude)
            self.lng = String(locValue.longitude)
            getWeather()
            getPrayTime()
            
        case .authorizedWhenInUse:
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
                print("locations = \(locValue.latitude) \(locValue.longitude)")
            self.lat = String(locValue.latitude)
            self.lng = String(locValue.longitude)
            getWeather()
            getPrayTime()
            print("Location status is OK.")
        }
    }
}
