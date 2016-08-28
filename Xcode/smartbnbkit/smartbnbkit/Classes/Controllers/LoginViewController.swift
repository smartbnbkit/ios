//
//  LoginViewController.swift
//  smartbnbkit
//
//  Created by Roman Stetsenko on 8/23/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var maskotView: MaskotView!
    @IBOutlet var loginField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var scrollBottom: NSLayoutConstraint!
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            self.blink(delay: 4.0)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: -
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
    }

    func blink(delay delay: Double) {
        self.maskotView.blink()
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.3 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { [weak self] in
            guard let `self` = self else {
                return
            }
            self.maskotView.blink()
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay/2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { [weak self] in
                guard let `self` = self else {
                    return
                }
                self.maskotView.blink()
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay/2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { [weak self] in
                    guard let `self` = self else {
                        return
                    }
                    self.blink(delay: delay+0.5)
                    })
                })
            })

    }

    // MARK: - Actions
    @IBAction func loginTapped() {
        guard let login = loginField.text else {
            loginField.becomeFirstResponder()
            return
        }
        guard let password = passwordField.text else {
            passwordField.becomeFirstResponder()
            return
        }

        // TODO: login here
        print("Login as \(login) / \(password)")

        let mainNavController = self.storyboard?.instantiateViewControllerWithIdentifier("MainNavController")
        view.window!.rootViewController = mainNavController
    }

    @IBAction func forgotTapped() {
        // TODO: forgot password NYI
    }
    
    // MARK: -
    func keyboardWillChangeFrame(notif: NSNotification) {
        let userInfo = notif.userInfo!
        let rect = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue()
        let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
        scrollBottom.constant = self.view.window!.bounds.size.height - rect.origin.y;
        UIView.animateWithDuration(userInfo[UIKeyboardAnimationDurationUserInfoKey]!.doubleValue, delay: 0.0, options: options, animations: {
            self.view.layoutIfNeeded()
            }) { (_) in
        }
    }

    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
