import UIKit


class   HomeVC: BaseViewController {
    
    @IBOutlet weak var BackGroundView : UIView!
    @IBOutlet weak var TopBar: UIView!
    
    @IBOutlet weak var StopedAddBtn: UIButton!
    @IBOutlet weak var MyAdvTableView: UITableView!
    
    
    var MyAdvArray : [AdvData] = []
    
    var MyAdvData = false
    
    var isSaved = false
    
    var isActive = true
    
    private func createSpinnerFooter() -> UIView {
        let FooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        FooterView.backgroundColor = .clear
        let spinner = UIActivityIndicatorView()
        
        spinner.style = .large
        spinner.color = #colorLiteral(red: 0, green: 0.2846388221, blue: 0.497141242, alpha: 1)
        
        spinner.center = FooterView.center
        FooterView.addSubview(spinner)
        spinner.startAnimating()
        
        return FooterView
        
    }
    
    var CurrentPage = 1
    var lastPage = 1
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(showPopUp), name: NSNotification.Name(rawValue: NotificationCenterpreePlusBtn), object: nil)
        
        tabBarController?.tabBar.isHidden = false
        
        CurrentPage = 1
        lastPage = 1
        MyAdvArray.removeAll()
        getMyAds()
        
    }
    
    
    
    @IBOutlet weak var ScrollHeight: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Tajawal-Regular", size: 12)!], for: .normal)
        
        tabBarController?.tabBar.items?[0].title = "Home".localized
        tabBarController?.tabBar.items?[1].title = "Chat".localized
        tabBarController?.tabBar.items?[4].title = "More".localized
        tabBarController?.tabBar.items?[3].title = "Ask Hail".localized
        
        MyAdvTableView.backgroundColor = Colors.ViewBackGroundColoer

        MyAdvTableView.delegate = self
        MyAdvTableView.dataSource = self
        MyAdvTableView.RegisterNib(cell: BusinessSubAdsCell.self)
        
        MyAdvTableView.backgroundColor = Colors.ViewBackGroundColoer
        
        BackGroundView.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    @IBAction func NotificationAction(_ sender: Any) {
        
        guard Helper.getapitoken() != nil else {
            
            alertSkipLogin()
            return
        }
        
        let storyboard = UIStoryboard(name: Notification_Stry, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        // present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func PrayTimeAction(_ sender: Any) {
        
        guard Helper.getapitoken() != nil else {
            
            alertSkipLogin()
            return
        }
        
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "PrayTimeVC") as! PrayTimeVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func StopedAdvAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "StopedAdvVC") as! StopedAdvVC
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

//MARK:-TableView Conroller

extension HomeVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyAdvArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue() as BusinessSubAdsCell
        
        if MyAdvArray.count > indexPath.row {
            
            var Model = MyAdvArray[indexPath.row]
            
            cell.ImagesUrl = Model.adv_media ?? []
            cell.pageControl.numberOfPages =  Model.adv_media?.count ?? 0
            cell.PagerView.reloadData()
            cell.CellTitle.text = Model.adv_title
            cell.Price.text = Model.adv_price
            cell.distance.text = Model.adv_distance
            cell.ViewsNumber.text = Model.adv_views
            cell.CellRate.text = Model.adv_total_rate
                        
            if L102Language.currentAppleLanguage() == englishLang {
                cell.IsAvilabole.text = Model.adv_available_status
            } else {
                cell.IsAvilabole.text = Model.adv_available_custom_status
            }
            
            if MyAdvArray[indexPath.row].adv_media?.count ?? 0 == 0{
                cell.pageControl.isHidden = true
            }else{
                cell.pageControl.isHidden = false
            }
            
            if Model.adv_available_status ==  "available" {
                cell.IsAvilabole.textColor = #colorLiteral(red: 0.2862745098, green: 0.8588235294, blue: 0.4980392157, alpha: 1)
            }else{
                cell.IsAvilabole.textColor = #colorLiteral(red: 1, green: 0.4784313725, blue: 0.5803921569, alpha: 1)
            }
            
            cell.StarAdView.isHidden = true
            
            if Model.adv_special_status == "special" || Model.adv_special_status == "مميز" {
                cell.StarAdView.isHidden = false
            }
            
            cell.SaveAcrion = {
                
                self.AddToFavourite(advertisement_id: "\(Model.adv_id ?? 0)")
                
                if Model.adv_is_favorite == false {
                    cell.SaveBtn.setBackgroundImage(UIImage(named: "save_white-1"), for: .normal)
                    Model.adv_is_favorite = true
                }else{
                    cell.SaveBtn.setBackgroundImage(UIImage(named: "save_white"), for: .normal)
                    Model.adv_is_favorite = false
                }
                
            }
            
            cell.SelectCell = {
                
                let storyboard = UIStoryboard(name: Home, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "BusinessAdsDetailsVC") as! BusinessAdsDetailsVC
                vc.AdId = "\(self.MyAdvArray[indexPath.row].adv_id ?? 0)"
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "BusinessAdsDetailsVC") as! BusinessAdsDetailsVC
        vc.AdId = "\(MyAdvArray[indexPath.row].adv_id ?? 0)"
        navigationController?.pushViewController(vc, animated: true)
        
        return tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let ContentHeight = scrollView.contentSize.height
        // print(position , tableView.contentSize.height)
        if isActive {
            if position > ContentHeight - scrollView.frame.height {
                
                print("Done")
                isActive = false
                
                //numberofitem
                
                //  print(CurrentPage , lastPage)
                if CurrentPage < lastPage {
                    
                    CurrentPage = CurrentPage + 1
                    
                    self.getMyAds()
                    
                }
            }
            
        }
        
    }
}

//MARK:-API
extension HomeVC {
    
    func getMyAds() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters:nil , url: "\(hostName)business/my-advertisements") { (data : MyAdvModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                print(data.data?.if_have_blocked_advertisements ?? false)
                if data.data?.if_have_blocked_advertisements ?? false == true {
                    self.StopedAddBtn.isHidden = false
                }else{
                    self.StopedAddBtn.isHidden = true
                }
                
                self.CurrentPage = data.data?.pagination?.current_page ?? 1
                self.lastPage = data.data?.pagination?.last_page ?? 1
                
                self.MyAdvTableView.isHidden = true

                if data.data?.advertisements_count != "0" {
                    
                    for item in data.data?.data ?? [] {
                        self.MyAdvArray.append(item)
                    }
                    
                    self.MyAdvData = true
                    self.MyAdvTableView.isHidden = false
                    self.MyAdvTableView.reloadData()
                    
                    self.isActive = true
                    
                }
                
                print(data)
                
            }
        }
    }
    
    
    func AddToFavourite(advertisement_id : String) {
        
        //  self.view.lock()
        
        let param = [
            
            "advertisement_id" : advertisement_id
            
        ]
        
        
        ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)advertisement-operations/add-remove-favorite") { (data : ContactUsModel?, String) in
            //self.view.unlock()
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                //   self.StarAdsCollection.reloadData()
                
                
                print(data)
                
                
            }
        }
    }
    
}
