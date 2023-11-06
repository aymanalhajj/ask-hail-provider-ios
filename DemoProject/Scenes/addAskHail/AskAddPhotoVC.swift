//
//  AskAddPhotoVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/8/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class AskAddPhotoVC: UIViewController {
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    
    @IBOutlet weak var AddPhotoBtn: UIButton!
    @IBOutlet weak var Image: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func AddPhotoAction(_ sender: Any) {
        
        if Image.image == nil {
            
            showAllImageToChose()
            
        }else {
            AddPhotoBtn.setImage(#imageLiteral(resourceName: "add-1"), for: .normal)
            Image.image = nil
        }
        
    }
    
    @IBAction func ConfirmWithOutPhotoAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name:
                                        AddAskHail, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "AskDetailsVC") as! AskDetailsVC
     
        navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func ConfirmTermsAction(_ sender: Any) {
        
        if Image.image == nil {
            
            Image.borderWidth = 3
            Image.borderColor = Colors.errorLineView
            
            self.view.shake()
            
        } else {
            
            let storyboard = UIStoryboard(name:AddAskHail, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AskDetailsVC") as! AskDetailsVC
            vc.Image = Image
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
}

extension AskAddPhotoVC {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        Image.borderWidth = 0
        AddPhotoBtn.setImage(#imageLiteral(resourceName: "remove-1"), for: .normal)
        
        if let image = info[.originalImage] as? UIImage{
            self.Image.image = image
        }else{
            if let imageEdit = info[.editedImage] as? UIImage {
                self.Image.image = imageEdit
                
            }
            
        }
    }
    
}


