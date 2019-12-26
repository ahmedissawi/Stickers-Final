//
//  MakerStickersCell.swift
//  Stickers
//
//  Created by Ahmed on 2/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import AlamofireImage

class MakerStickersCell: UICollectionViewCell {
    
    @IBOutlet weak var ImageMakeSticker: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
    }
    
  
}
