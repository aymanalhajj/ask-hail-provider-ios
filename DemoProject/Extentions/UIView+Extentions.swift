//
//  UIView+Extentions.swift
//  DemoProject
//
//  Created by Mohab on 4/1/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import JHSpinner
typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

enum GradientOrientation {
    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical
    
    var startPoint : CGPoint {
        return points.startPoint
    }
    
    var endPoint : CGPoint {
        return points.endPoint
    }
    
    var points : GradientPoints {
        switch self {
        case .topRightBottomLeft:
            return (CGPoint(x: 0.0,y: 1.0), CGPoint(x: 1.0,y: 0.0))
        case .topLeftBottomRight:
            return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 1,y: 1))
        case .horizontal:
            return (CGPoint(x: 0.0,y: 0.5), CGPoint(x: 1.0,y: 0.5))
        case .vertical:
            return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 0.0,y: 1.0))
        }
    }
}


extension UIView {
    
    func flipX() {
            transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
        
        
        func flipY() {
            transform = CGAffineTransform(scaleX: transform.a, y: -transform.d)
        }
    

        func addShadowImage(parentview:UIView){
            
            //  ADD Shadow right &Bottom & left
            parentview.layer.shadowColor = UIColor.lightGray.cgColor
            parentview.layer.masksToBounds = false
            parentview.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            parentview.layer.shadowOpacity = 0.5
            parentview.layer.shadowRadius = 3.0
            
    //        //for bottom shadow on view
    //        parentview.layer.shadowOffset = CGSize(width: 0.0,height: 1.0)
    //        parentview.layer.shadowOpacity = 0.7
    //        parentview.layer.shadowRadius = 1.0
            
    //        //for bottom and right sides shadow on view
    //        parentview.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    //        parentview.layer.shadowOpacity = 1
    //        parentview.layer.shadowRadius = 1.0
    //
    //
    //        //for empty shadow on view
    //        parentview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    //        parentview.layer.shadowOpacity = 1
    //        parentview.layer.shadowRadius = 0
    //
    //        //for bottom and right and left sides shadow on view
    //        parentview.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    //        parentview.layer.shadowOpacity = 1
    //        parentview.layer.shadowRadius = 2.0
    //
    //        //for four sides shadow on view
    //        parentview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    //        parentview.layer.shadowOpacity = 1.0
    //        parentview.layer.shadowRadius = 5.0
        }
    
    
    func anchor(top :NSLayoutYAxisAnchor? , left : NSLayoutXAxisAnchor? , right : NSLayoutXAxisAnchor? , bottom : NSLayoutYAxisAnchor? , paddingtop : CGFloat , paddingleft : CGFloat , paddingright : CGFloat , paddingbottom : CGFloat , width : CGFloat , height : CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingtop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingleft).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: paddingright).isActive = true
        }
        
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingbottom).isActive = true
        }
        
        if width != 0 {
            
            widthAnchor.constraint(equalToConstant: width).isActive = true
            
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
  
        
        func setGradientLeftToRight(ColorLeft:CGColor,ColorRight:CGColor) {
            
            let gradientLayer = CAGradientLayer()
            // gradientLayer.frame = navigationBar.bounds
            gradientLayer.colors = [ColorLeft, ColorRight]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            
            gradientLayer.frame = self.bounds
            self.layer.insertSublayer(gradientLayer, at:0)
            
        }
    
    func setGradientTopToButtom(ColorTop:UIColor,ColorButtom:UIColor) {
        
        let gradientLayer = CAGradientLayer()
        // gradientLayer.frame = navigationBar.bounds
        gradientLayer.colors = [ColorTop.cgColor, ColorButtom.cgColor]
        gradientLayer.locations = [0.0,1.0]
        
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at:0)
    }
  
    @IBInspectable var shadowOffset: CGSize{
        get{
            return self.layer.shadowOffset
        }
        set{
            self.layer.shadowOffset = newValue
        }
    }
    func applyGradient(withColours colours: [UIColor], locations: [NSNumber]? = nil) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func applyGradient(withColours colours: [UIColor], gradientOrientation orientation: GradientOrientation) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        self.layer.insertSublayer(gradient, at: 0)
    }
    @IBInspectable var shadowColor: UIColor{
        get{
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set{
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    func removeNoDataLabel(tag: Int = 10000){
        if let noDataLabel = self.viewWithTag(tag) {
            UIView.animate(withDuration: 0.2, animations: {
                noDataLabel.alpha = 0.0
            }) { finished in
                noDataLabel.removeFromSuperview()
            }
        }
    }
    
    func setNoDataLabel(text: String, frameRect: CGRect = CGRect.zero, withBackgroundColor backgroundColor: UIColor =  UIColor(white: 0.0, alpha: 0.2), textColor: UIColor = UIColor.black ){
        let containerView = UIView()
        let label = UILabel()
        
        let imageQuestion = UIImageView()
       
        
      imageQuestion.image = #imageLiteral(resourceName: "logo")
        
        imageQuestion.frame.size.width = 60
        imageQuestion.frame.size.height = 60
        
        if frameRect == CGRect.zero{
            containerView.frame = bounds
        }
        else{
            containerView.frame = frameRect
        }
        containerView.tag = 10000
        containerView.backgroundColor = self.backgroundColor
       
        label.frame = containerView.bounds
        label.frame.size.width =  containerView.frame.size.width
        label.numberOfLines = 0
        label.backgroundColor = self.backgroundColor
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.6420239806, green: 0.4872599244, blue: 0.4761152267, alpha: 1)
        label.text = text
        label.font.withSize(20)
      imageQuestion.image = #imageLiteral(resourceName: "logo")
        imageQuestion.frame = containerView.bounds
        
        
        containerView.addSubview(imageQuestion)
        containerView.addSubview(label)
        
        addSubview(containerView)
        
        imageQuestion.anchor(top: containerView.centerYAnchor , left: containerView.centerXAnchor, right: nil, bottom: nil, paddingtop: -60 , paddingleft: -40, paddingright: 0, paddingbottom: 0, width: 80, height: 80)
        label.anchor(top: imageQuestion.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, bottom: nil, paddingtop: 16, paddingleft: 0, paddingright: 0, paddingbottom: 0, width: 0, height: 30)
            
            imageQuestion.backgroundColor = #colorLiteral(red: 0.07960281521, green: 0.1419835687, blue: 0.3420339823, alpha: 0)
    }
    func lock(frameRect: CGRect = CGRect.zero) {
        if (viewWithTag(10) != nil) {
            //View is already locked
        }
        else {
            let lockView = UIView()
            
            if frameRect == CGRect.zero{
                lockView.frame = bounds
            }
            else{
                lockView.frame = frameRect
            }
            
            lockView.backgroundColor = UIColor(white: 0.5, alpha: 0.3)
            
            lockView.tag = 10
            lockView.alpha = 0.0
            
            
            
            //            let activityIndicator = UIActivityIndicatorView(frame:CGRectMake(lockView.center.x,lockView.center.y, 50, 50))
            //
            //            activityIndicator.style = .whiteLarge
            //            activityIndicator.center.x = lockView.center.x
            //            activityIndicator.center.y = lockView.center.y
            //            activityIndicator.color = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
            //
            
            //            activityIndicator.startAnimating()
            let myString = ""
            let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.clear ]
            let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
            let spinner = JHSpinnerView.showOnView(self, spinnerColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), overlay:.circular, overlayColor: Colors.DarkBlue.withAlphaComponent(0.8)
                
                
                
                , attributedText: myAttrString)
            lockView.addSubview(spinner)
            addSubview(lockView)
     
          
            
            UIView.animate(withDuration: 0.2) {
                lockView.alpha = 1.0
            }
        }
    }
    //    func spinnerStart(){
    //        let spinner = JHSpinnerView.showOnView(self.view, spinnerColor:UIColor.red, overlay:.roundedSquare, overlayColor:UIColor.black.withAlphaComponent(0) )
    //
    //        self.view.addSubview(spinner)
    //    }
    //    func spinnerStop(){
    //        let spinner = JHSpinnerView.showOnView(self.view, spinnerColor:UIColor.red, overlay:.roundedSquare, overlayColor:UIColor.black.withAlphaComponent(0) )
    //
    //        spinner.dismiss()
    //    }
    func unlock() {
        if let lockView = self.viewWithTag(10) {
            UIView.animate(withDuration: 0.2, animations: {
                lockView.alpha = 0.0
            }) { finished in
                lockView.removeFromSuperview()
            }
        }
    }
    @IBInspectable var shadowRadius: CGFloat{
        get{
            return self.layer.shadowRadius
        }
        set{
            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float{
        get{
            return self.layer.shadowOpacity
        }
        set{
            self.layer.shadowOpacity = newValue
        }
    }
    
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
//    func lock(frameRect: CGRect = CGRect.zero) {
//        if (viewWithTag(10) != nil) {
//            //View is already locked
//        }
//        else {
//            let lockView = UIView()
//
//            if frameRect == CGRect.zero{
//                lockView.frame = bounds
//            }
//            else{
//                lockView.frame = frameRect
//            }
//
//            lockView.backgroundColor = UIColor(white: 0.5, alpha: 0.3)
//
//            lockView.tag = 10
//            lockView.alpha = 0.0
//
//
//
//            let activityIndicator = UIActivityIndicatorView(frame:CGRectMake(lockView.center.x,lockView.center.y, 50, 50))
//
//            activityIndicator.style = .whiteLarge
//            activityIndicator.center.x = lockView.center.x
//            activityIndicator.center.y = lockView.center.y
//            activityIndicator.color = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
//
//
//            activityIndicator.startAnimating()
//            lockView.addSubview(activityIndicator)
//            addSubview(lockView)
//
//            UIView.animate(withDuration: 0.2) {
//                lockView.alpha = 1.0
//            }
//        }
//    }
//
//    func unlock() {
//        if let lockView = self.viewWithTag(10) {
//            UIView.animate(withDuration: 0.2, animations: {
//                lockView.alpha = 0.0
//            }) { finished in
//                lockView.removeFromSuperview()
//            }
//        }
//    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
}
@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}
    
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors    = [startColor.cgColor, endColor.cgColor]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}
extension UIImageView{
    func loadImage(_ url : URL?) {
        
        self.kf.indicatorType = .activity
        
        guard let url = url else {
            return
        }
    
        self.kf.setImage(with: url)
        
       
        //        {
        //            result in
        //            switch result {
        //            case .success(let value):
        //                print("Task done for: \(value.source.url?.absoluteString ?? "")")
        //            case .failure(let error):
        //                print("Job failed: \(error.localizedDescription)")
        //            }
        //        }
    }
}


