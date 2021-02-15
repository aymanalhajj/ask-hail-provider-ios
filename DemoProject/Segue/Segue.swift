//
//  File.swift
//  DemoProject
//
//  Created by Mohab on 3/14/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    
    func goVC(_ vc : String)  {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: vc)
        // present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func dismiss()  {
        navigationController?.popViewController(animated: true)
        //  dismiss(animated: true, completion: nil)
    }
    
    func showAnimate()
             {
                 self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                 self.view.alpha = 0.0;
                 UIView.animate(withDuration: 0.25, animations: {
                     self.view.alpha = 1.0
                     self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

                 });
             }

             func removeAnimate()
             {
                 UIView.animate(withDuration: 0.25, animations: {
                     self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                     self.view.alpha = 0.0;

                 }, completion:{(finished : Bool)  in
                     if (finished)
                     {
                         self.view.removeFromSuperview()
                     }
                 });
             }
      
}
