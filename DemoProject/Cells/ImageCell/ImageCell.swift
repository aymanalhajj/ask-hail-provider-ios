//
//  ImageCell.swift
//  AskHail
//
//  Created by bodaa on 01/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var CellImage: UIImageView!
    @IBOutlet weak var cellBtn: UIButton!
    @IBOutlet weak var VideotimeView: UIView!
    
    @IBOutlet weak var VideoTime: UILabel!
    
    
    var CellButton : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func CancelAction(_ sender: Any) {
        
        CellButton?()
        
    }
    

}
