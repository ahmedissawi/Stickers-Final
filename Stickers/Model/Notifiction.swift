//
//  Notifiction.swift
//  Stickers
//
//  Created by  Ahmed’s MacBook Pro on 3/12/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit

class Notifiction: NSObject {
    
    var message:String?
    var created_at:Date?
    
    
    init?(dictioary: [String: Any]) {
        
        if let value_ = dictioary["message"] as? String{
            message = value_
        }else{
            return nil
        }
        if let value_ = dictioary["created_at"] as? String{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            created_at = formatter.date(from: value_)
        }
    }
}
