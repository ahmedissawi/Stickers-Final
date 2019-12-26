//
//  SlideVC.swift
//  Stickers
//
//  Created by Ahmed on 2/18/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import StoreKit

class SlideVC: UIViewController {
    
    
    @IBOutlet weak var downloadAllapp: UIButton!
    
    @IBOutlet weak var imgpro: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkButton()
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
            self.downloadAllapp.isHidden = false
            self.imgpro.isHidden = false
        }else{
            self.downloadAllapp.isHidden = true
            self.imgpro.isHidden = true

        }
        

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true

    }
 
    
    @IBAction func downloadApp(_ sender: Any) {
        IAPHandler.shared.purchaseMyProduct(index: 0)
    }
    
}
