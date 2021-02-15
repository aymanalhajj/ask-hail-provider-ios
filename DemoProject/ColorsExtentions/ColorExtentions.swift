//
//  ColorExtentions.swift
//  DemoProject
//
//  Created by Mohab on 7/28/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
import UIKit


struct Colors {
    
    
    
    static let WhiteBlue = UIColor(hexString: "39CDEE"),
               DarkBlue = UIColor(hexString: "034B89"),
               lineView = UIColor(hexString: "39CDEE"),
               errorLineView = UIColor(hexString: "FF7994"),
               TopGradBtnColoer = UIColor(hexString: "6BE4FF"),
               ViewBackGroundColoer = UIColor(hexString: "#F5FDFF") ,
               ButtomGradBtnColoer = UIColor(hexString: "39CDEE"),
               PlaceHolderColoer = #colorLiteral(red: 0, green: 0.3139962554, blue: 0.5492177606, alpha: 0.5),
               AvilableColor = UIColor(hexString: "#49DB7F"),
               NotAvilableColor = UIColor(hexString: "#FF7A94")
    
               }

extension UIColor {
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}


extension UIColor {
    //For Display HTML Into String
    //    var hexString: String {
    //        let components = cgColor.components
    //        let r: CGFloat = components?[0] ?? 0.0
    //        let g: CGFloat = components?[1] ?? 0.0
    //        let b: CGFloat = components?[2] ?? 0.0
    //
    //        let hexString = String(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)),
    //                               lroundf(Float(b * 255)))
    //
    //        return hexString
    //    }
    
    
    
    func hexStringFromColor(color: UIColor) -> String {
        let components = color.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        
        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        print(hexString)
        return hexString
    }
    
    func colorWithHexString(hexString: String) -> UIColor {
        var colorString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        colorString = colorString.replacingOccurrences(of: "#", with: "").uppercased()
        
        print(colorString)
        let alpha: CGFloat = 1.0
        let red: CGFloat = self.colorComponentFrom(colorString: colorString, start: 0, length: 2)
        let green: CGFloat = self.colorComponentFrom(colorString: colorString, start: 2, length: 2)
        let blue: CGFloat = self.colorComponentFrom(colorString: colorString, start: 4, length: 2)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func colorComponentFrom(colorString: String, start: Int, length: Int) -> CGFloat {
        
        let startIndex = colorString.index(colorString.startIndex, offsetBy: start)
        let endIndex = colorString.index(startIndex, offsetBy: length)
        let subString = colorString[startIndex..<endIndex]
        let fullHexString = length == 2 ? subString : "\(subString)\(subString)"
        var hexComponent: UInt32 = 0
        
        guard Scanner(string: String(fullHexString)).scanHexInt32(&hexComponent) else {
            return 0
        }
        let hexFloat: CGFloat = CGFloat(hexComponent)
        let floatValue: CGFloat = CGFloat(hexFloat / 255.0)
        print(floatValue)
        return floatValue
    }
}
