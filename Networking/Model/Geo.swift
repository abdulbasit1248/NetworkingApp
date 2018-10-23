//
//  Geo.swift
//  Networking
//
//  Created by Abdul Basit on 19/10/2018.
//  Copyright © 2018 Abdul Basit. All rights reserved.
//

import Foundation
import ObjectMapper

class Geo:Mappable
{
    var lat: String?
    var lng:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        lat         <- map["lat"]
        lng          <- map["lng"]
    }
}
