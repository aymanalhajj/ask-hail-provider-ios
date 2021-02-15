//
//  ContractCell.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/2/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class ContractCell: UITableViewCell {
    
    @IBOutlet weak var contreactTitle: UILabel!
    @IBOutlet weak var Datelbl: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var LineView: UIView!
    
    var DownloadFile : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func DownloadAction(_ sender: Any) {
        
        DownloadFile?()
        
    }
}
