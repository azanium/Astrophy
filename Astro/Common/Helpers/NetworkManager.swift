//
//  NetworkManager.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/19/17.
//  Copyright © 2017 Ainasoft. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class NetworkManager: NSObject {
    
    public static var isDebug = false
    
    typealias ResponseHandler = (Response)->Void
    
    enum Response {
        case Success(JSON)
        case Error(Int, String)
    }
    
    public static let shared: NetworkManager = {
        return NetworkManager()
    }()
    
    func post(url: String, params: [String:Any]? = nil, headers: [String:String]? = nil, resultHandler: ResponseHandler? = nil) {
        
        _request(method: .post, url: url, params: params, headers: headers, resultHandler: resultHandler)
        
    }
    
    func get(url: String, params: [String:Any]? = nil, headers: [String:String]? = nil, resultHandler: ResponseHandler? = nil) {
        
        _request(method: .get, url: url, params: params, headers: headers, resultHandler: resultHandler)
        
    }
    
    fileprivate func _request(method: HTTPMethod, url: String, params: [String:Any]? = nil, headers: [String:String]? = nil, resultHandler: ResponseHandler? = nil) {
        
        let apiUrl = ApiConstants.absoluteUrl(path: url)
        
        var _headers = [String:String]()
        
        if let headersRequest = headers {
            _headers = headersRequest
        }
        
        print("# Requesting \(method) : \(apiUrl) => params: \(String(describing: params)) => headers: \(String(describing: headers))")
        
        request(apiUrl,
                method: method,
                parameters: params,
                encoding: JSONEncoding.default,
                headers: _headers).responseJSON { (response) in
                    
                    if NetworkManager.isDebug {
                        print("==============================")
                        debugPrint(response)
                        print("==============================")
                    }
                    
                    if let jsonValue = response.result.value {
                        
                        let json = JSON(jsonValue)
                        
                        //print("jaonValue: \(json)")
                        
                        if let responseCode = json["responseCode"].string,let responseMessage = json["responseMessage"].string, let respCode = Int(responseCode) {
                            
                            //print("response: \(json)")
                            
                            if responseCode == "200" {
                                
                                resultHandler?(Response.Success(json))
                                
                            }
                            else {
                                
                                resultHandler?(Response.Error(respCode, responseMessage))
                                
                            }
                            
                        }
                        else {
                            
                            // TODO: Handle errors here
                            
                        }
                        
                    }
                    else {
                        if NetworkManager.isDebug {
                            debugPrint("# response json error: \(response.result)")
                        }
                        
                        // TODO: Handle errors here
                    }
        }
    }
}
