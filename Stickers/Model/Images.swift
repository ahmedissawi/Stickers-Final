//
//  Images.swift
//  Stickers
//
//  Created by  Ahmed’s MacBook Pro on 3/7/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit

class Images: NSObject {
    
    var id:Int?
    var image:URL?
    var package_id:Int?
    var is_free:String?

    
    
    
    init?(dictioary: [String: Any]) {
        if let value_ = dictioary["id"] as? Int{
            id = value_
        }else{
            return nil
        }
        if let value_  = dictioary["stkr_png"] as? String{
            image = URL(string: value_)
        }
        if let value_  = dictioary["is_free"] as? String{
            is_free = value_
        }

   }
}
