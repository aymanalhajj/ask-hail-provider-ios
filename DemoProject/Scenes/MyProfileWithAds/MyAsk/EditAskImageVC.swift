//
//  EditAskImageVC.swift
//  AskHail
//
//  Created by bodaa on 17/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class EditAskImageVC: UIViewController {
    
    var AskData : Question_details?
    
    @IBOutlet var BackGround: UIView!
    @IBOutlet weak var ConfirmBtn: UIButton!
    @IBOutlet weak var AddPhotoBtn: UIButton!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var TopBar: UIView!
        
    
    override func viewWillAppear(_ animated: Bool) {
        Image.loadImage(URL(string: AskData?.question_image ?? ""))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        

        if Image.image == nil {
            
            AddPhotoBtn.setImage(#imageLiteral(resourceName: "add-1"), for: .normal)
            
        }else {
            
            
            AddPhotoBtn.setImage(#imageLiteral(resourceName: "remove-1"), for: .normal)
        }
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.8974673004, green: 0.911144314, blue: 0.922011104, alpha: 1))
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
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
    
    
    
    @IBAction func ConfirmTermsAction(_ sender: Any) {
        
//        if Image.image == nil {
//
//            Image.borderWidth = 3
//            Image.borderColor = Colors.errorLineView
//
//            self.view.shake()
//
//        } else {
            
            updateImage()
       // }
        
        
    }
    
    
}

extension EditAskImageVC {
    
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



extension EditAskImageVC {
    
    func updateImage() {
        
        var image_state = "false"
        
        if self.Image.image == nil {
            image_state = "true"
        }else{
            image_state = "false"
        }
        
        self.view.lock()
        
        let Parameters = [
            "question_id" : "\(AskData?.question_id ?? 0)",
            "title" : AskData?.question_title ?? "" ,
            "description" : AskData?.question_description ?? "" ,
            "show_name_status" : AskData?.question_show_name_status ?? "",
            "delete_image" : image_state,
        ] as [String : Any]
        
        
        
        
        ApiServices.instance.uploadImage(methodType: .post, parameters: Parameters as [String : AnyObject], url: "\(hostName)business/update-question", imagesArray: nil, profileImage: nil, commercial_register_image: Image.image, office_license_image: nil, id_image: nil, VediosArray: nil, VediosDuration: nil) { (data : SuccessUpdateAskModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.navigationController?.popToViewController(ofClass: MyAskVC.self)
                self.navigationController?.view.makeToast("\(data.data?.message ?? "")")
                
                print(data)
                
            }
        }
    }

}

