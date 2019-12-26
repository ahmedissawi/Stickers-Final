//
//  MackerStickersTableCell.swift
//  Stickers
//
//  Created by Ahmed on 2/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit

protocol StickersSelectedAction {
    func getobject(_ data:Int)
    
}
class MackerStickersTableCell: UITableViewCell {

    @IBOutlet weak var NumberStickers: UILabel!
    @IBOutlet weak var NameStickers: UILabel!
    @IBOutlet weak var MainStickersIamge: UIImageView!
    @IBOutlet weak var Collection: UICollectionView!
    var objectImage = [singleImage]()
    
    var delegate:StickersSelectedAction?

  
    override func awakeFromNib() {
        super.awakeFromNib()
        let nib = UINib(nibName: "MakerStickersCell", bundle: nil)
        Collection.register(nib, forCellWithReuseIdentifier: "MakerStickersCell")
        Collection.delegate = self
        Collection.dataSource = self
        MainStickersIamge.layer.cornerRadius = 5
    }
    
    
}
extension MackerStickersTableCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objectImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MakerStickersCell", for: indexPath) as! MakerStickersCell
        cell.ImageMakeSticker.image = self.getimg(image: objectImage[indexPath.row].image!)
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       delegate?.getobject(indexPath.row)
    }
    
    func getimg(image:Data) -> UIImage {
        let img = UIImage(data: image)
        return img!
    }

}
