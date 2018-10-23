//
//  NetworkManager.swift
//  HSK
//
//  Created by Talha Ejaz on 01/04/2017.
//  Copyright © 2017 consultant. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
//import Response

/// Enum for Restfull API method selection
//MARK: - Enum for RESTFULL methods
enum  CallingMethod {
    
    case get, post, put, delete
    var restMethods: Alamofire.HTTPMethod {
        var calledMethod: Alamofire.HTTPMethod
        switch self {
        case .get:
            calledMethod = .get
        case .post:
            calledMethod = .post
        case .put:
            calledMethod = .put
        case .delete:
            calledMethod = .delete
        }
        return calledMethod
    }
}
/// Class for Network Calls
class NetworkManager: NSObject {
    
    // MARK:- Header Method
    
    class func authorizationHeadersIf(authorized:Bool) -> [String: String]? {
        var headers:[String: String]? = nil
        if(authorized) {
            headers = [String : String]()
           // if let token = UserDefaults.object(forKey: UD_API_TOKEN) as? String {
             //   headers = ["token": token]
            //}
        }
        return headers
    }
    
    override init() {
        super.init()
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 240
    }
    // MARK:- API Methods
    
    /**
     API communication Method for response without mapping
     
     - parameter apiMethod:      API Method (.get, .post,.put,.delete)
     - parameter url:            URL of call
     - parameter parameters:     parameter append in URL
     - parameter successHandler: in case request is suceessfull
     - parameter failure:        faliuire block
     */
    
    class func apiCommunicationWithoutMapping(_apiMethod: CallingMethod, _url:String, _parameters:[String:Any]?,headerParam:Bool = false,encoding:ParameterEncoding = JSONEncoding.default, successHandler:((_ response: AnyObject?) -> Void)!,failure: ((_ _error: NSError?) -> Void)!) -> Void {
        
        Alamofire.request(_url, method: _apiMethod.restMethods, parameters: _parameters, encoding:encoding, headers: authorizationHeadersIf(authorized: headerParam)).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                let JSON = response.result.value as! NSDictionary
                print(JSON)
                successHandler?(JSON as AnyObject)
                break
                
            case .failure(let error):
                print(error)
                failure?(error as NSError?)
            }
        }
    }
    
    
    /**
     API communication Array Method for response without mapping
     
     - parameter apiMethod:      API Method (.get, .post,.put,.delete)
     - parameter url:            URL of call
     - parameter parameters:     parameter append in URL
     - parameter successHandler: in case request is suceessfull
     - parameter failure:        faliuire block
     */
    
    class func apiCommunicationArrayWithoutMapping(_apiMethod:CallingMethod, _url:String, _parameters:[String:Any]?,headerParam:Bool = false,encoding:ParameterEncoding = JSONEncoding.default, successHandler:((_ response: AnyObject?) -> Void)!,failure: ((_ _error: NSError?) -> Void)!) -> Void {
        
        Alamofire.request(_url, method: _apiMethod.restMethods, parameters: _parameters, encoding:encoding, headers: authorizationHeadersIf(authorized: headerParam)).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                let JSON = response.result.value as! Array<Any>
                print(JSON)
                successHandler?(JSON as AnyObject)
                break
                
            case .failure(let error):
                print(error)
                failure?(error as NSError?)
            }
        }
    }
    /**
     API communication Method for single object
     
     - parameter apiMethod:      API Method API Method (.get, .post,.put,.delete)
     - parameter mapperClass:    class that call the method and mapping information
     - parameter url:            URL of call
     - parameter parameters:     parameter append in URL
     - parameter successHandler: in case request is suceessfull
     - parameter failure:        faliuire block
     */
    
    class func apiCommunication<T:Mappable>(_apiMethod:CallingMethod,_mapperClass:T.Type,_keyPath:String,_url:String, parameters:[String:Any]?,headerParam:Bool = false,encoding:ParameterEncoding = JSONEncoding.default,successHandler:(( _ response: HTTPURLResponse?,  _ result:T?) -> Void)!,failure: (( _ error: NSError?) -> Void)!) -> Void {
        
        Alamofire.request(_url, method: _apiMethod.restMethods, parameters: parameters, encoding: encoding, headers: authorizationHeadersIf(authorized: headerParam)).responseObject { (_response:DataResponse<T>) in
            
            switch _response.result {
                
            case .success:
                print("3")
                print(_response.result.value)
                successHandler?(_response.response,_response.result.value)
                break
                
            case .failure(let error):
                print("4")
                failure?(error as NSError?)
            }
        }
    }
    
    /**
     API communication call for returing the array of objects
     
     - parameter apiMethod:      API Method (.get, .post,.put,.delete)
     - parameter mapperClass:    Mapping class of returing objects
     - parameter url:            URL to be called
     - parameter parameters:     Paarameters append in the request
     - parameter successHandler: success handler in case request is successfully executed
     - parameter failure:        faliuire handler
     */
    
    class func apiCommunicationArrayObjects<T:Mappable>(_ apiMethod:CallingMethod,mapperClass:T.Type,_keyPath:String, url:String, parameters:[String:Any]?,headerParam:Bool = false,encoding:ParameterEncoding = JSONEncoding.default,successHandler:((_ response: HTTPURLResponse?, _ result:[T]?) -> Void)!,failure: ((_ error: NSError?) -> Void)!) -> Void {
        
        Alamofire.request(url, method: apiMethod.restMethods, parameters: parameters, encoding: encoding, headers:authorizationHeadersIf(authorized: headerParam)).responseArray (keyPath: _keyPath){ (_response: DataResponse<[T]>) in
            switch _response.result {
                
            case .success:
                successHandler?(_response.response,_response.result.value)
                break
                
            case .failure(let error):
                failure?(error as NSError?)
                
            }
        }
    }
    
    
    /**
     API upload photo call for returing the array of objects
     
     - parameter apiMethod:      API Method (.get, .post,.put,.delete)
     - parameter mapperClass:    Mapping class of returing objects
     - parameter url:            URL to be called
     - parameter image:          Image to be upload
     - parameter successHandler: success handler in case request is successfully executed
     - parameter failure:        faliure handler
     */
