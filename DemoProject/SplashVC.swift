//
//  SplashVC.swift
//  AskHailBusiness
//
//  Created by Mohab on 1/20/21.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit
import Lottie

class SplashVC: UIViewController {
    let animationView = AnimationView()
    let animationView1 = AnimationView()
    @IBOutlet weak var imageView: UIView!
    
    @IBOutlet weak var imageview1: UIView!
    
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      animationView.play(fromProgress: 0,
                         toProgress: 1,
                         loopMode: LottieLoopMode.playOnce,
                         completion: { (finished) in
                          if finished {


                            guard let window = UIApplication.shared.keyWindow else{return}
                            if Helper.getapitoken() != nil {
                                
                                
                                
                                let sb = UIStoryboard(name: Home, bundle: nil)
                                var vc : UIViewController
                                vc = sb.instantiateViewController(withIdentifier: "HomeVC")
                                window.rootViewController = vc
                                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                            }else {
                                
                                let sb = UIStoryboard(name: Authontication, bundle: nil)
                                var vc : UIViewController
                                vc = sb.instantiateViewController(withIdentifier: "WelcomeVC")
                                window.rootViewController = vc
                                UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                                
                            }
                            
                            
                          } else {
                            print("Animation cancelled")
                          }
      })
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    
        

     let animation = Animation.named("splacsh2", subdirectory: "TestAnimations")
        
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFill
        imageView.addSubview(animationView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.translatesAutoresizingMaskIntoConstraints = false
       animationView.topAnchor.constraint(equalTo: imageView.layoutMarginsGuide.topAnchor).isActive = true
        animationView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        
        animationView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true
        animationView.trailingAnchor.constraint(equalTo: imageView .trailingAnchor).isActive = true
        animationView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        
        
//        let animation1 = Animation.named("askhailsocial", subdirectory: "TestAnimations")
//
//           animationView1.animation = animation1
//           animationView1.contentMode = .scaleAspectFit
//    
//           imageview1.addSubview(animationView1)
//        imageview1.translatesAutoresizingMaskIntoConstraints = false
//
//        animationView1.backgroundBehavior = .pauseAndRestore
//        animationView1.translatesAutoresizingMaskIntoConstraints = false
//        animationView1.topAnchor.constraint(equalTo: imageview1.layoutMarginsGuide.topAnchor).isActive = true
//        animationView1.leadingAnchor.constraint(equalTo: imageview1.leadingAnchor).isActive = true
//
//        animationView1.bottomAnchor.constraint(equalTo: imageview1.bottomAnchor, constant: 0).isActive = true
//        animationView1.trailingAnchor.constraint(equalTo: imageview1.trailingAnchor).isActive = true
//        animationView1.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
//        
//       
      
       
        
     
        
    }
    
    

}
