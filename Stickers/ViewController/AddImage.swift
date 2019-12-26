//
//  AddImage.swift
//  Stickers
//
//  Created by Ahmed on 2/17/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import GoogleMobileAds
import RealmSwift
import AlamofireImage
import Toucan


class AddImage: UIViewController,StickersAddAction {
    func getimage(data: UIImage) {
    }
//    var  relam = try! Realm()
    
    
    var listimage : [Int:UIImage] = [:]
    
    var selectedimage:UIImage?
    @IBOutlet weak var deafultimage: UIImageView!
    

    @IBOutlet weak var ButtonName: UIButton!
    @IBOutlet weak var NameStickers: UILabel!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var ViewAds: GADBannerView!
    @IBOutlet weak var ViewLabel: UIView!
    @IBOutlet weak var Collection: UICollectionView!
    @IBOutlet weak var StickersImg: UIImageView!
    @IBOutlet weak var ButtonSave: UIButton!
    var mainimage:UIImagePickerController?
    var collectionimage:UIImagePickerController!
    var selectIndex = 0
    func getActionimage(_ data: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    func getimage(_ data: Any) {
        let pickercontroller = UIImagePickerController()
        pickercontroller.delegate = self
        pickercontroller.allowsEditing = true
        present(pickercontroller, animated: true, completion: nil)
    }
    
//    func addObject (image : Data, cover:List<Data>)  -> ImageObject
//    {
//        let newObject = ImageObject()
//        newObject.Coverimage = image
////        newObject.list = cover
//        return newObject
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        TabImgProfile()
        setupview()
        let nib = UINib(nibName: "StickersAddCell", bundle: nil)
        Collection.register(nib, forCellWithReuseIdentifier: "StickersAddCell")      
    }
    
    
    func TabImgProfile(){
        let tab = UITapGestureRecognizer(target: self, action: #selector(handelimage))
        StickersImg.addGestureRecognizer(tab)
        StickersImg.isUserInteractionEnabled = true
    }
    @objc func handelimage(){
        mainimage = UIImagePickerController()
        mainimage!.delegate = self
        mainimage!.allowsEditing = true
        present(mainimage!, animated: true, completion: nil)
    }

    
    func setupview(){
            ViewLabel.layer.cornerRadius = 15
            ViewLabel.layer.borderWidth = 1
            ViewLabel.layer.borderColor = UIColor(red:221/255, green:219/255, blue:72/255, alpha: 1).cgColor
        let adRequest = GADRequest()
        //ca-app-pub-3940256099942544/2934735716
        
        adRequest.testDevices = [ kGADSimulatorID,"ca-app-pub-3722926456427001/9277896824"]

        
        ViewAds.adUnitID = "ca-app-pub-3722926456427001/9277896824"
        ViewAds.rootViewController = self
        ViewAds.load(adRequest)
    }
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(targetSize, !hasAlpha, scale)
        image.draw(in: CGRect(origin: CGPoint.zero, size: targetSize))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
    
    @IBAction func ButtonSave(_ sender: Any) {
        guard selectedimage != nil else{
            let alert = UIAlertController(title: "عليك بإضافة صورة للحزمة", message: " تحتاج الى اضافة صورة الحزمة", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "موافق", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return}
        
        guard  let name =  NameStickers.text,!name.isEmpty,name != "حزمة الملصقات 1"  else{
            let alert = UIAlertController(title: "عليك بإضافة اسم  للحزمة", message: " تحتاج الى اضافة اسم الحزمة", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "موافق", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return}
        
        guard listimage.count >= 3 else {
            let alert = UIAlertController(title: "اضافة ملصقات", message: "أضف 3 ملصقات على الأقل", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "موافق", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        guard listimage.count <= 30 else {
            let alert = UIAlertController(title: "اضافة ملصقات", message: "لقد تجاوزت الحد المسموح للملصقات ", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "موافق", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let listDataimage  = ImageObject()
        for (_,value) in listimage {
            let imgSize = Toucan(image: value).resize(CGSize(width: 512.0, height: 512.0)).maskWithEllipse().image
            

            let data = imgSize!.pngData()
            let Dataimage  = singleImage()
            Dataimage.image = data
            listDataimage.list.append(Dataimage)
        }
        self.selectedimage =  selectedimage?.scaleImage(toSize: CGSize(width: 96, height: 96))
        let data = selectedimage!.pngData()
        listDataimage.Coverimage = data
        listDataimage.name = self.NameStickers.text!
        DispatchQueue.main.async{
        do{
            let relam = try! Realm()
            try relam.write {
                relam.add(listDataimage)
                let object = relam.objects(ImageObject.self)
                let alert = UIAlertController(title: "اضافة الحزمة", message: " تم اضافة الحزمة بنجاح", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "موافق", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print(object.map{$0})
            }
        }
        catch{
            let alert = UIAlertController(title: "خطا ", message: " حاول مرة اخر حدث خطآ اثناء الحفظ", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "موافق", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    
@IBAction func ButtonAddName(_ sender: Any) {
        self.showInputDialog(title: "اضافة اسم الحزمة", subtitle: "الرجاء اضافة اسم الحزمة الخاصة بك ", actionTitle: "اضافة", cancelTitle: "الغاء", inputPlaceholder: "الرجاء ادخال الاسم", inputKeyboardType: .default, cancelHandler: nil) { (input:String?) in
            self.NameStickers.text = input
            
        }
    }
}
extension AddImage:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listimage.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == listimage.count - 1{
            return
        }
        selectIndex = indexPath.row
        collectionimage = UIImagePickerController()
        collectionimage.delegate = self
        collectionimage.allowsEditing = true
        present(collectionimage, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = Collection.dequeueReusableCell(withReuseIdentifier: "StickersAddCell", for: indexPath) as! StickersAddCell
        cell.numberlabel.text = "\(indexPath.row + 1)"
        if let image = self.listimage [indexPath.row]{
            cell.StickersCellImage.image = image
        }else{
            cell.StickersCellImage.image = UIImage(named: "icons8-plus-filled")
        }
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
    
  
    @objc   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let cropRect = info[UIImagePickerController.InfoKey.cropRect] as? CGRect {
        if picker == mainimage{
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            selectedimage = image
//            StickersImg.image  = image
            let imageRef: CGImage = image.cgImage!.cropping(to: cropRect)!
            let image1: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
            StickersImg.image  = image1
          }
            }
        }
        if let cropRect = info[UIImagePickerController.InfoKey.cropRect] as? CGRect {
        if picker == collectionimage{
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
//                listimage [selectIndex] = image
                let imageRef: CGImage = image.cgImage!.cropping(to: cropRect)!
                let image1: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
                listimage [selectIndex] = image1
                self.Collection.reloadData()
            }
        }
        }
        dismiss(animated: true, completion: nil)
    }
}