//
    class func uploadTwoPhotosWithArrayObjects<T:Mappable>(_ apiMethod:CallingMethod,mapperClass:T.Type,_keyPath:String, url:String,params:[String:Any]? = nil , landscapeImage:UIImage!,potraitImage:UIImage!,headerParam:Bool = false,successHandler:((_ response: HTTPURLResponse?, _ result:[T]?) -> Void)!,failure: ((_ error: NSError?) -> Void)!) -> Void {

         let landscapeImgData = landscapeImage.jpegData(compressionQuality: 1)!
         let portaitImgData = potraitImage.jpegData(compressionQuality: 1)!
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if(params != nil) {
                for (key, value) in params! {

                    multipartFormData.append((value as! String).data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)!, withName: key )
                }
            }
            multipartFormData.append(landscapeImgData, withName: "landscape", fileName:"image.jpg", mimeType: "image/jpeg")
            multipartFormData.append(portaitImgData, withName: "portrait", fileName:"image.jpg", mimeType: "image/jpeg")

        }, to: url, method: apiMethod.restMethods, headers: authorizationHeadersIf(authorized: headerParam)) { (encodingResult) in

            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseArray(completionHandler: { (response: DataResponse<[T]>) in

                    switch response.result {
                    case .success:
                        successHandler?(response.response,response.result.value)
                        break

                    case .failure(let error):
                        failure?(error as NSError?)
                        break
                    }

                }
                )
            case .failure(let encodingError):
                failure?(encodingError as NSError?)
            }
        }
    }
