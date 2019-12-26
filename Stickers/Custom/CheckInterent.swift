//
//  CheckInterent.swift
//  Stickers
//
//  Created by  Ahmed’s MacBook Pro on 4/15/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import Foundation
import Alamofire
class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
