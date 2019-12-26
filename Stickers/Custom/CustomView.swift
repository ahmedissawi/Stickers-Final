
//
//  CustomView.swift
//  Stickers
//
//  Created by Ahmed on 2/14/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit

class CustomView: UIView {

    override init(frame:CGRect){
        super.init(frame: frame)
        SetDeafult()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        SetDeafult()
    }
    
    func SetDeafult(){
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor(red:152/255, green:188/255, blue:83/255, alpha: 1).cgColor

    }
 
    

}
