//
//  URLProvider.swift
//  smartbnbkit
//
//  Created by Jelena Ristic on 8/28/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

class URLProvider: NSObject {
    static let kBaseUrl = "http://api.smartbnbkit.com/"
    static let kLoginUrl = "login"
    static let kSwitchUrl = "switch?token=%@"
    
    static func getUrlForLogin () -> String {
        return kBaseUrl.stringByAppendingString(kLoginUrl)
    }
    
    static func getUrlForSwitch () -> String? {
        let token = NSUserDefaults.standardUserDefaults().valueForKey(Constants.USER_TOKEN)
        
        guard let theToken = token as? String else {
            return nil
        }
        
        let params = String(format: kSwitchUrl, theToken)

        return kBaseUrl.stringByAppendingString(params)
    }
    
}
