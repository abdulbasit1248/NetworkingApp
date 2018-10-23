//
//  ViewController.swift
//  Networking
//
//  Created by Abdul Basit on 18/10/2018.
//  Copyright © 2018 Abdul Basit. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var DollarLabel: UILabel!
    @IBAction func Fetch(_ sender: Any) {
        fetchData()
        
        
    }
    func fetchData()
    {
        let url = URL(string: "http://jsonplaceholder.typicode.com/users/3")
        let session = URLSession.shared // or let session = URLSession(configuration: URLSessionConfiguration.default)
        if let usableUrl = url {
            let task = session.dataTask(with: usableUrl, completionHandler: { (data, response, error) in
                if let data = data {
                    if let stringData = String(data: data, encoding: String.Encoding.utf8) {
                        print(stringData) //JSONSerialization
                       // stringData.
                    }
                }
            })
            task.resume()
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("helloooooooo")
        fetchingFromAlamofire()
        Alamofire.request("https://api.coindesk.com/v1/bpi/currentprice.json", method: .get).responseJSON{
            response in
            print (response)
            if  response != nil
            {
                if let bitcoinJASON = response.result.value
                {
                    if let bitcoinObject : Dictionary = bitcoinJASON as? Dictionary <String, Any>
                    {
                        if let bpiObject: Dictionary = (bitcoinObject["bpi"] as! Dictionary<String, Any>)
                        {
                            if let usdObject :Dictionary = bpiObject["USD"] as!Dictionary<String,Any>
                            {
                                if let Rate:String = usdObject ["rate"] as! String
                                {
                                    print (Rate)
                                    let rate2: String = "dollars"
                                    self.DollarLabel.text = ("$\(Rate)")
                                }
                            }
                        }
                    }
                }
            }
        }

    }
    func fetchingFromAlamofire()
    {
       
    }


}

