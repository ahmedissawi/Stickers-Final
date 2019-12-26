//
//  AppsStickers.swift
//  Stickers
//
//  Created by Ahmed on 2/17/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//
extension String {
    
    static func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}
import UIKit
import Alamofire
import MBProgressHUD
import SDWebImage
import Toucan


class AppsStickers: UIViewController {

    @IBOutlet weak var ViewAll: UIView!
    
    @IBOutlet weak var viewApps: UIView!
    
    @IBOutlet weak var whatsapp: UIImageView!
    @IBOutlet weak var AddWhatsapp: UIButton!
    
    @IBOutlet weak var lineone: UIView!
    
    @IBOutlet weak var Close: UIButton!
    
    private var stickerPacks: [StickerPack] = []
    private var stickersname :[ImageStickers]  = []
    var imgStickers:ImageStickers?
    
    
    var img:[Images] = []
    var FreeItem:[Images] = []
    var imageData:[Data] = []

    var listPath:[String] = []
    var MainImage = ""
    var MainImageData:Data!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    func dwomloadAllimgaes(index:Int){
     let   boolValue = UserDefaults.standard.bool(forKey: "isPurchased")

        if (!boolValue){
         FreeItem =  img.filter{$0.is_free ==  "1"}
        }else{
            FreeItem =  img
        }
//        for item in FreeItem{
            let url = FreeItem[index].image
            
            
            let audioFileName = String((url?.lastPathComponent)!) as NSString
            var nameFile = ""
            //path extension will consist of the type of file it is, m4a or mp4
            let pathExtension = audioFileName.pathExtension
            
            let destination: DownloadRequest.DownloadFileDestination = { _, _ in
                var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                
                // the name of the file here I kept is yourFileName with appended extension
                nameFile = String.random()+"."+pathExtension
                self.listPath.append(nameFile)

                documentsURL.appendPathComponent(nameFile)
                return (documentsURL, [.removePreviousFile])
            }
            
            Alamofire.download(url!, to: destination).response { response in
                if response.destinationURL != nil {
                    print(response.destinationURL!)
                    if self.listPath.count == self.FreeItem.count {
                        self.goWhats()
                        MBProgressHUD.hide(for: self.view, animated: true)
                        self.dismiss(animated: true, completion: nil)
                        
                    }else{
                        self.dwomloadAllimgaes(index: index + 1)
                    }
                    
                }
            }
//        }
    }
    
    func dwomloadimgaes(){
        let url = self.imgStickers?.image
        
        let audioFileName = String((url!.lastPathComponent)) as NSString
        var nameFile = ""
        //path extension will consist of the type of file it is, m4a or mp4
        let pathExtension = audioFileName.pathExtension
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            // the name of the file here I kept is yourFileName with appended extension
            nameFile = String.random()+"."+pathExtension
            documentsURL.appendPathComponent(nameFile)
            return (documentsURL, [.removePreviousFile])
        }
        
        Alamofire.download(url!, to: destination).response { response in
            if response.destinationURL != nil {
                print(response.destinationURL!)
                
                self.MainImage = nameFile
                let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
                let userDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
                let paths             = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
                let imageURL = URL(fileURLWithPath: paths.first!).appendingPathComponent(self.MainImage)
                let image    = UIImage(contentsOfFile: imageURL.path)
                self.MainImageData = image!.pngData()
                self.dwomloadAllimgaes(index: 0)
                
            }
        }
        
    }
    func goWhats(){
        
        let vatc  = String(MainImageData.base64EncodedString(options: .lineLength64Characters))
        do{
            let stickerPack = try StickerPack(identifier: (imgStickers?.name)!,
                                              name: (imgStickers?.name)!,
                                              publisher: ("ملصقات احترافية"),
                                              trayImageFileName: vatc,
                                              publisherWebsite: "",
                                              privacyPolicyWebsite: "",
                                              licenseAgreementWebsite: "")
            
            for url in listPath{
                let filename = url
                //                let image = UIImage(contentsOfFile: filename) //this also doesn't work but the path i got starts (at least in the sim) with file://
                let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
                let userDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
                let paths             = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
                let imageURL = URL(fileURLWithPath: paths.first!).appendingPathComponent(filename)
                let image    = UIImage(contentsOfFile: imageURL.path)
                let dataImage = image!.pngData()
                
                do {
                    try stickerPack.addSticker(imageData: dataImage!, type: ImageDataExtension(rawValue: "png")!, emojis: [""])
                    
                    
                } catch StickerPackError.stickersNumOutsideAllowableRange {
                    fatalError("Sticker count outside the allowable limit (\(Limits.MaxStickersPerPack) stickers per pack).")
                } catch StickerPackError.fileNotFound {
                    print("\(filename) not found.")
                } catch StickerPackError.unsupportedImageFormat(let imageFormat) {
                    fatalError("\(filename): \(imageFormat) is not a supported format.")
                } catch StickerPackError.imageTooBig(let imageFileSize) {
                    let roundedSize = round((Double(imageFileSize) / 1024) * 100) / 100;
                    fatalError("\(filename): \(roundedSize) KB is bigger than the max file size (\(Limits.MaxStickerFileSize / 1024) KB).")
                } catch StickerPackError.incorrectImageSize(let imageDimensions) {
                    fatalError("\(filename): \(imageDimensions) is not compliant with sticker images dimensions, \(Limits.ImageDimensions).")
                } catch StickerPackError.animatedImagesNotSupported {
                    fatalError("\(filename) is an animated image. Animated images are not supported.")
                } catch StickerPackError.tooManyEmojis {
                    fatalError("\(filename) has too many emojis. \(Limits.MaxEmojisCount) is the maximum number.")
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
            stickerPack.sendToWhatsApp { completed in
                MBProgressHUD.hide(for: self.view, animated: true)
                return
            }
        }catch {
            
        }
    }
    
    

    
    @IBAction func CloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        MBProgressHUD.hide(for: self.view, animated: true)

        
    }
    
    @IBAction func WhtasappAdd(_ sender: Any) {
       MBProgressHUD.showAdded(to: self.view, animated: true)
       dwomloadimgaes()
        
    }
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                
          
                

                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsDirectory.appendingPathComponent("dsa.png")
            if let datda = image.pngData(){
                do {
                    print("saving")
                    
                    try data.write(to: fileURL)
                } catch {
                    print("error saving file to documents:", error)
                }
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
