//
//  PickerSearchVC.swift
//  AskHailBusiness
//
//  Created by mohab mowafy on 11/06/2022.
//  Copyright © 2022 MOHAB. All rights reserved.
//

import Foundation
import UIKit

protocol Choose_search_key {
    func Choose_Search_key(id : String , name : String , searchtype : search_type)
}

enum search_type {
    case Region
    case City
    case Neighbour
}

class  PickerSearchVC: UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var SearchTf: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    var Delegate : Choose_search_key?
    
    var RegionArray : [RegionData] = []
    var CitArray : [CitiesData] = []
    var BlocksArray : [BlocksData] = []
    
    var Search_region_Array = [RegionData]()
    var Search_rcity_Array = [CitiesData]()
    var Search_Block_Array = [BlocksData]()
    
    var Search_type:search_type = .Region
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAnimate()
        tableView.RegisterNib(cell: SearchCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        
        SearchTf.delegate = self
        
        SearchTf.addTarget(self, action: #selector(PickerSearchVC.textDidChange(_:)),
                           for: .editingChanged)
        
        if L102Language.currentAppleLanguage() == arabicLang {
            SearchTf.textAlignment = .right
        }else {
            SearchTf.textAlignment = .left
        }
        

    }
    
    

     @objc func textDidChange(_ textField:UITextField) {

         if textField.text == "" {
             if Search_type == .Region {
                 Search_region_Array = RegionArray
             }else if Search_type == .City {
                 Search_rcity_Array = CitArray
             }else {
                 Search_Block_Array = BlocksArray
             }
         }else {
             
             
             if Search_type == .Region {
                 Search_region_Array.removeAll()
                 for item in RegionArray {
                     if (item.region_name?.contains(textField.text ?? "")) == true {
                         Search_region_Array.append(item)
                     }
                    
                 }
                 
         
             }else if Search_type == .City {
                 Search_rcity_Array.removeAll()
                 for item in CitArray {
                     if ((item.city_name?.contains(textField.text ?? "")) == true) {
                         
                         print(item.city_name , textField.text)
                         Search_rcity_Array.append(item)
                     }
                    
                 }
                 
             }else {
                 Search_Block_Array.removeAll()
                 for item in BlocksArray {
                     if ((item.block_name?.contains(textField.text ?? "")) == true) {
                         Search_Block_Array.append(item)
                     }
                    
                 }
             }
         }
         
         
         print(Search_region_Array)
         self.tableView.reloadData()
     }
    
    
   
    
    
    @IBAction func CancelAction(_ sender: Any) {
        removeAnimate()
    }
    
}

extension PickerSearchVC : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if Search_type == .Region {
            return Search_region_Array.count
        }else if Search_type == .City {
            return Search_rcity_Array.count
        }else {
            return Search_Block_Array.count
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeue() as SearchCell
        
        if Search_type == .Region {
            cell.titleLabel.text = Search_region_Array[indexPath.row].region_name
        }else if Search_type == .City {
            cell.titleLabel.text = Search_rcity_Array[indexPath.row].city_name
        }else {
            cell.titleLabel.text = Search_Block_Array[indexPath.row].block_name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        if Search_type == .Region {
            Delegate?.Choose_Search_key(id: "\(Search_region_Array[indexPath.row].region_id ?? 0)", name: Search_region_Array[indexPath.row].region_name ?? "", searchtype: Search_type)
        }else if Search_type == .City {
            Delegate?.Choose_Search_key(id: "\(Search_rcity_Array[indexPath.row].city_id ?? 0)", name: Search_rcity_Array[indexPath.row].city_name ?? "", searchtype: Search_type)
        }else {
            Delegate?.Choose_Search_key(id: "\(Search_Block_Array[indexPath.row].block_id ?? "")", name: Search_Block_Array[indexPath.row].block_name ?? "", searchtype: Search_type)
        }
        
        self.removeAnimate()
    }
    
    
    

    
}
