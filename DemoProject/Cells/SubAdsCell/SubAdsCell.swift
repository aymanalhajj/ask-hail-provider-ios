//
//  SubAdsCell.swift
//  AskHail
//
//  Created by Abdullah Tarek on 10/29/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import FSPagerView

class SubAdsCell: UITableViewCell , FSPagerViewDelegate , FSPagerViewDataSource {
    
    @IBOutlet weak var PagerView: FSPagerView!
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var StarAdView: UIView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var ViewsNumber: UILabel!
    @IBOutlet weak var SaveBtn: UIButton!
    @IBOutlet weak var DeActiveBtn: UIButton!
    
    var ImagesUrl = [Adv_media]()
    
    var SaveAcrion : (()->())?
    
    var isSaved = false
    
    var SelectCell : (()->())?
    
    var DeActive : (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        PagerView.dataSource = self
        PagerView.delegate = self
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = 5
    
        
        PagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        
        PagerView.isInfinite = true
        PagerView.addSubview(pageControl)
        PagerView.addSubview(bgView)
        PagerView.addSubview(StarAdView)
        
        PagerView.itemSize = CGSize(width: PagerView.frame.size.width + 88, height: PagerView.frame.size.height)
        PagerView.transformer = FSPagerViewTransformer(type: .linear)
        
        
    }

    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return ImagesUrl.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        pageControl.currentPage = index
        PagerView.contentMode = .scaleAspectFill
        
        cell.imageView?.loadImage(URL(string: ImagesUrl[index].media_image ?? ""))
        
        return cell
        
    }
    
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        SelectCell?()
        print(index)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
      
    }
    
    override func layoutSubviews() {
              super.layoutSubviews()

              contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0))
          }
    
    @IBAction func SaveAction(_ sender: Any) {
        
        SaveAcrion?()
    }
    
    @IBAction func DeAvtiveAction(_ sender: Any) {
        
        DeActive?()
        
    }
    
    
}

