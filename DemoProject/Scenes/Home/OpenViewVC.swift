//
//  OpenViewVC.swift
//  AskHail
//
//  Created by bodaa on 22/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import WebKit

class OpenViewVC: UIViewController {
    
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var back: UIButton!
    //    var selectedVideo : PreviousAucationdata?

    var videoUrl:String?
    var titleOfVideo: String?

    override func viewDidLoad() {
        super.viewDidLoad()

       

        print(videoUrl)

        let detailsUrl = URL(string:videoUrl ?? "")
        let request:URLRequest = URLRequest(url: detailsUrl!)

        self.webView.load(request)

        self.videoTitle.text = titleOfVideo
      
        
    }
    
   
    @IBAction func back(_ sender: Any) {
      dismiss(animated: true, completion: nil)
    //   navigationController?.popViewController(animated: true)
    }
    
}
