


//
//  CustomNavgtion.swift
//  Stickers
//
//  Created by Ahmed on 2/13/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit

class CustomNavgtion: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makebarinvisable()
        HideBackButton()
    }
    
    func makebarinvisable(){
//        navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationBar.shadowImage = UIImage()
//        navigationBar.isTranslucent = true
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    func HideBackButton(){
        let barButtonItemAppearance = UIBarButtonItem.appearance()
        barButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        barButtonItemAppearance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -200, vertical: 0), for:UIBarMetrics.default)
    }

}
