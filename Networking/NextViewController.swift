//
//  NextViewController.swift
//  Networking
//
//  Created by Abdul Basit on 19/10/2018.
//  Copyright © 2018 Abdul Basit. All rights reserved.
//

import UIKit
import Alamofire

class NextViewController: UIViewController  {
   
    @IBOutlet weak var activitybar: UIActivityIndicatorView!
    var myArray : [Customer]?
    {
        didSet
        {
            if(myArray != nil)
            {
                print("OMG SET")
            }
        }
    }
    var obj = CustomerService()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        if let token = defaults.value(forKey: "Token") as? String {
            print("defaults Token: \(token)")
        }
        else
        {
        print("No token exists there")
        }
       // obj.fillCustomers()
       // obj.getCostumers(completion: {(Array) -> Void in print(Array)}, failure: {(value , value2) -> Void in print("\(value)")})
       // obj.UserLogin()
        //obj.submitData()
        myArray = CustomerService.customerObjects
        activitybar.startAnimating()
        Welcome.getUserInfo(successHandler: {(refreshToken) in
             //self.activitybar.stopAnimating()
            
            self.activitybar.isHidden = true
         //   let abc : [Welcome] = refreshToken?.value(forKeyPath: )
            print(refreshToken?.id)},
                            failure: {(NSError) in print(NSError)})
        reload()

    }
    func reload()
    {
        if let abc :[Customer] = CustomerService.customerObjects
        {
            print (abc[0].name)
            print(abc[1].email!)
        }
        else
        {
            print("-------")
        }
    }
   
}
