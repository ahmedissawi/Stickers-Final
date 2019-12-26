//
//  WebServices.swift
//  Stickers
//
//  Created by  Ahmed’s MacBook Pro on 3/7/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import Alamofire

class WebServices: NSObject {
    
    static func getIamgeObject( completion:@escaping (_ image:[ImageStickers]?, _ error: Error?) -> Void) {
        let urlpackages = Urls.packagesurl
        Alamofire.request(urlpackages).responseJSON { (dataRespnse) in
            switch dataRespnse.result {
            case .success(let value):
                if let jsonDic = value as? [String:Any]{
                    var imagessticker:[ImageStickers] = []
                    if let value_ = jsonDic["items"] as? [[String: Any]] {
                        for postDic in value_ {
                            if let post = ImageStickers(dictioary: postDic){
                                imagessticker.append(post)
                            }
                        }
                    }
                    completion(imagessticker,nil)
                }
                else{
                   completion(nil,nil)
                }
            case .failure(let error):
                completion(nil,error)
            }
         }
      }
    
//
//    static func getDeatiles( completion:@escaping (_ datadeatiles:[AppDeatiles]?, _ error: Error?) -> Void) {
//        let urlDeatiles  = Urls.DeatilesURl
//        Alamofire.request(urlDeatiles).responseJSON { (dataRespnse) in
//            switch dataRespnse.result {
//            case .success(let value):
//                if let jsonDic = value as? [String:Any]{
//                    var imagessticker:[AppDeatiles] = []
//                    if let value_ = jsonDic["items"] as? [[String: Any]] {
//                        for postDic in value_ {
//                            if let post = AppDeatiles(dictioary: postDic){
//                                imagessticker.append(post)
//                                print(post)
//                            }
//                        }
//                    }
//                    completion(imagessticker,nil)
//                }
//                else{
//                    completion(nil,nil)
//                }
//            case .failure(let error):
//                completion(nil,error)
//            }
//        }
//    }
    struct deatiles {
        var status:Bool?
        var message:String?
        
        
        init(dict: NSDictionary) {
            
            self.status = dict.value(forKey: "status") as? Bool ?? false
            self.message = dict.value(forKey: "message") as? String ?? ""
        }
        
    }
    static func sendGetRequest(url: String, completion: @escaping ((DataResponse<Any>,Error?)->Void)){
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default).responseJSON { (response) in
            
            if(response.result.isSuccess){
                completion(response,nil)
            }else{
                completion(response,response.result.error)
            }
        }
    }
    
    
    static func getnotifiction( completion:@escaping (_ image:[Notifiction]?, _ error: Error?) -> Void) {
        let urlnotfiction = Urls.NotificationsURl
        Alamofire.request(urlnotfiction).responseJSON { (dataRespnse) in
            switch dataRespnse.result {
            case .success(let value):
                if let jsonDic = value as? [String:Any]{
                    var imagessticker:[Notifiction] = []
                    if let value_ = jsonDic["items"] as? [[String: Any]] {
                        for postDic in value_ {
                            if let post = Notifiction(dictioary: postDic){
                                imagessticker.append(post)
                            }
                        }
                    }
                    completion(imagessticker,nil)
                }
                else{
                    completion(nil,nil)
                }
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
}


