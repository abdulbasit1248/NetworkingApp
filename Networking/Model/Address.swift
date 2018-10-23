//
//  Address.swift
//  Networking
//
//  Created by Abdul Basit on 19/10/2018.
//  Copyright © 2018 Abdul Basit. All rights reserved.
//

import Foundation
import  ObjectMapper

class Address:Mappable
{
    var street: String?
    var suite:String?
    var city:String?
    var zipcode:String?
    var geo:Geo?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        street         <- map["street"]
        suite          <- map["suite"]
        city           <- map["city"]
        zipcode        <- map["zipcode"]
        geo            <- map["geo"]
        
    }
}
