//
//  AboutUs.swift
//  Stickers
//
//  Created by Ahmed on 2/18/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//


struct dataStruct{
    var longitude: String?
    var latitude: String?
    var telegram: String?
    var mobile: String?
    var phone: String?
    var email: String?
    var video: String?
    var about: String?
    var website:String?
    var privacy:String?
    
    init(dic :NSDictionary){
        self.longitude = dic.value(forKey: "longitude") as? String ?? ""
        self.latitude  = dic.value(forKey: "latitude") as? String ?? ""
        self.telegram = dic.value(forKey: "telegram") as? String ?? ""
        self.mobile  = dic.value(forKey: "mobile") as? String ?? ""
        self.phone = dic.value(forKey: "phone") as? String ?? ""
        self.email  = dic.value(forKey: "email") as? String ?? ""
        self.video = dic.value(forKey: "video") as? String ?? ""
        self.about  = dic.value(forKey: "about") as? String ?? ""
        self.website = dic.value(forKey: "website") as? String ?? ""
        self.privacy =  dic.value(forKey: "privacy") as? String ?? ""

    }
}



import UIKit
import Alamofire
import MessageUI

class AboutUs: UIViewController,MFMailComposeViewControllerDelegate{
    
    
    @IBOutlet weak var Telegrame_Button: UIButton!
    
    @IBOutlet weak var Email_Button: UIButton!
    
    @IBOutlet weak var WebSite_Button: UIButton!
    
    
    @IBOutlet weak var FullApp_Button: UIButton!
    
    @IBOutlet weak var imgpro: UIImageView!
    
    @IBOutlet weak var viewshow: UIView!
    
    var deatiles:AppDeatiles?
    var deatileslinks : [dataStruct] = []
    var Telgram = ""
    var datadeatiles : dataStruct?
    override func viewDidLoad() {
        super.viewDidLoad()
        checkButton()
        HideBackButton()
//        loadingDeatiles()
        fetch_categories()
        IAPHandler.shared.fetchAvailableProducts()
        IAPHandler.shared.purchaseStatusBlock = {[weak self] (type) in
            guard let strongSelf = self else{ return }
            if type == .purchased {
                let alertView = UIAlertController(title: "", message: type.message(), preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                    
                })
                alertView.addAction(action)
                strongSelf.present(alertView, animated: true, completion: nil)
            }
        }

        
 
    }
    func checkButton(){
        let boolValue = UserDefaults.standard.bool(forKey: "isPurchased")
        if (!boolValue){
            self.FullApp_Button.isHidden = false
            self.imgpro.isHidden = false
            self.viewshow.isHidden = false
        }else{
            self.FullApp_Button.isHidden = true
            self.imgpro.isHidden = true
            self.viewshow.isHidden = true


        }
        
        
    }
    
    
    
    
    
    func fetch_categories(){
        let UrlsData = Urls.DeatilesURl
        WebServices.sendGetRequest(url: UrlsData) { (response, error) in
            if error != nil {
                return
            }
            guard let response = response.value as? NSDictionary else {return}
            var dataitem  = response.value(forKey: "items") as? NSDictionary
            print(dataitem)
            self.datadeatiles = dataStruct(dic: dataitem!)
          }
    }
   
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        

    }
    func HideBackButton(){
        let barButtonItemAppearance = UIBarButtonItem.appearance()
        barButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        barButtonItemAppearance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -200, vertical: 0), for:UIBarMetrics.default)
    }
    
    
    @IBAction func website_Button(_ sender: Any) {
        
        if let TelegrameURL = datadeatiles?.website{
            guard let url = URL(string: TelegrameURL)else{return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            print(TelegrameURL)
        }
    }
    
    @IBAction func Telegram_Button(_ sender: Any) {

        if let EmailURL = datadeatiles?.telegram{
            guard let url = URL(string: EmailURL)else{return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            print(EmailURL)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Email_Button(_ sender: Any) {
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.setToRecipients([((datadeatiles?.email)!)])
        composeVC.setSubject("ملصقات احترافية")
        composeVC.setMessageBody("ملصقات احترافية", isHTML: false)
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
        }
    
    
    @IBAction func AppFull_Button(_ sender: Any) {
        IAPHandler.shared.purchaseMyProduct(index: 0)

        
    }
    
    @IBAction func PrivacyTerm(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let TermController = storyboard.instantiateViewController(withIdentifier: "TermsVC") as! TermsVC
        self.navigationController?.pushViewController(TermController, animated: true)
    }
    
    
}
