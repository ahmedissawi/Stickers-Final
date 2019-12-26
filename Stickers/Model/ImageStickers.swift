//
//  ImageStickers.swift
//  Stickers
//
//  Created by  Ahmed’s MacBook Pro on 3/7/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit

class ImageStickers: NSObject {
    
    var id:Int?
    var name:String?
    var image:URL?
    var status:Bool?
    var is_close:Bool?
    var created_at : Date?
    var images:[Images] = []
    
    
    init?(dictioary: [String: Any]) {
        
        if let value_ = dictioary["id"] as? Int{
            id = value_
        }else{
            return nil
        }
        if let value_  = dictioary["name"] as? String{
            name = value_
        }else{
            return nil
        }
        if let value_  = dictioary["cover_png"] as? String{
            image = URL(string: value_)
        }
        if let value_ = dictioary["images"] as? [[String:Any]] {
            for imgDic in value_ {
                if let img = Images(dictioary: imgDic){
                    images.append(img)
                }
            }
        }
    }
 
}
