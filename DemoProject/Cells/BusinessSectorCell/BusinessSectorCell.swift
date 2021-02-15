//
//  BusinessSectorCell.swift
//  DemoProject
//
//  Created by Abdullah Tarek on 10/28/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class BusinessSectorCell: UICollectionViewCell {

    @IBOutlet weak var BackGroundImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        if L102Language.currentAppleLanguage() == englishLang {
            
            title.text = "Chalets, resorts and restrooms"
            
        }
        
    }
}
