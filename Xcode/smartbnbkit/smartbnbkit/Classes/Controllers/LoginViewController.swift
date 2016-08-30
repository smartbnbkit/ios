//
//  LoginViewController.swift
//  smartbnbkit
//
//  Created by Roman Stetsenko on 8/23/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var maskotView: MaskotView!
    @IBOutlet var loginField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!

    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViews()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            self.blink(delay: 4.0)
        })
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillChange(_:)),
                                                         name: UIKeyboardWillChangeFrameNotification,
                                                         object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillChange(_:)),
                                                         name: UIKeyboardWillHideNotification,
                                                         object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self,
                                                            name: UIKeyboardWillChangeFrameNotification,
                                                            object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self,
                                                            name: UIKeyboardWillHideNotification,
                                                            object: nil)
    }

    // MARK: -
    
    func hideKeyboard () {
        view.endEditing(true)
    }
    
    func setupViews() {
        loginField.textColor = StyleKit.appDarkGray
        loginField.layer.cornerRadius = loginField.frame.height/2
        loginField.layer.borderWidth = 1
        loginField.layer.borderColor = StyleKit.appLightGray.CGColor

        passwordField.textColor = StyleKit.appDarkGray
        passwordField.layer.cornerRadius = passwordField.frame.height/2
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = StyleKit.appLightGray.CGColor

        loginButton.layer.cornerRadius = loginButton.frame.height/2
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(LoginViewController.hideKeyboard))
        view.addGestureRecognizer(tap)
    }

    func blink(delay delay: Double) {
        self.maskotView.blink()
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.3 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { [weak self] in
            self?.maskotView.blink()
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay/2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { [weak self] in
                self?.maskotView.blink()
                self?.blink(delay: delay)
                })
            })
    }
    
    func keyboardWillChange (notification : NSNotification) {
        let notificationInfo : Dictionary = (notification.userInfo as! Dictionary<String, AnyObject>)
        let keyboardSize = notificationInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size.height
        
        if notification.name ==  UIKeyboardWillHideNotification{
            scrollView.setContentOffset(CGPointZero, animated: true)
            return
        }
        
        var tf : UITextField?
        
        if loginField.isFirstResponder() {
            tf = loginField
        }
        else if passwordField.isFirstResponder() {
            tf = passwordField
        }
        
        if tf != nil {
            let tfRect = tf?.superview!.convertRect(tf!.frame, toView: scrollView)
            
            if CGRectGetMaxY(tfRect!) > view.frame.size.height - keyboardSize! - 35 {
                scrollView.setContentOffset(CGPointMake(0, CGRectGetMaxY(tfRect!) - view.frame.size.height + keyboardSize! + 35), animated: true)
            }
            else {
                scrollView.setContentOffset(CGPointZero, animated: true)
            }
        }
    }
    
    func isFormValid () -> Bool {
        if loginField.text?.characters.count > 0 && passwordField.text?.characters.count > 0 {
            return true
        }
        else if loginField.text?.characters.count == 0 {
            loginField.becomeFirstResponder()
        }
        else if passwordField.text?.characters.count == 0 {
            passwordField.becomeFirstResponder()
        }
        
        return false
    }

    // MARK: - Actions Methods
    
    @IBAction func loginTapped() {
        if isFormValid() {
            guard let login = loginField.text else {
                loginField.becomeFirstResponder()
                return
            }
            guard let password = passwordField.text else {
                passwordField.becomeFirstResponder()
                return
            }

            // TODO: Check Internet connection and show loader
            WebServices.sharedInstance.loginUser(login, password: password, completed: {
                let mainNavController = self.storyboard?.instantiateViewControllerWithIdentifier("MainNavController")
                self.view.window!.rootViewController = mainNavController
                }) { (error) in
                   Utils.showErrorAlert(self, error: error)
            }
        }
    }

    @IBAction func forgotTapped() {
        // TODO: forgot password NYI
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == loginField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            passwordField.resignFirstResponder()
        }
        
        return false
    }
}
