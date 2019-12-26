//
//  StickersMune.swift
//  Stickers
//
//  Created by Ahmed on 2/13/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SideMenu

class StickersMune: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
         tabBar()
        super.viewDidLoad()
//        UIApplication.shared.statusBarView?.backgroundColor = grayInstagramColor

    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        self.moveToViewController(at: 1)
//    }
    
    let bluestickerscolor = UIColor(red: 72/255.0, green: 160/255.0, blue: 236/255.0, alpha: 1.0)
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //view-Will-Disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StickersDownload")
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StickersAdd")
        return [child_1,child_2]
    }

    
    func tabBar(){
        self.settings.style.selectedBarHeight = 0
        self.settings.style.buttonBarBackgroundColor = bluestickerscolor
        self.settings.style.buttonBarItemBackgroundColor = bluestickerscolor
        self.settings.style.selectedBarBackgroundColor  = UIColor.yellow
        self.settings.style.buttonBarItemFont  = .boldSystemFont(ofSize: 16)
        self.settings.style.selectedBarHeight  = 0
        self.settings.style.buttonBarMinimumLineSpacing = 3
        self.settings.style.buttonBarItemTitleColor  = UIColor.black
        self.settings.style.buttonBarItemsShouldFillAvailableWidth = true
        self.settings.style.buttonBarLeftContentInset = 10
        self.settings.style.buttonBarRightContentInset  = 10

        
    
        changeCurrentIndexProgressive = { (oldCell : ButtonBarViewCell?,newCell :ButtonBarViewCell?, progressPercentage:CGFloat ,changeCurrentIndex:Bool,animated:Bool ) -> Void in
            guard changeCurrentIndex == true else{return}
            oldCell?.label.textColor = UIColor.black
            newCell?.label.textColor  = UIColor.white
        }
  }
    
    @IBAction func slideButton(_ sender: Any) {
        SlideMune.showSideMenuVC(self)
        
    }
    
}
