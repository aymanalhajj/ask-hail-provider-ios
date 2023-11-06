//
//  BusinessAdsTypeVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/5/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class BusinessAdsTypeVC: UIViewController {
    
    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var CollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        CollectionView.RegisterNib(cell: RealtySaleCell.self)
        
        CollectionView.dataSource = self
        CollectionView.delegate = self
        
        CollectionView.flipX()
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopView, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
        
    }
    

}

extension BusinessAdsTypeVC : UICollectionViewDataSource , UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RealtySaleCell", for: indexPath) as! RealtySaleCell
        
        cell.flipX()
        
        if indexPath.row == 0 {
            if L102Language.currentAppleLanguage() == englishLang{
                cell.CellTitile.text = "Chalets"
            } else {
                cell.CellTitile.text = "شاليهات"
            }
        }else if indexPath.row == 1 {
            if L102Language.currentAppleLanguage() == englishLang{
                cell.CellTitile.text = "Resorts"
            } else {
                cell.CellTitile.text = "منتجعات"
            }
        }else if indexPath.row == 2 {
            if L102Language.currentAppleLanguage() == englishLang{
                cell.CellTitile.text = "Breaks"
            } else {
                cell.CellTitile.text = "استراحات"
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: BusinessAds, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "BusinessAdsVC") as! BusinessAdsDetailsVC
        // present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
        
        return collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

extension BusinessAdsTypeVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width - 16)/3
        // let height = collectionView.frame.height
        
        return CGSize.init(width: width , height: 156)
        
    }
}

