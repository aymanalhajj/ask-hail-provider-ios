//
//  AddDetailsCell.swift
//  AskHail
//
//  Created by bodaa on 16/01/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit

class AddDetailsCell: UICollectionViewCell, UITextFieldDelegate {

    @IBOutlet weak var DetailTf: UITextField!
    @IBOutlet weak var DetailLineView: NSLayoutConstraint!
    @IBOutlet weak var ChoseDetailsBtn: UIButton!
    @IBOutlet weak var LineView: UIView!
    @IBOutlet weak var arrow_doun: UIImageView!
    
    var ChoseDetails : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        DetailTf.placeHolderColor = Colors.PlaceHolderColoer
        DetailTf.delegate = self
        DetailTf.setPadding(left: 16, right: 16)
        
    }
    
    @IBAction func ChoseAvtion(_ sender: Any) {
        ChoseDetails?()
    }
    
}
