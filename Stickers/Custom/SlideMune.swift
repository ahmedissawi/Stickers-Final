
//
//  SlideMune.swift
//  Stickers
//
//  Created by Ahmed on 2/18/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import SideMenu

class SlideMune: NSObject {
    static func showSideMenuVC (_ viewController : UIViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let menuRightVC = storyboard.instantiateViewController(withIdentifier: "a") as! UISideMenuNavigationController
        SideMenuManager.default.menuLeftNavigationController = menuRightVC
        viewController.present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        SideMenuManager.default.menuFadeStatusBar = false
       menuRightVC.sideMenuManager.menuPresentMode  = .menuSlideIn


   }
}
