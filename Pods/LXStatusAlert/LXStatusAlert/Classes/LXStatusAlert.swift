//
//  LXStatusAlert.swift
//  LXStatusAlert
//
//  Created by Leon Hoppe on 14.06.18.
//

import UIKit

public class LXStatusAlert: UIView {
    
    //MARK: Properties
    private let blurView = UIVisualEffectView()
    private let size = CGSize(width: 200, height: 200)
    private var fadeDuration = 0.2
    private var image: UIImage?
    private var title: String?
    private let cornerRadius: CGFloat = 7.0
    
    
    //MARK: Init
    private override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public init(image: UIImage, title: String, duration: Double = 0.2) {
        super.init(frame: CGRect.zero)
        self.image = image
        self.title = title
        self.fadeDuration = duration
        setup()
    }
    
    //MARK: Functions
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.center = (UIApplication.shared.keyWindow?.center)!
        self.blurView.frame = self.bounds
    }
    
    private func setup() {
        // customize self
        self.alpha = 0.0
        self.backgroundColor = UIColor.clear
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 13.0
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = UIColor.black.cgColor
        self.frame.size = self.size
        
        // set blur effect
        let blurEffect = UIBlurEffect(style: .dark)
        blurView.effect = blurEffect
        blurView.layer.cornerRadius = self.cornerRadius
        blurView.layer.masksToBounds = true
        blurView.frame = self.bounds
        self.addSubview(blurView)
        
        // add views
        if let image = self.image, let title = self.title {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 90),
                imageView.heightAnchor.constraint(equalToConstant: 90)
                ])
            
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.textColor = UIColor.white
            titleLabel.font = UIFont(name: "Avenir-Roman", size: 15.0)
            titleLabel.textAlignment = .center
            titleLabel.adjustsFontSizeToFitWidth = true
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
            
            let stackView = UIStackView()
            stackView.alignment = .center
            stackView.axis = .vertical
            stackView.distribution = .equalSpacing
            stackView.spacing = 30
            stackView.addArrangedSubview(imageView)
            stackView.addArrangedSubview(titleLabel)
            self.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
                ])
        }
    }
    
    private func fadeIn() {
        UIApplication.shared.keyWindow?.addSubview(self)
        self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: self.fadeDuration) {
            self.alpha = 1.0
            self.transform = CGAffineTransform.identity
        }
    }
    
    @objc private func fadeOut() {
        let animation = {
            self.alpha = 0.0
            self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }
        
        UIView.animate(withDuration: self.fadeDuration, animations: animation) { _ in
            self.removeFromSuperview()
        }
    }
    
    public func show(){
        fadeIn()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fadeOut), userInfo: nil, repeats: false)
    }
}
