//
//  StarAdsCell.swift
//  DemoProject
//
//  Created by Abdullah Tarek on 10/28/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import FSPagerView


class  StarAdsCell: UICollectionViewCell {
    @IBOutlet weak var SpecialView: UIView!
    
    @IBOutlet weak var BackGroundImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var ViewsNumber: UILabel!
    @IBOutlet weak var SaveBtn: UIButton!
    
    @IBOutlet weak var SubView: UIView!
    var SaveAcrion : (()->())?
    
    var isSaved = false
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    @IBAction func SaveAction(_ sender: Any) {
        
        SaveAcrion?()
    }
}
