//
//  CustomerService.swift
//  Networking
//
//  Created by Abdul Basit on 19/10/2018.
//  Copyright © 2018 Abdul Basit. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import  UIKit

class CustomerService {
    static let sharedInstance = CustomerService()
    private var manager: SessionManager
    static var customerObjects:[Customer]? = nil
    {
        didSet
        {
            if(customerObjects != nil)
            {
                let obj = NextViewController()
                obj.reload()
            }
        }
    }
    public init() {
        self.manager = Alamofire.SessionManager.default
    }
//this is the function to get the customers and convert it without completition handler
    func fillCustomers() ->Void
    {
        Alamofire.request("https://jsonplaceholder.typicode.com/users" ,method: .get).responseJSON
            {
                response in
                guard let responseJSON = response.result.value as? Array<[String: AnyObject]> else
                {
                    print("failure")
                    return
                }
                guard let customers: [Customer] = Mapper<Customer>().mapArray(JSONArray: responseJSON)
                    else
                {
                    print("failure")
                    return
                }
                if(customers != nil)
                {
                    CustomerService.customerObjects = customers
                }
        }
    }
    
func submitData()
    {
        
        let parameters: [String: Any] = [
        
            "business_owner":
                [
                    "email": "wahab111@yahoo.com",
                    "password": "password",
                    "password_confirmation": "password",
                    "business_name": "Business Name",
                    "name": "first name",
                    "surname": "last name",
                    "telephone": "121212",
                    "cellphone": "121212"
            ]
        
        ]
        
        Alamofire.request("https://nice2stay.net/en/api/v2/profiles", method: .post, parameters: parameters, encoding: JSONEncoding.default)
        .responseJSON { response in
            print(response)
        }
        
    }
// this is the function to get the customers with completition handler
    
    func getCostumers( completion:@escaping (Array<Any>) -> Void, failure:@escaping ( Int, String) -> Void) -> Void{
        
        let url: String = "https://jsonplaceholder.typicode.com/users"
        
        self.manager.request(url).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success:
                completion(response.result.value as! Array<Any>)
                print("congo")
                //process the JSON data
               
            case .failure(let error):
                failure(0,"Error \(error)")
            }
        }
      }
//function for user authentication
    
    func UserLogin() -> Void
    {
       
//        print ("In user Login function ")
//        let url = "https://nice2stay.net/en/api/v2/sessions"
//        let username = "ham111@yahoo.com"
//        let password = "password"
//        var param:[String:Any] = [String:Any]()
//        param["email"] = username
//        param["password"] = password
//        NetworkManager.apiCommunicationWithoutMapping(_apiMethod: .post, _url: URLconstants.LoginUrl, _parameters: param, successHandler: { (response) in
//        }) { (error) in
//            print("a")
//        }
        print("1")
        Welcome.getUserInfo(successHandler: {(refreshToken) in print(refreshToken?.id)}, failure: {(NSError) in print(NSError)})
        
    }
}
       

 