//
    class func uploadPhotoArrayObjects<T:Mappable>(_ apiMethod:CallingMethod,mapperClass:T.Type,_keyPath:String, url:String,params:[String:Any]? = nil , image:UIImage!,headerParam:Bool = false,successHandler:((_ response: HTTPURLResponse?, _ result:[T]?) -> Void)!,failure: ((_ error: NSError?) -> Void)!) -> Void {

        let imgData = image.jpegData(compressionQuality: 0.6)!

        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if(params != nil) {
                for (key, value) in params! {

                    multipartFormData.append((value as! String).data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)!, withName: key )
                }
            }

            multipartFormData.append(imgData.base64EncodedData(), withName: "file", fileName:"file", mimeType: "image/jpeg")

        }, to: url, method: apiMethod.restMethods, headers: authorizationHeadersIf(authorized: headerParam)) { (encodingResult) in

            switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseArray(completionHandler: { (response: DataResponse<[T]>) in

                        switch response.result {
                            case .success:
                                successHandler?(response.response,response.result.value)
                                break

                            case .failure(let error):
                                failure?(error as NSError?)
                                break
                        }

                    }
                )
                case .failure(let encodingError):
                    failure?(encodingError as NSError?)
                }
           }
       }


    /**
     API upload photo call for returing the array of objects

     - parameter apiMethod:      API Method (.get, .post,.put,.delete)
     - parameter mapperClass:    Mapping class of returing objects
     - parameter url:            URL to be called
     - parameter image:          Image to be upload
     - parameter successHandler: success handler in case request is successfully executed
     - parameter failure:        faliure handler
     */

    class func uploadFileWithObject<T:Mappable>(_ apiMethod:CallingMethod,mapperClass:T.Type,_keyPath:String, url:String,params:[String:Any]? = nil,memeType:String = "application/pdf",fileName:String = "file.pdf", path:String,headerParam:Bool = false,successHandler:((_ response: HTTPURLResponse?, _ result:T?) -> Void)!,failure: ((_ error: NSError?) -> Void)!) -> Void {

        do {
            let fileURL = URL.init(fileURLWithPath: path)

            var  imgData = try Data.init(contentsOf: fileURL)
            let imageSize: Int = imgData.count / 1024
            print("size of file in KB: %f ", imageSize)

            Alamofire.upload(multipartFormData: { (multipartFormData) in
                if(params != nil) {
                    for (key, value) in params! {

                        multipartFormData.append(("\(value)").data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)!, withName: key )

                    }
                }
                multipartFormData.append(imgData, withName: "file", fileName:fileName, mimeType: memeType)

            }, to: url, method: apiMethod.restMethods, headers: authorizationHeadersIf(authorized: headerParam)) { (encodingResult) in

                switch encodingResult {
                case .success(let upload, _, _):

                    upload.responseObject(completionHandler: { (response: DataResponse<T>) in

                        switch response.result {
                        case .success:
                            successHandler?(response.response,response.result.value)
                            break

                        case .failure(let error):
                            failure?(error as NSError?)
                            break
                        }

                    }
                    )
                case .failure(let encodingError):
                    failure?(encodingError as NSError?)
                }
            }
        } catch  {
            failure(error as NSError)
        }

    }

    /**
     API upload photo call for returing the array of objects

     - parameter apiMethod:      API Method (.get, .post,.put,.delete)
     - parameter mapperClass:    Mapping class of returing objects
     - parameter url:            URL to be called
     - parameter image:          Image to be upload
     - parameter successHandler: success handler in case request is successfully executed
     - parameter failure:        faliure handler
     */

    class func uploadPhotoWithObject<T:Mappable>(_ apiMethod:CallingMethod,mapperClass:T.Type,_keyPath:String, url:String,params:[String:Any]? = nil , image:UIImage!,headerParam:Bool = false,successHandler:((_ response: HTTPURLResponse?, _ result:T?) -> Void)!,failure: ((_ error: NSError?) -> Void)!) -> Void {
        var descompressFactor:CGFloat = 1.0
        var imgData = image.jpegData(compressionQuality: descompressFactor)!
        var imageSize: Int = imgData.count / 1024
        print("size of image in KB: %f ", imageSize)
        print(imgData.count)
        while imageSize > 1024 {
            descompressFactor -= 0.1
            imgData = image.jpegData(compressionQuality: descompressFactor)!
            imageSize = imgData.count / 1024
            print("size of image in KB: %f ", imageSize)

        }

        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if(params != nil) {
                for (key, value) in params! {

                        multipartFormData.append(("\(value)").data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)!, withName: key )

                }
            }
            multipartFormData.append(imgData, withName: "file", fileName:"file.jpg", mimeType: "image/jpeg")

        }, to: url, method: apiMethod.restMethods, headers: authorizationHeadersIf(authorized: headerParam)) { (encodingResult) in

            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseObject(completionHandler: { (response: DataResponse<T>) in

                    switch response.result {
                    case .success:
                        successHandler?(response.response,response.result.value)
                        break

                    case .failure(let error):
                        failure?(error as NSError?)
                        break
                    }

                }
                )
            case .failure(let encodingError):
                failure?(encodingError as NSError?)
            }
        }
    }

    /**
     API upload photo call for returing the array of objects

     - parameter apiMethod:      API Method (.get, .post,.put,.delete)
     - parameter mapperClass:    Mapping class of returing objects
     - parameter url:            URL to be called
     - parameter data:           file data to be upload
     - parameter successHandler: success handler in case request is successfully executed
     - parameter failure:        faliure handler
     */

    class func uploadFileDataWithObject<T:Mappable>(_ apiMethod:CallingMethod,mapperClass:T.Type,_keyPath:String,key:String,fileName:String,type:String, url:String,params:[String:Any]? = nil , data:Data!,headerParam:Bool = false,successHandler:((_ response: HTTPURLResponse?, _ result:T?) -> Void)!,failure: ((_ error: NSError?) -> Void)!) -> Void {


        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if(params != nil) {
                for (key, value) in params! {

                    multipartFormData.append((value as! String).data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)!, withName: key )
                }
            }
            multipartFormData.append(data, withName: key, fileName:fileName, mimeType: type)

        }, to: url, method: apiMethod.restMethods, headers: authorizationHeadersIf(authorized: headerParam)) { (encodingResult) in

            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseObject(completionHandler: { (response: DataResponse<T>) in

                    switch response.result {
                    case .success:
                        successHandler?(response.response,response.result.value)
                        break

                    case .failure(let error):
                        failure?(error as NSError?)
                        break
                    }

                }
                )
            case .failure(let encodingError):
                failure?(encodingError as NSError?)
            }
        }
    }

}

