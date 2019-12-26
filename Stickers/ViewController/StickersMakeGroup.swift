//
//  StickersMakeGroup.swift
//  Stickers
//
//  Created by  Ahmed’s MacBook Pro on 3/6/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import GoogleMobileAds
import BIZPopupView
import RealmSwift


class StickersMakeGroup: UIViewController {
    
//    var img:Any?
    var imgseclected : ImageObject?
    var img:[UIImage] = []

//    var imgg:singleImage
    fileprivate var imgSticker:[ImageObject] = []
    var  relam = try! Realm()
    var objectImage : [singleImage] = []


    @IBOutlet weak var ViewNavgtion: UIView!
    @IBOutlet weak var StickerImageMain: UIImageView!
    
    @IBOutlet weak var NameStickers: UILabel!
    @IBOutlet weak var TitleStickers: UILabel!
    
    @IBOutlet weak var Collection: UICollectionView!
    
    @IBOutlet weak var AddButton: CustomButton!
    
    @IBOutlet weak var ViewAdsMob: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        NameStickers.text = imgseclected?.name
        StickerImageMain.image = self.getimg(image: (imgseclected?.Coverimage)!)
        
    }
    
    
    
    func setupview(){
        let adRequest = GADRequest()
        //ca-app-pub-3940256099942544/2934735716
        
        adRequest.testDevices = [ kGADSimulatorID,"ca-app-pub-3722926456427001/9277896824"]
        ViewAdsMob.adUnitID = "ca-app-pub-3722926456427001/9277896824"
        ViewAdsMob.rootViewController = self
        ViewAdsMob.load(adRequest)
        let nib = UINib(nibName: "GroupStikersImageCell", bundle: nil)
        Collection.register(nib, forCellWithReuseIdentifier: "GroupStikersImageCell")
    }
    
    @IBAction func ButtonAddStickers(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let smallViewController: AppsMakerStickers = storyboard.instantiateViewController(withIdentifier: "StickersMaker") as! AppsMakerStickers
        smallViewController.img = self.img
        smallViewController.imgseclected = self.imgseclected
        smallViewController.modalPresentationStyle =    .overCurrentContext
//        let popupViewController = BIZPopupViewController(contentViewController: smallViewController, contentSize: CGSize(width: UIScreen.main.bounds.width, height: 150))
        present(smallViewController, animated: false)

    }
    
    func getimg(image:Data) -> UIImage {
        let img = UIImage(data: image)
        return img!
    }
    
}
extension StickersMakeGroup:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let objectData = relam.objects(ImageObject.self)
        return img.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let objectData = relam.objects(ImageObject.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupStikersImageCell", for: indexPath) as! GroupStikersImageCell
//                cell.ImageSticker.image =  UIImage(named: "Main")
//        cell.ImageSticker.image = self.getimg(image: objectImage[indexPath.row].image!)
        cell.ImageSticker.image = img[indexPath.row]
        return cell

     
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120 , height: 120)
    }
    
  
    
    
}
