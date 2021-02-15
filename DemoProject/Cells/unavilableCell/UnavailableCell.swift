//
//  UnavailableCell.swift
//  AskHailBusiness
//
//  Created by bodaa on 09/02/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit

class UnavailableCell: UICollectionViewCell {

    @IBOutlet weak var unavailable_duration_start_date: UILabel!
    @IBOutlet weak var unavailable_duration_days: UILabel!
    @IBOutlet weak var unavailable_duration_available_after_days: UILabel!
    
    var DeleteState : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func DeleteStateAction(_ sender: Any) {
        
        DeleteState?()
        
    }
}
