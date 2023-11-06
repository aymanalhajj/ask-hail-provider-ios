//
//  ChatVC.swift
//  AskHail
//
//  Created by Mohab on 11/17/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import SocketIO
import IQKeyboardManager


class chatVC: UIViewController , UITextFieldDelegate{
    
    var refreshControl = UIRefreshControl()
    
    @IBOutlet weak var ChatTitle: UILabel!
    
    
   
    @IBOutlet weak var OtherName: UILabel!
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var LineView: UIView!
    
    @IBOutlet weak var ShowAdvBtn: UIButton!
    @IBOutlet weak var senImage: UIImageView!
    @IBOutlet weak var messageTF: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var ShowAdvContanier: UIView!
    @IBOutlet weak var ShowAdvView: UIView!
    
    var ChatTypeId = 0
    var ChatType = ""
    
    var isLoading = false
    var isSubView = 0
    
    var chat_id = ""
    
    
    var isMessages = 0
    
    
    var ChatArray : [Messages_data] = []
    var ChatData = false
    
    
    var s: SocketIOClient!
    var manager:SocketManager!
    
    let SocketUrl = "https://chat.askhail.com"
    
    var chat_type_id = ""
    var chat_type = ""
    
    var isActive = true
    
    
    var localMessage = [LocalMessage]()
    
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
    
    @IBOutlet weak var Viewbottom: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if  DynamicLinkModel.Product_id != "" {
            
            self.chat_type_id = DynamicLinkModel.Product_id
            self.isMessages = 1
            DynamicLinkModel.Product_id = ""
            
        }
        
        
        tabBarController?.tabBar.isHidden = true
        
