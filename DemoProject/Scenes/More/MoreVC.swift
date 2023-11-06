import UIKit
import BottomPopup


var IsMore = 0

class MoreVC: BottomPopupViewController {
    
    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        IsMore = 1
        
     NotificationCenter.default.post(name: Notification.Name(NotificationCenterpreeMoreAppear), object: nil)
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      
    }
   
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
       NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: NotificationCenterpressHomeLast)))
        
    }
    
    override func getPopupHeight() -> CGFloat {
        return height ?? CGFloat(300)
    }
    
    override func getPopupTopCornerRadius() -> CGFloat {
        return topCornerRadius ?? CGFloat(10)
    }
    
    override func getPopupPresentDuration() -> Double {
        return presentDuration ?? 0.6
    }
    
    override func getPopupDismissDuration() -> Double {
        return dismissDuration ?? 0.6
    }
    
    override func shouldPopupDismissInteractivelty() -> Bool {
        return true
    }
    
    
    @IBAction func MyAccountAction(_ sender: Any) {
        
        guard Helper.getapitoken() != nil else {
            alertSkipLogin()
            return
        }
        let storyboard = UIStoryboard(name: MyProfile, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "MyProfileVC")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
        
    }
    
    @IBAction func ContactUsAvtion(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: More, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func ServicesAction(_ sender: Any) {
        
        guard Helper.getapitoken() != nil else {
            alertSkipLogin()
            return
        }
        
        let storyboard = UIStoryboard(name: More, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "ServicesVC") as! ServicesVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func SettingAction(_ sender: Any) {
        
        guard Helper.getapitoken() != nil else {
            alertSkipLogin()
            return
        }
        
        let storyboard = UIStoryboard(name: More, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func RealStateAppAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: More, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "RealStateAppVC") as! RealStateAppVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func PhotographyRequestAvtion(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: More, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "PhotographyRequestVC") as! PhotographyRequestVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func TermsAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: More, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "TempVC") as! TempVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func ContrabandListAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: More, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "ContrabandListVC") as! ContrabandListVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func SheareAppAction(_ sender: Any) {
        
        shareApp()
        
    }
    
    @IBAction func AbouteAppAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: More, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "AboutAppVC") as! AboutAppVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    func shareApp(){
           let AppIdOnAppStore = 1549220122
           let firstActivityItem = ""
           //MARK: - for sare the App in App Store  use this commented line
           let secondActivityItem : NSURL = NSURL(string: "https://apps.apple.com/eg/app/ask-hail/\(AppIdOnAppStore)")!
           
           // If you want to put an image
           let image : UIImage = #imageLiteral(resourceName: "share-white")
           
           let activityViewController : UIActivityViewController = UIActivityViewController(
               activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
           
           // This lines is for the popover you need to show in iPad
           activityViewController.popoverPresentationController?.sourceView =  UIButton()
           
           // This line remove the arrow of the popover to show in iPad
           activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
           activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
           
           // Anything you want to exclude
           activityViewController.excludedActivityTypes = [
               UIActivity.ActivityType.postToWeibo,
               UIActivity.ActivityType.print,
               UIActivity.ActivityType.assignToContact,
               UIActivity.ActivityType.saveToCameraRoll,
               UIActivity.ActivityType.addToReadingList,
               UIActivity.ActivityType.postToFlickr,
               UIActivity.ActivityType.postToVimeo,
               UIActivity.ActivityType.postToTencentWeibo
           ]
           
           self.present(activityViewController, animated: true, completion: nil)
       }
}

