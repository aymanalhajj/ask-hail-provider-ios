//
//  Extention+UIButton.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/9/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
import Foundation
import UIKit

class BackButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if L102Language.currentAppleLanguage() == arabicLang {
            self.setImage(#imageLiteral(resourceName: "back"), for: .normal)
            self.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }else {
            
            self.setImage(#imageLiteral(resourceName: "forward"), for: .normal)
            self.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}
class WiteBackButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if L102Language.currentAppleLanguage() == arabicLang {
            self.setImage(#imageLiteral(resourceName: "white-back"), for: .normal)
            self.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }else {
            
            self.setImage(#imageLiteral(resourceName: "back-1"), for: .normal)
            self.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}
