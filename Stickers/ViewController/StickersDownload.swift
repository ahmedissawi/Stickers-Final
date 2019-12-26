//
//  StickersDownload.swift
//  Stickers
//
//  Created by Ahmed on 2/14/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import GoogleMobileAds
import Alamofire
import AlamofireImage
import MBProgressHUD
import SDWebImage

class StickersDownload: UIViewController,IndicatorInfoProvider,UITableViewDelegate,UITableViewDataSource ,StickersAction,GADInterstitialDelegate{
    
    fileprivate lazy var refreshControl:UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(reloadItems), for: .valueChanged)
        
        return control
    }()
    
    
    @IBOutlet weak var hight: NSLayoutConstraint!
    
    
    private var stickerPacks: [StickerPack] = []
    private var stickersname :[ImageStickers]  = []


    var listPath:[String] = []
    var MainImage = ""
    var MainImageData:Data!
    var img:Images?
    var interstitial: GADInterstitial!
    var count = 0

    

    func getobject(_ data: Any, indexPath: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let smallViewController = storyboard.instantiateViewController(withIdentifier: "StickersGroup") as! StickersGroup
        smallViewController.Stickers = imgStickers[indexPath]
        smallViewController.img = imgStickers[indexPath].images
        count += 1
         if interstitial.isReady {
            if count == 5 {
                interstitial.present(fromRootViewController: self)
                count = 0
            }
           } else {
            print("Ad wasn't ready")
          }


        
        self.navigationController?.pushViewController(smallViewController, animated: true)

    }    
    
    let destination = DownloadRequest.suggestedDownloadDestination(
        for: .documentDirectory,
        in: .userDomainMask
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        setviewads()
        Table.delegate = self
        Table.dataSource = self
        setupview()
        loadingPost()
        interstitial = createAndLoadInterstitial()
        if #available(iOS 10.0, *) {
            self.Table.refreshControl = refreshControl
        } else {
            self.Table.addSubview(refreshControl)
            
        }
        Checkconnection()
     //   loadingPost()
    }
    
    
    func setviewads(){
        let boolValue = UserDefaults.standard.bool(forKey: "isPurchased")
        if (!boolValue){
            self.hight.constant = 50
        }else{
            self.hight.constant = 0

            
        }
    }
    
    
    
    
    
    
    @objc func reloadItems(){
        currentPage = 1
        pagesCount = 1
        imgStickers.removeAll()
        Table.reloadData()
        loadingPost()

    }
    func setupview(){
        let nib = UINib(nibName: "StickersCell", bundle: nil)
        Table.register(nib, forCellReuseIdentifier: "Cell")
        //BannerAds
        let adRequest = GADRequest()
        //ca-app-pub-3940256099942544/2934735716

        adRequest.testDevices = [ kGADSimulatorID,"ca-app-pub-3722926456427001/9277896824"]
        ViewBanner.adUnitID = "ca-app-pub-3722926456427001/9277896824"
        ViewBanner.rootViewController = self
        ViewBanner.load(adRequest)
        
        // interstitialAds
//        let request = GADRequest()
//        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
//        interstitial.load(request)

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

    
    fileprivate var imgStickers:[ImageStickers] = []
    @IBOutlet weak var ViewBanner: GADBannerView!
    fileprivate var isLoading   = false
    fileprivate var currentPage = 1
    fileprivate var pagesCount  = 1
    fileprivate func loadingPost(){
        
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = "Loading"
        hud.mode = .indeterminate
        hud.removeFromSuperViewOnHide = true
        
        WebServices.getIamgeObject { (item, error) in
            self.isLoading = false
            self.refreshControl.endRefreshing()

            guard let item = item else {
                hud.mode = .text
                hud.label.text = "Error"
                hud.detailsLabel.text = "Something went wrong!"
                hud.hide(animated: true, afterDelay: 2.0)
                return
            }
            hud.hide(animated: true)
//            self.imgStickers = item

            self.imgStickers.append(contentsOf: item)
            self.Table.reloadData()
        }
   
    }
    
    
    fileprivate func loadMoreItems() {
        currentPage += 1
        loadingPost()
    }
    
    
    func Checkconnection(){
        if Connectivity.isConnectedToInternet {
            print("Yes! internet is available.")
        }
        else{
            let alert = UIAlertController(title: "خطا في الاتصال", message: "الرجاء التاكد من الاتصال بالانترنت ", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "موافق", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgStickers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imgsikcers = imgStickers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StickersCell
        cell.NameStickers.text = imgsikcers.name
        cell.img = imgStickers[indexPath.row].images
        cell.Collection.reloadData()
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.delegate = self
        cell.TableIndex = indexPath.row
        if !isLoading && indexPath.row == imgStickers.count-1 && pagesCount > currentPage {
            loadMoreItems()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        count += 1
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let smallViewController = storyboard.instantiateViewController(withIdentifier: "StickersGroup") as! StickersGroup
        smallViewController.Stickers = imgStickers[indexPath.row]
        smallViewController.img = imgStickers[indexPath.row].images
        if interstitial.isReady {
            if count == 5 {
                interstitial.present(fromRootViewController: self)
                count = 0
            }
        } else {
            print("Ad wasn't ready")
        }

        self.navigationController?.pushViewController(smallViewController, animated: true)
    }
    @IBOutlet weak var Table: UITableView!
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "ملصقات احترافية")
    }
}
