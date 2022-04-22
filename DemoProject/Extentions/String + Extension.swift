//
//  1.swift
//  TYOUT
//
//  Created by Ali Hamed on 9/25/18.
//  Copyright © 2018 Gra7. All rights reserved.
//

import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}

extension UILabel {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
}

extension UIButton {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .normal)
        }
    }
}

extension UITextField {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            placeholder = key?.localized
        }
    }
}
