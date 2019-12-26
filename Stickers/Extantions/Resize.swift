//
//  Resize.swift
//  Stickers
//
//  Created by  Ahmed’s MacBook Pro on 3/13/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import AlamofireImage
extension UIImage{

func convertToGrayscale() -> UIImage? {
    
    UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
    let imageRect = CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height)
    let context = UIGraphicsGetCurrentContext()
    
    // Draw a white background
    context!.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    context!.fill(imageRect)
    
    // optional: increase contrast with colorDodge before applying luminosity
    // (my images were too dark when using just luminosity - you may not need this)
    self.draw(in: imageRect, blendMode: CGBlendMode.colorDodge, alpha: 0.7)
    
    
    // Draw the luminosity on top of the white background to get grayscale of original image
    self.draw(in: imageRect, blendMode: CGBlendMode.luminosity, alpha: 0.90)
    
    // optional: re-apply alpha if your image has transparency - based on user1978534's answer (I haven't tested this as I didn't have transparency - I just know this would be the the syntax)
    // self.draw(in: imageRect, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
    
    let grayscaleImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return grayscaleImage
}
}
public struct GrayScaleFilter: ImageFilter {
    public init() {
    }
    
    public var filter: (UIImage) -> UIImage {
        return { image in
            return image.convertToGrayscale() ?? image
        }
    }
}
