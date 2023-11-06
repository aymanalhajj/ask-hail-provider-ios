//
//  UIText.swift
//  AskHail
//
//  Created by Abdullah Tarek on 10/30/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import Foundation
import UIKit


//func  AddSpacing(_ text : UILabel ,_ fontSize :
//                    CGFloat,_ color1 : UIColor ,_ color2 : UIColor ,_ lineSpacing : CGFloat) -> String  {
//
//    let Lable = UILabel()
//    Lable.text = ""
//
//    let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Tajawal-Bold", size: fontSize), NSAttributedString.Key.foregroundColor : color1]
//
//    let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Tajawal-Bold", size: fontSize), NSAttributedString.Key.foregroundColor : color2]
//
//    let attributedString1 = NSMutableAttributedString(string:text.text ?? "", attributes:attrs1)
//
//    let attributedString2 = NSMutableAttributedString(string:"", attributes:attrs2)
//
//    let paragraphStyle = NSMutableParagraphStyle()
//    paragraphStyle.lineSpacing = lineSpacing
//
//    attributedString1.addAttribute(
//        .paragraphStyle,
//        value: paragraphStyle,
//        range: NSRange(location: 0, length: attributedString1.length
//        ))
//
//    attributedString2.addAttribute(
//        .paragraphStyle,
//        value: paragraphStyle,
//        range: NSRange(location: 0, length: attributedString2.length
//        ))
//
//    attributedString1.append(attributedString2)
//    Lable.attributedText = attributedString1
//
//    return Lable.text!
//}

func  AddSpacing(_ text : String ,_ text2 : String ,_ fontSize : CGFloat,_ color1 : UIColor ,_ color2 : UIColor ,_ lineSpacing : CGFloat) -> UILabel {
    
    let Lable = UILabel()
    Lable.text = ""
    
    let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Tajawal-Bold", size: fontSize), NSAttributedString.Key.foregroundColor : color1]
    
    let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Tajawal-Bold", size: fontSize), NSAttributedString.Key.foregroundColor : color2]
    
    let attributedString1 = NSMutableAttributedString(string:text ?? "", attributes:attrs1)
    
    let attributedString2 = NSMutableAttributedString(string:text2 ?? "", attributes:attrs2)
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = lineSpacing
    
    attributedString1.addAttribute(
        .paragraphStyle,
        value: paragraphStyle,
        range: NSRange(location: 0, length: attributedString1.length
        ))
    
    attributedString2.addAttribute(
        .paragraphStyle,
        value: paragraphStyle,
        range: NSRange(location: 0, length: attributedString2.length
        ))
    
    attributedString1.append(attributedString2)
    Lable.attributedText = attributedString1
    
    return Lable
}

extension Data {
    
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}
extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
    
}