        setShadow(view: messageView, width: 2, height: 2, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7002318268, green: 0.7002318268, blue: 0.7002318268, alpha: 1))
        
        setShadow(view: ShowAdvView, width: 5, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7002318268, green: 0.7002318268, blue: 0.7002318268, alpha: 1))
        
        messageTF.delegate = self
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.RegisterNib(cell: SenderCell.self)
        tableView.RegisterNib(cell: ReceverCell.self)
        
       // loaderView.backgroundColor = Colors.ViewBackGroundColoer
        
        unLockScreen()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        IQKeyboardManager.shared().isEnabled = true
    }
    override func viewWillAppear(_ animated: Bool) {
        ShowAdvContanier.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(unLockScreen), name: Notification.Name(Notification_Unlock_Screen), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LockScreen), name: Notification.Name(Notification_lock_Screen), object: nil)
        
        IQKeyboardManager.shared().isEnabled = false
        
    }
    
    
    
    
    @objc func unLockScreen(){
        
        CurrentPage = 1
        lastPage = 1
        ChatArray.removeAll()
        localMessage.removeAll()
        if !isLoading {
            isLoading = true
            getChatData()
            SetupSocket()
        }
        
    }
    
    @objc func keyboardShow(notification: NSNotification){
        guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        self.Viewbottom.constant = self.view.convert(keyboardFrame.cgRectValue, from: nil).size.height - 16
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.ChatArray.count-1, section: 0)
            if self.ChatArray.count > 0{
                
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
            
        }
    }
    
    @objc func keyboardHide(){
        
        self.Viewbottom.constant = 16
        
    }
    
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            
            if self.localMessage.count > 0 , self.ChatArray.count > 0 {
                
                let indexPath = IndexPath(row: self.ChatArray.count + self.localMessage.count - 2 , section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }else if self.ChatArray.count > 0 {
                
                let indexPath = IndexPath(row: self.ChatArray.count - 1 , section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }else if self.localMessage.count > 0 {
                
                let indexPath = IndexPath(row: self.localMessage.count - 1 , section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
          
            
        
        }
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.refreshControl.endRefreshing()
    }
    
    @IBAction func SendAction(_ sender: Any) {
        
        
        
        guard messageTF.text != "" else {
            return
        }
        
        let date = Date()
        let calendar = Calendar.current
        var hour = calendar.component(.hour, from: date)
        var minutes = calendar.component(.minute, from: date)
        
        var time = ""
        
        if hour < 9 , minutes < 9 {
            time = "0\(hour):0\(minutes)"
            
        }else if hour < 9 , minutes > 9 {
            
            time = "0\(hour):\(minutes)"
        }else if hour > 9 , minutes > 9 {
            
            time = "\(hour):\(minutes)"
        }else {
            time = "\(hour):0\(minutes)"
            
        }
        
        localMessage.append(LocalMessage(message: messageTF.text ?? "", message_date: "\(time)"))
        self.tableView.reloadData()
        self.scrollToBottom()
        
        let jsonDic = ["lang":L102Language.currentAppleLanguage() , "message":messageTF.text ?? "" , "api_token":Helper.getapitoken() ?? "" , "chat_id" : self.chat_id] as [String : Any]
        self.s.emit("send-message", jsonDic)
        
        messageTF.text = ""
        sendBtn.setImage(#imageLiteral(resourceName: "send"), for: .normal)
        
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        EnableLineAnimite(text: messageTF, ImageView: senImage, imageEnable: #imageLiteral(resourceName: "send"), lineView: LineView, ishidden: false)
        return true;
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        EnableLineAnimite(text: messageTF, ImageView: senImage, imageEnable: #imageLiteral(resourceName: "send"), lineView: LineView, ishidden: true)
        return true;
    }
    
    
    @IBAction func BackAction(_ sender: Any) {
        LockScreen()
        if DynamicLinkModel.isDynamic {
            DynamicLinkModel.isDynamic = false
            guard let window = UIApplication.shared.keyWindow else{return}
            let sb = UIStoryboard(name: Home, bundle: nil)
            var vc : UIViewController
            vc = sb.instantiateViewController(withIdentifier: "HomeVC")
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
            
        }
        
        switch isSubView {
        case 1:
            navigationController?.popViewController(animated: true)
        case 2:
            navigationController?.popViewController(animated: true)
        default:
            tabBarController?.tabBar.isHidden = false
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    @IBAction func ShowAdv(_ sender: Any) {
       
            
            let storyboard = UIStoryboard(name: Home, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "BusinessAdsDetailsVC") as! BusinessAdsDetailsVC
        print("\(ChatTypeId)")
            vc.AdId = "\(ChatTypeId)"
            navigationController?.pushViewController(vc, animated: true)
       
        print(ChatType)
    }
    
    @IBAction func ShowAdvAction(_ sender: Any) {
        
        ShowAdvContanier.isHidden = false
        
    }
    
    @IBAction func CancelAction(_ sender: Any) {
        
        ShowAdvContanier.isHidden = true
        
    }
    
}

//MARK:TableView Contoller

extension chatVC : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChatArray.count + localMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
//        if indexPath.row < localMessage.count {
//
//            let cell = tableView.dequeue() as SenderCell
//
//            setShadow(view: cell.bgView, width: 2, height: 2, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7002318268, green: 0.7002318268, blue: 0.7002318268, alpha: 1))
//
//
//                cell.CellMessge.text = localMessage[indexPath.row]
//            cell.CellMessge.backgroundColor = .red
//               // cell.CellTime.text = Model.message_custom_date ?? ""
//
//
//            return cell
//
//        }
//        var index = 0
//        if localMessage.count > 0 {
//
//            index = (localMessage.count)
        
        
//        }
        
        let cell = tableView.dequeue() as SenderCell
        
     
        
        if indexPath.row < self.ChatArray.count {
            let Model = ChatArray[indexPath.row]
            
            if "\(Model.message_sender_id ?? 0)" == Helper.getaUser_id() {
                
                
                
                setShadow(view: cell.bgView, width: 1, height: 1, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 1))
                
                if ChatData {
                    cell.CellMessge.text = Model.message_text ?? ""
                    cell.CellTime.text = Model.message_custom_date ?? ""
                }
                
                return cell
                
            }else {
                
                let cell = tableView.dequeue() as ReceverCell
                setShadow(view: cell.bgView, width: 1, height: 1, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.863816314, green: 0.863816314, blue: 0.863816314, alpha: 1))
                
                if ChatData {
                    cell.CellMessge.text = Model.message_text ?? ""
                    cell.CellTime.text = Model.message_custom_date ?? ""
                }
                
                return cell
                
            }
            
        }else {
            
           
            
            setShadow(view: cell.bgView, width: 2, height: 2, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7002318268, green: 0.7002318268, blue: 0.7002318268, alpha: 1))
            
            if ChatData {
                cell.CellMessge.text = self.localMessage[indexPath.row - ChatArray.count].message
             
                cell.CellTime.text = self.localMessage[indexPath.row - ChatArray.count].message_date
            }
            
            return cell
            
            
        }
        
     
            
     
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging")
        if (tableView.contentOffset.y < 0)
        {
            if isActive{
                if CurrentPage < lastPage {
                    self.isActive = false
                    CurrentPage = CurrentPage + 1
                    self.getChatData()
                }
                
            }
        }
    }
}

//MARK:SETUPSocket


extension chatVC {
    
    @objc func LockScreen(){
        let jsonDic = ["chat_id": chat_type_id, "api_token" : Helper.getapitoken() ?? ""] as [String : Any]
        
        print(jsonDic)
        self.s.emit("close-chat", jsonDic)
        s.disconnect()
        
    }
    
    func SetupSocket(){
        manager = SocketManager(socketURL: URL(string:SocketUrl)!, config: [.log(false), .compress])
        
        s = manager.defaultSocket
        
        s.on(clientEvent: .connect) {data, ack in
            print("socket connected")
            DispatchQueue.main.async {
                self.sendBtn.isEnabled = true
            }
            
            
            if self.isMessages == 1{
                let jsonDic = ["chat_id":self.chat_type_id , "api_token":Helper.getapitoken() ?? ""] as [String : Any]
                self.s.emit("open-chat-way-1", jsonDic)
                
               
            }else {
                let jsonDic = ["chat_type":self.chat_type , "chat_type_id":self.chat_type_id , "api_token":Helper.getapitoken() ?? ""] as [String : Any]
                self.s.emit("open-chat-way-2", jsonDic)
            }
            
        }
        
        s.on(clientEvent: .error) {data, ack in
            print("socket error")
        }
        
        s.on(clientEvent: .disconnect) {data, ack in
            DispatchQueue.main.async {
                self.sendBtn.isEnabled = true
            }
           
            
            print("socket disconnect")
        }
        
        self.s.on("send-message-\(self.chat_id)") { (data: Messages_data?) in
            
            

            print(data)
            guard let data = data else {
                
                return
            }
            
            if self.localMessage.count > 0 {
                self.localMessage.remove(at: self.localMessage.count-1)
            }
            
           
            
            
            self.ChatArray.append(data)
            
            self.tableView.reloadData()
            
            self.scrollToBottom()
            
        }
        
        
        
        s.connect()
        
        
        
        
    }
}

//MARK:API

class DictionaryEncoder {
    var result: [String: Any]
    
    init() {
        result = [:]
    }
    
    func encode(_ encodable: DictionaryEncodable) -> [String: Any] {
        encodable.encode(self)
        return result
    }
    
    func encode<T, K>(_ value: T, key: K) where K: RawRepresentable, K.RawValue == String {
        result[key.rawValue] = value
    }
}

protocol DictionaryEncodable {
    func encode(_ encoder: DictionaryEncoder)
}

extension chatVC {
    
    func getChatData() {
        self.view.lock()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        if self.isActive {
            self.CurrentPage = 1
        }
        
        var param = [String : AnyObject]()
        
        if self.isMessages == 1 {
            param["chat_id"] = chat_type_id as AnyObject
        } else {
            param["chat_type"] = chat_type as AnyObject
            param["chat_type_id"] = chat_type_id as AnyObject
            
            
            
        }
        
        
        
        print(param)
        
        
        print("\(hostName)chat-operations/open-chat?page=\(CurrentPage)")
        ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)chat-operations/open-chat?page=\(CurrentPage)") { (data : ChatModel?, String) in
        
            self.view.unlock()
            
            if String != nil {
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.CurrentPage = data.data?.messages_pagination?.current_page ?? 1
                self.lastPage = data.data?.messages_pagination?.last_page ?? 1
                
                for item in data.data?.messages_data?.reversed() ?? []{
                    self.ChatArray.append(item)
                }
                
                print(data.data?.chat_details?.chat_id)
                self.isMessages = 1
                
                self.chat_id = "\(data.data?.chat_details?.chat_id ?? 0)"
                self.chat_type_id =  "\(data.data?.chat_details?.chat_id ?? 0)"
                self.ChatTitle.text = data.data?.chat_details?.chat_title ?? ""
                self.OtherName.text = data.data?.chat_details?.chat_other_name
                self.SetupSocket()
                self.ChatTypeId =  data.data?.chat_details?.chat_adv_order_id ?? 0
                self.ChatType = "\(data.data?.chat_details?.chat_type ?? "")"
                self.ChatData = true
                self.tableView.reloadData()
                
                if self.ChatType == "order" {
                    
                    self.ShowAdvBtn.setTitle("Show Order details".localized, for: .normal)
                }else {
                    self.ShowAdvBtn.setTitle("Show ad details".localized, for: .normal)
                }
                
                if self.isActive {
                    self.scrollToBottom()
                }
               
                self.isActive = true
                self.isLoading = false
                
                print(data)
                
                
            }
        }
    }
    
}

//MARK:Socket
extension String {
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

extension SocketIOClient {
    
    func on<T: Decodable>(_ event: String, callback: @escaping (T)-> Void) {
        self.on(event) { (data, _) in
            
            print(data)
            
            guard !data.isEmpty else {
                //                print("[SocketIO] \(event) data empty")
                return
            }
            
            
            
            print(data[0])
            
            guard  let data  = data[0] as? String else {
                
                return
            }
            
            print(data.convertToDictionary())
            
            guard let list = data.convertToDictionary() else {
                
                return
            }
            
            
            print(list)
            
            guard let decoded = try? T(from: list["data"]) else {
                //                print("[SocketIO] \(event) data \(data) cannot be decoded to \(T.self)")
                return
            }
            
            
            
            //            debugPrint(decoded)
            
            callback(decoded)
        }
    }
}

extension Decodable {
    init(from any: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: any)
        self = try JSONDecoder().decode(Self.self, from: data)
    }
}
