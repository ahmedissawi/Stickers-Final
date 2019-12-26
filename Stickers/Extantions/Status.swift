//
//  Status.swift
//  Stickers
//
//  Created by  Ahmed’s MacBook Pro on 4/1/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}
