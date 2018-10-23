//
//  Customer.swift
//  Networking
//
//  Created by Abdul Basit on 19/10/2018.
//  Copyright © 2018 Abdul Basit. All rights reserved.
//

import Foundation
import  ObjectMapper

class Customer:Mappable
{
    required init?(map: Map) {
        
    }
    
    var id: Int?
    var name: String?
    var username:String?
    var email:String?
    var phone:String?
    var website:String?

    var address:Address?
    var company: Company?
    
//    required init?(map: Map) {
//        
//    }
    
    func mapping(map: Map) {
        id            <- map["id"]
        name          <- map["name"]
        username      <- map["username"]
        email         <- map["email"]
        phone         <- map["phone"]
        website       <- map["website"]
        company        <- map["company"]
        address        <- map["address"]
    }
    func returnname() ->String
    {
        return name!
    }
}
