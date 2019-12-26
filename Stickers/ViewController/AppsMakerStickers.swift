//
//  AppsMakerStickers.swift
//  Stickers
//
//  Created by  Ahmed’s MacBook Pro on 3/21/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import MBProgressHUD
import Toucan
import UIImage_ImageCompress

class AppsMakerStickers: UIViewController {
    
    var imgseclected : ImageObject?
    var img:[UIImage] = []
    var MainImageData:Data!
    var  relam = try! Realm()

    func getimg(image:Data) -> UIImage {
        let img = UIImage(data: image)
        return img!
    }
    func goWhats(){

        let imgs = getimg(image: (imgseclected?.Coverimage!)!)
        let imagemain = imgs.scaleImage(toSize: CGSize(width: 48, height: 48))
        MainImageData = imagemain?.pngData()
        
        let vatc  = String(MainImageData!.base64EncodedString(options: .lineLength64Characters))

        do{
            let stickerPack = try StickerPack(identifier: (imgseclected?.name)!,
                                              name: (imgseclected?.name)!,
                                              publisher: (imgseclected?.name)!,
                                              trayImageFileName: vatc,
                                              publisherWebsite: "",
                                              privacyPolicyWebsite: "",
                                              licenseAgreementWebsite: "")
            
            

            for item in img{

                let imgSize = item.scaleImage(toSize: CGSize(width: 256, height: 256))
                let compressedImage = UIImage.compressImage(imgSize, compressRatio: 0.9)

                let dataImage = compressedImage!.pngData()
                let imageSize: Int = dataImage!.count
                print("size of image in KB: %f ", Double(imageSize) / 1024.0)

                
                do {
                    try stickerPack.addSticker(imageData: dataImage!, type: ImageDataExtension(rawValue: "png")!, emojis: [""])
                
                    
                } catch StickerPackError.stickersNumOutsideAllowableRange {
                    fatalError("Sticker count outside the allowable limit (\(Limits.MaxStickersPerPack) stickers per pack).")
                } catch StickerPackError.fileNotFound {
                    print("() not found.")
                } catch StickerPackError.unsupportedImageFormat(let imageFormat) {
                    fatalError(" \(imageFormat) is not a supported format.")
                } catch StickerPackError.imageTooBig(let imageFileSize) {
//                    let roundedSize = round((Double(imageFileSize) / 1024) * 100) / 100;
                    let alert = UIAlertController(title: "اضافة صور ", message: "عليك باضافة صور حجمها اقل من ك100", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "موافق", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)                } catch StickerPackError.incorrectImageSize(let imageDimensions) {
                    fatalError(": \(imageDimensions) is not compliant with sticker images dimensions, \(Limits.ImageDimensions).")
                } catch StickerPackError.animatedImagesNotSupported {
                    fatalError(" is an animated image. Animated images are not supported.")
                } catch StickerPackError.tooManyEmojis {
                    fatalError(" has too many emojis. \(Limits.MaxEmojisCount) is the maximum number.")
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
            stickerPack.sendToWhatsApp { completed in
                return
            }
        }catch {
            fatalError(error.localizedDescription)

        }
    }

    @IBAction func AddtoWhatsapp(_ sender: Any) {
        goWhats()
    }
    
    @IBAction func closeButton(_ sender: Any) {
      self.dismiss(animated: true, completion: nil)

    }
    
}
