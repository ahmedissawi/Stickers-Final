//
//  StickersGroup.swift
//  Stickers
//
//  Created by Ahmed on 2/14/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//


import UIKit
import GoogleMobileAds
import BIZPopupView
import Alamofire
import AlamofireImage
import KingfisherWebP

class StickersGroup: UIViewController {
  
    @IBOutlet weak var StickersGroupCollection: UICollectionView!
    @IBOutlet weak var ViewAds: GADBannerView!
    @IBOutlet weak var Add: CustomButton!
    @IBOutlet weak var ImageMain: UIImageView!
    @IBOutlet weak var NameStickers: UILabel!
    var  selectedimage = 0

    @IBOutlet weak var hight: NSLayoutConstraint!
    
    var Stickers:ImageStickers?
    fileprivate var imgStickers:[ImageStickers] = []
    var img:[Images] = []
    private var stickerPacks: [StickerPack] = []
    private var stickersname :[ImageStickers]  = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setviewads()
        setupview()
        setupdata()
        let nib = UINib(nibName: "GroupStickers", bundle: nil)
         StickersGroupCollection.register(nib, forCellWithReuseIdentifier: "GroupStickers")
    }
    
    func setupview(){
        let adRequest = GADRequest()

        adRequest.testDevices = [ kGADSimulatorID,"ca-app-pub-3722926456427001/9277896824"]

        ViewAds.adUnitID = "ca-app-pub-3722926456427001/9277896824"
        ViewAds.rootViewController = self
        ViewAds.load(adRequest)
     
    }
    func setviewads(){
        let boolValue = UserDefaults.standard.bool(forKey: "isPurchased")
        if (!boolValue){
            self.hight.constant = 50
        }else{
            self.hight.constant = 0
            
            
        }
    }

    
    
    
    
    
    func setupdata(){
    NameStickers.text = Stickers?.name
        if let url = Stickers?.image{
//           ImageMain.kf.setImage(with: url, options: [.processor(WebPProcessor.default), .cacheSerializer(WebPSerializer.default)])
            ImageMain.af_setImage(withURL: url, placeholderImage: UIImage(named: "Main"))
        }else{
            print("error")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
     
    }

    @IBAction func AddButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let smallViewController: AppsStickers = storyboard.instantiateViewController(withIdentifier: "Stickers") as! AppsStickers
        smallViewController.img = self.img
        smallViewController.imgStickers = self.Stickers
        smallViewController.modalPresentationStyle =    .overCurrentContext
//        smallViewController.modalTransitionStyle = .crossDissolve
//        let popupViewController = BIZPopupViewController(contentViewController: smallViewController, contentSize: CGSize(width: UIScreen.main.bounds.width, height: 150))
        present(smallViewController, animated: false)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
extension StickersGroup:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView:
        UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return img.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageobject = img[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupStickers", for: indexPath) as! GroupStickers
        let   boolValue = UserDefaults.standard.bool(forKey: "isPurchased")
        if (!boolValue){

        if imageobject.is_free == "1"{
            cell.lock_img.isHidden = true
            if let url  = imageobject.image{
                cell.ImageStickersGroup.af_setImage(withURL: url, placeholderImage: UIImage(named: "Main"))
            }
            }else if imageobject.is_free == "0"{
            cell.lock_img.isHidden = false
            let filter = GrayScaleFilter()
            if let url =  imageobject.image{
                cell.ImageStickersGroup.af_setImage(withURL: url, filter: filter)
            }
        }
        }else{
            cell.lock_img.isHidden = true
            if let url  = imageobject.image{
                cell.ImageStickersGroup.af_setImage(withURL: url, placeholderImage: UIImage(named: "Main"))
            }
        }
        return cell
    }
    

    
    
}
