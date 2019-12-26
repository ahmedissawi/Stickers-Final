//
//  AppConfig.swift
//  Stickers
//
//  Created by  Ahmed’s MacBook Pro on 3/10/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit

class AppDeatiles: NSObject {

    var key:String?
    var value:String?
    
    init?(dictioary: [String: Any]) {
        
        if let value_ = dictioary["key"] as? String{
            key = value_
        }else{
            return nil
        }
        if let value_ = dictioary["value"] as? String{
            value = value_
            print(value)
        }else{
            return nil
        }
    }
}
