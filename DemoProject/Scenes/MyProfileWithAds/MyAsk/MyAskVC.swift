//
//  MyAskVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/13/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class MyAskVC: UIViewController {

    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var TopBar: UIView!
    @IBOutlet weak var TableView: UITableView!
    
    var AskHailArray : [AskData] = []
    var askData = false
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        TableView.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        TableView.dataSource = self
        TableView.delegate = self
        TableView.RegisterNib(cell: AskHailWithPhotoCell.self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var CurrentPage = 1
        var lastPage = 1
        AskHailArray.removeAll()
        getMyAsk()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func AddAskAvtion(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: AddAskHail, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "AskTermsVC") as! AskTermsVC
        navigationController?.pushViewController(vc, animated: true)

    }
    
}

//MARK:-TableView Controller
extension MyAskVC : UITableViewDelegate,UITableViewDataSource {
    
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
                    
                    self.getMyAsk()
                    
                }
            }
            
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AskHailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeue() as AskHailWithPhotoCell
        
        if askData {
            
            var Model = AskHailArray[indexPath.row]

            cell.CellName.isHidden = true
            if Model.question_show_name_status == "active" {
                cell.CellName.isHidden = false
                cell.CellName.text = Model.question_advertiser_name ?? ""
            }
            
            cell.IsNewView.isHidden = false
            if Model.question_date_status ?? "" == "" {
                cell.IsNewView.isHidden = true
            }
            
            cell.ImageHight.constant = 0
            if Model.question_image != "" {
                cell.askImage.loadImage(URL(string: Model.question_image ?? ""))
                cell.ImageHight.constant = 100
            }
            
            cell.CellTime.text = Model.question_custom_date ?? ""
            cell.CellTitle.text = Model.question_title ?? ""
            cell.cellHaveComment.text = Model.question_replies_text ?? ""
            
        }
        

        setShadow(view: cell, width: 5, height: 5, shadowRadius: 7, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.905375392, green: 0.905375392, blue: 0.905375392, alpha: 1))
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if AskHailArray[indexPath.row].question_image == "" {
            return 160
        }else{
            return 260
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let storyboard = UIStoryboard(name: AskHail, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "AskHailDetailsVC") as! AskHailDetailsVC
        if AskHailArray[indexPath.row].question_image == "" {
            vc.height = 0
        }else{
            
        }
        vc.ask_id = "\(AskHailArray[indexPath.row].question_id ?? 0)"
        vc.isMyAsks = 1
        
        navigationController?.pushViewController(vc, animated: true)
        
        return tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}


//MARK:-API

extension MyAskVC {
    
    func getMyAsk() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)business/my-questions?page=\(CurrentPage)") { (data : AskHailModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                self.CurrentPage = data.data?.pagination?.current_page ?? 1
                self.lastPage = data.data?.pagination?.last_page ?? 1
                
                for item in data.data?.data ?? [] {
                    self.AskHailArray.append(item)
                }
               
                self.TableView.isHidden = true

                if self.AskHailArray.count > 0 {
                    self.TableView.isHidden = false
                }
              
                self.askData = true
                
                self.TableView.reloadData()
                
                self.isActive = true
                
                print(data)
                
                
            }
        }
    }

    
    
}
