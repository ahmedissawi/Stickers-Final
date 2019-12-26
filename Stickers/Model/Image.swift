//
//  Image.swift
//  Stickers
//
//  Created by Ahmed on 2/26/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import RealmSwift

class ImageObject:Object{
    
    @objc dynamic var name = ""
    @objc dynamic var Coverimage:Data?
    var list =  List<singleImage>()
 
    
}
class singleImage:Object{
    
    @objc dynamic var image:Data?
    
}
