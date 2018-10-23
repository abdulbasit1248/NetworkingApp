////
////  Company.swift
////  Networking
////
////  Created by Abdul Basit on 19/10/2018.
////  Copyright © 2018 Abdul Basit. All rights reserved.
////
//

import Foundation
import ObjectMapper
////
class Company:Mappable{
    var name:String?
    var catchPhrase:String?
    var bs:String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        name         <- map["name"]
        catchPhrase  <- map["catchPhrase"]
        bs  <- map["bs"]
    }
}
