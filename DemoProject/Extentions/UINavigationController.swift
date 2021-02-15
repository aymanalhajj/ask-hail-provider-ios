//
//  UINavigationController.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/5/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}
