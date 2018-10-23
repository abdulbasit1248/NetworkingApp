//
//  welcome.swift
//  Networking
//
//  Created by Abdul Basit on 23/10/2018.
//  Copyright © 2018 Abdul Basit. All rights reserved.
//

import Foundation
import  ObjectMapper

import Alamofire

import  UIKit



class Welcome :NSObject, Mappable
{
    
    var id: Int?
    var name, surname, email, telephone: String?
    var cellphone: String?
    var address, zipcode, city: Any?
    var authToken, businessName: String?
    var tokenExpiresAt: Int?
    var updatedAt, createdAt: String?

    required init?(map: Map) {
        
    }
    
     func mapping(map: Map) {
         id         <- map["id"]
        print(id!)
        name   <- map["name"]
        print (name!)
        surname   <- map["surname"]
        print(surname!)
        email   <- map["email"]
        print(email!)
        telephone   <- map["telephone"]
        print(telephone!)
        cellphone   <- map["cellphone"]
        print(cellphone!)
        address   <- map["address"]
        print(address!)
        zipcode   <- map["zipcode"]
        print(zipcode!)
        city   <- map["city"]
        print(city!)
        authToken   <- map["auth_token"]
        print(authToken!)
        businessName   <- map["business_name"]
        print(businessName!)
        tokenExpiresAt   <- map["token_expires_at"]
        print(tokenExpiresAt!)
        updatedAt   <- map["updated_at"]
        print(updatedAt!)
        createdAt   <- map["created_at"]
        print(createdAt!)
    }
    
    class func getUserInfo(successHandler:((_ result:Welcome?) -> Void)!, failure: ((_ error: NSError?) -> Void)!)
        -> Void {
            print("2")
            
            let username = "ham111@yahoo.com"
            let password = "password"

            var param:[String:Any] = [String:Any]()
            param["email"] = username
            param["password"] = password
            //URLconstants.LoginUrl
            NetworkManager.apiCommunication(_apiMethod: .post, _mapperClass: Welcome.self, _keyPath: "",_url: URLconstants.LoginUrl, parameters: param, encoding: JSONEncoding.default, successHandler: { (response, rToken) in
            successHandler(rToken)
        }) { (error) in
           failure(error)
        }
    }

}

