//
//  PhotoDetialsVC.swift
//  AskHail
//
//  Created by Mohab on 1/14/21.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit

class PhotoDetialsVC: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgPhoto: UIImageView!
    var theImage : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgPhoto.image = theImage
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.delegate = self
        
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return imgPhoto
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

import UIKit

class PhotoDetialsVC1: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgPhoto: UIImageView!
    var theImage : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgPhoto.image = theImage
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.delegate = self
        
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return imgPhoto
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
import UIKit

class ZoomableImage: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openToZoomImage)))
        
    }
    
    @objc func openToZoomImage() {
        let zoomVC = UIStoryboard(name: "ZoomAbleImage", bundle: nil).instantiate(identifier: "PhotoDetialsVC", asClass: PhotoDetialsVC.self)
        zoomVC.theImage = self.image
           var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil) {
            topVC = topVC!.presentedViewController
        }
        topVC?.present(zoomVC, animated: true, completion: nil)
    }
    
    
}




extension UIStoryboard {
    func instantiate<T>(identifier: String, asClass: T.Type) -> T {
        return instantiateViewController(withIdentifier: identifier) as! T
    }
    
    func instantiate<T>(identifier: String) -> T {
        return instantiateViewController(withIdentifier: identifier) as! T
    }
}
