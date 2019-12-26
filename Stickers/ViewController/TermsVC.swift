
//
//  TermsVC.swift
//  Stickers
//
//  Created by  Ahmed’s MacBook Pro on 4/16/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import Alamofire
import WebKit

class TermsVC: UIViewController {
    var datadeatiles : dataStruct?
    var deatileslinks : [dataStruct] = []

    
    @IBOutlet weak var Terms: UILabel!
    
    @IBOutlet weak var webviewterm: WKWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "سياسة الخصوصية"
        fetch_data()
        
        
    }
    
    func fetch_data(){
        let UrlsData = Urls.DeatilesURl
        WebServices.sendGetRequest(url: UrlsData) { (response, error) in
            if error != nil {
                return
            }
            guard let response = response.value as? NSDictionary else {return}
            let dataitem  = response.value(forKey: "items") as? NSDictionary
            print(dataitem)
            self.datadeatiles = dataStruct(dic: dataitem!)
            
            self.webviewterm.loadHTMLString((self.datadeatiles?.privacy)!, baseURL: Bundle.main.bundleURL)

            //            if let AppFullURL = self.datadeatiles?.privacy{
//                self.Terms.text = AppFullURL
//            }
        }
    }
    
    
}
        

    
   

