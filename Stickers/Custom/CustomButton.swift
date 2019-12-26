//
//  CustomButton.swift
//  Stickers
//
//  Created by Ahmed on 2/14/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    override init(frame:CGRect){
        super.init(frame: frame)
        SetDeafult()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        SetDeafult()
    }
    
    
    func SetDeafult(){
        layer.cornerRadius = 10
    }


}
