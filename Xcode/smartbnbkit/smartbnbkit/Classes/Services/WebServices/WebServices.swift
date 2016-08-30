//
//  WebServices.swift
//  smartbnbkit
//
//  Created by Jelena Ristic on 8/28/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WebServices: NSObject {
    static let sharedInstance = WebServices()
    
    func loginUser (username : String, password : String, completed: () -> (), failed: (NSError?) -> ()) {
        
        let params = ["username" : username,
                      "password" : password]
        
        Alamofire.request(.POST, URLProvider.getUrlForLogin(), parameters:params)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .Success:
                    guard let value = response.result.value else {
                        failed(Utils.appError(nil, code: nil))
                        return
                    }
                    
                    let json = JSON(value)
                    
                    let error = json["error"].stringValue
                    if error.characters.count > 0 {
                        failed(Utils.appError(error, code: nil))
                        return
                    }
                    
                    let token = json["token"].stringValue
                    if token.characters.count > 0 {
                        NSUserDefaults.standardUserDefaults().setValue(token, forKey: Constants.USER_TOKEN)
                        NSUserDefaults.standardUserDefaults().synchronize()
                        
                        completed()
                    } else {
                        failed(Utils.appError(Constants.TOKEN_INVALID_ERROR_MESSAGE, code: nil))
                    }
                case .Failure(let error):
                    print(error)
                    failed(error)
                }
        }
    }
    
    func getSwitchStatus (completed: (Bool) -> (), failed: (NSError?) -> ()) {
        
        guard let requestUrl = URLProvider.getUrlForSwitch() else {
            failed(Utils.appError(Constants.TOKEN_INVALID_ERROR_MESSAGE, code: nil))
            return
        }
        
        Alamofire.request(.GET, requestUrl)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .Success:
                    guard let value = response.result.value else {
                        failed(Utils.appError(nil, code: nil))
                        return
                    }
                    
                    let json = JSON(value)
                    let status = json["status"].boolValue
                    completed(status)

                case .Failure(let error):
                    print(error)
                    failed(error)
                }
        }
    }
    
    func changeSwitchStatus (isOn : Bool, completed: (Bool) -> (), failed: (NSError?) -> ()) {
        
        guard let requestUrl = URLProvider.getUrlForSwitch() else {
            failed(Utils.appError(Constants.TOKEN_INVALID_ERROR_MESSAGE, code: nil))
            return
        }
        
        let params = ["status" : NSNumber.init(bool: isOn)]
        
        Alamofire.request(.POST, requestUrl, parameters:params)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .Success:
                    guard let value = response.result.value else {
                        failed(Utils.appError(nil, code: nil))
                        return
                    }
                    
                    let json = JSON(value)
                    let status = json["status"].boolValue
                    completed(status)
                    
                case .Failure(let error):
                    print(error)
                    failed(error)
                }
        }
    }
}
