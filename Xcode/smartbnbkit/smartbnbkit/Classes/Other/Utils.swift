//
//  Utils.swift
//  smartbnbkit
//
//  Created by Jelena Ristic on 8/28/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

class Utils: NSObject {

    static func showInfoAlert (viewControler : UIViewController, title : String?, message : String?) {
        let alert = UIAlertController(title: title, message: message , preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil));

        viewControler.presentViewController(alert, animated: true, completion: nil)
    }
    
    static func showErrorAlert (viewControler : UIViewController, error : NSError?) {
        let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? Constants.GENERAL_ERROR_MESSAGE , preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil));
        
        viewControler.presentViewController(alert, animated: true, completion: nil)
    }
    
    static func appError (message : String?, code : Int?) -> NSError {
        return NSError.init(domain: Constants.APP_NAME, code: code ?? 0, userInfo: [NSLocalizedDescriptionKey : message ?? Constants.GENERAL_ERROR_MESSAGE])
    }
}
