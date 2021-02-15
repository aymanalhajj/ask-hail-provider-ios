//
//  WaitingVC.swift
//  DemoProject
//
//  Created by Mohab on 12/18/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import SocketIO
import Lottie




class WaitingVC: UIViewController {
    

    
    let animationView = AnimationView()
 
    
    
   
    
    
    let slider = UISlider()
    
    var s: SocketIOClient!
    var manager:SocketManager!
    
    var id = ""
    var displayLink: CADisplayLink?
    
 
    @IBOutlet weak var imageView: UIView!
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      animationView.play(fromProgress: 0,
                         toProgress: 1,
                         loopMode: LottieLoopMode.loop,
                         completion: { (finished) in
                          if finished {
                            print("Animation Complete")
                          } else {
                            print("Animation cancelled")
                          }
      })
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
     
        
      
//
//     let animation = Animation.named("waiting_request_2", subdirectory: "TestAnimations")
//
//        animationView.animation = animation
//        animationView.contentMode = .scaleAspectFit
//        imageView.addSubview(animationView)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//
//        animationView.backgroundBehavior = .pauseAndRestore
//        animationView.translatesAutoresizingMaskIntoConstraints = false
//        animationView.topAnchor.constraint(equalTo: imageView.layoutMarginsGuide.topAnchor).isActive = true
//        animationView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
//
//        animationView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true
//        animationView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
//        animationView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
//
       
      
 
        
    }
    
 
    
    
}



