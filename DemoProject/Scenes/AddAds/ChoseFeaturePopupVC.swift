//
//  ChoseFeaturePopupVCViewController.swift
//  AskHail
//
//  Created by bodaa on 16/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit

protocol ChoseFromFeature {
    func choseFeature(data : Feature_data , index : Int)
}

class ChoseFeaturePopupVC: UIViewController {

    @IBOutlet weak var ConfirmBtn: UIButton!
    @IBOutlet weak var PageTitleLbl: UILabel!
    
    
    var Delegte : ChoseFromFeature?
    var FeatureData : [Feature_data] = []
    var selectedIndex : Int?
    var pageTitle = ""
    
   var index = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PageTitleLbl.text = pageTitle
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.RegisterNib(cell: ChoseDetailsCell.self)
        
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        

        showAnimate()
        
    }
    
    @IBAction func BackAction(_ sender: Any) {
        removeAnimate()
    }
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        if selectedIndex != nil {
            removeAnimate()
            Delegte?.choseFeature(data: FeatureData[selectedIndex ?? 0], index: index)
        }else {
            self.showAlertWithTitle(title: "", message: "you should select feature", type: .error)
            
            
        }
        
      
    }
    
}

extension ChoseFeaturePopupVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FeatureData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as ChoseDetailsCell
        cell.CellTitle.text = FeatureData[indexPath.row].data_title
        
        cell.CellBtn.setImage(#imageLiteral(resourceName: "check"), for: .normal)
        if selectedIndex == indexPath.row {
            cell.CellBtn.setImage(#imageLiteral(resourceName: "check-1"), for: .normal)
        }
        
        cell.ChoseCell = {
            cell.CellBtn.setImage(#imageLiteral(resourceName: "check"), for: .normal)
            if self.selectedIndex == indexPath.row {
                cell.CellBtn.setImage(#imageLiteral(resourceName: "check-1"), for: .normal)
            }
            self.selectedIndex = indexPath.row
            self.tableView.reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.row
        tableView.reloadData()
        
        return tableView.deselectRow(at: indexPath, animated: true)
    }
}
