//
//  StickersAddCell.swift
//  Stickers
//
//  Created by Ahmed on 2/20/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
protocol StickersAddAction {
    func getimage(data:UIImage)
    
}



class StickersAddCell: UICollectionViewCell {

    
    var selectedimages:UIImage?
    var delegate:StickersAddAction?

    
    
    @IBOutlet weak var viewlabelnumber: UIView!
    @IBOutlet weak var StickersCellImage: UIImageView!
    
    @IBOutlet weak var ViewCell: UIView!
    @IBOutlet weak var numberlabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //TabImgProfile()
    }
    
    
//    func TabImgProfile(){
//        let tab = UITapGestureRecognizer(target: self, action: #selector(handelimage))
//        StickersCellImage.addGestureRecognizer(tab)
//        StickersCellImage.isUserInteractionEnabled = true
//    }
    @objc func handelimage(){
        
        
    }
}
//extension StickersAddCell:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
//    @objc   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
//            selectedimages = editedImage
//            StickersCellImage.image  = editedImage
//        }else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
//            selectedimages = image
//            StickersCellImage.image  = image
//            
//        }
//       delegateimage?.getActionimage(AnyIndex.self)
//    }
//
//}
