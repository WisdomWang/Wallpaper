

//
//  mainModel.swift
//  Wallpaper
//
//  Created by Cary on 2018/12/29.
//  Copyright © 2018 Cary. All rights reserved.
//

import UIKit
import ObjectMapper

class mainModel: NSObject,Mappable {
    
    var imageUrlBig:String?
    var imageUrlSmall:String?
    var title:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        imageUrlBig<-map["image_url"]
        imageUrlSmall<-map["thumb_url"]
        title<-map["title"]
    }
    
}
