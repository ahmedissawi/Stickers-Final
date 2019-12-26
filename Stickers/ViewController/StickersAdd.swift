//
//  StickersAdd.swift
//  Stickers
//
//  Created by Ahmed on 2/14/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import GoogleMobileAds
import RealmSwift
import DZNEmptyDataSet

class StickersAdd: UIViewController,IndicatorInfoProvider,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,GADInterstitialDelegate {

    @IBOutlet weak var Table: UITableView!
    
    var  relam = try! Realm()    
    @IBOutlet weak var ButtonAdd: UIButton!
    @IBOutlet weak var ViewAds: GADBannerView!
    fileprivate var imgSticker:[ImageObject] = []
    fileprivate var imgStr:[UIImage] = []
    var images :[singleImage] = []
    var interstitial: GADInterstitial!
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        let nib  = UINib(nibName: "MackerStickersTableCell", bundle: nil)
        Table.register(nib, forCellReuseIdentifier: "MackerStickersTableCell")
        Table.tableFooterView = UIView()
        interstitial = createAndLoadInterstitial()

//          let objectData = relam.objects(ImageObject.self)
//        object = (objectData as? [ImageObject])!
//        self.img.image = self.getimg(image: object[0].Coverimage!)
    }
    func createAndLoadInterstitial() -> GADInterstitial {
        let adRequest = GADRequest()
        adRequest.testDevices = [ kGADSimulatorID,"ca-app-pub-3722926456427001/9525308837"]

        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3722926456427001/9525308837")
        interstitial.delegate = self
        interstitial.load(adRequest)
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let   objectData = relam.objects(ImageObject.self)
        self.imgSticker.append(contentsOf:objectData)

        self.Table.reloadData()
        
    }
    func getimg(image:Data) -> UIImage {
        let img = UIImage(data: image)
        return img!
    }
    
    
    func description(forEmptyDataSet scrollView: UIScrollView?) -> NSAttributedString? {
        let text = "اضغط علامة ( + ) لإضافة الصور وتحويلها الى ملصقات"
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .center
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0), NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.paragraphStyle: paragraph]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func setupview(){
        let adRequest = GADRequest()
        //ca-app-pub-3940256099942544/2934735716
        
        adRequest.testDevices = [ kGADSimulatorID,"ca-app-pub-3722926456427001/9277896824"]

        ViewAds.adUnitID = "ca-app-pub-3722926456427001/9277896824"
        ViewAds.rootViewController = self
        ViewAds.load(adRequest)
    }
    
    func ss(){
       
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "صانع الملصقات")
    }
    @IBAction func AddButton(_ sender: Any) {
        let storyborde = UIStoryboard.init(name: "Main", bundle: nil)
         let vc = storyborde.instantiateViewController(withIdentifier: "AddImage") as? AddImage
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
extension StickersAdd:UITableViewDelegate,UITableViewDataSource,StickersSelectedAction{
    func getobject(_ data: Int) {
      
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let objectData = relam.objects(ImageObject.self)
        return objectData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let   objectData = relam.objects(ImageObject.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: "MackerStickersTableCell", for: indexPath) as! MackerStickersTableCell
        cell.MainStickersIamge.image = self.getimg(image: objectData[indexPath.row].Coverimage!)
        cell.NameStickers.text = objectData[indexPath.row].name
        cell.NumberStickers.text = "\(indexPath.row + 1)"
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.delegate = self
        cell.objectImage.removeAll()
        
        for item in objectData[indexPath.row].list{
            cell.objectImage.append(item)
            cell.Collection.reloadData()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyborde = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = storyborde.instantiateViewController(withIdentifier: "StickersMakeGroup") as? StickersMakeGroup
               let objectData = relam.objects(ImageObject.self)
               vc?.imgseclected = imgSticker[indexPath.row]
        
               for item in objectData[indexPath.row].list{
                imgStr.append(self.getimg(image: item.image!))
                }
                  vc?.img = imgStr
                 imgStr.removeAll()
        
                count += 1
        let boolValue = UserDefaults.standard.bool(forKey: "isPurchased")
        if (!boolValue){
            if interstitial.isReady {
                if count == 5 {
                    interstitial.present(fromRootViewController: self)
                    count = 0
                }
            } else {
                print("Ad wasn't ready")
            } }else{
                print("true")
            }
        
               self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}
