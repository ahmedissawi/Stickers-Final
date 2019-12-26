//
//  StickersCell.swift
//  Stickers
//
//  Created by Ahmed on 2/14/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import AlamofireImage
import Accelerate
import SDWebImage
import KingfisherWebP
import GoogleMobileAds

protocol StickersAction {
    func getobject(_ data:Any,indexPath:Int)
    
}


class StickersCell: UITableViewCell,GADInterstitialDelegate {
  
    
    @IBOutlet weak var NameStickers: UILabel!
    
    @IBOutlet weak var Collection: UICollectionView!
    
    @IBOutlet weak var DownloadButton: UIButton!
    @IBOutlet weak var Name: UILabel!
    
    var interstitial: GADInterstitial!
    var count = 0
    var vc = StickersDownload.self

        
    var delegate:StickersAction?
    var imgStickers:[ImageStickers] = []
    var img:[Images] = []
    var TableIndex:Int?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        Collection.dataSource = self
        Collection.delegate = self
        let nib = UINib(nibName: "StickersImages", bundle: nil)
        Collection.register(nib, forCellWithReuseIdentifier: "CellCell")
        interstitial = createAndLoadInterstitial()
        let request = GADRequest()
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.load(request)
    }

    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
 
    
}
extension StickersCell:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return img.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageobject = img[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCell", for: indexPath) as! StickersImages
       
        let   boolValue = UserDefaults.standard.bool(forKey: "isPurchased")
        if (!boolValue){
            
            if imageobject.is_free == "1"{
                cell.lock_img.isHidden = true
                if let url  = imageobject.image{
                    cell.Stickersimage.af_setImage(withURL: url, placeholderImage: UIImage(named: "Main"))
                }
            }else if imageobject.is_free == "0"{
                cell.lock_img.isHidden = false
                let filter = GrayScaleFilter()
                if let url =  imageobject.image{
                    cell.Stickersimage.af_setImage(withURL: url, filter: filter)
                }
            }
        }else{
            cell.lock_img.isHidden = true
            if let url  = imageobject.image{
                cell.Stickersimage.af_setImage(withURL: url, placeholderImage: UIImage(named: "Main"))
            }
        }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        delegate?.getobject(indexPath, indexPath: TableIndex!)
        
    }

}
