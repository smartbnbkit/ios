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

    @IBOutlet var scrollBottom: NSLayoutConstraint!

    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        loginField.layer.cornerRadius = loginField.frame.height/2
        passwordField.layer.cornerRadius = passwordField.frame.height/2
        loginButton.layer.cornerRadius = loginButton.frame.height/2
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            self.blink(delay: 4.0)
        })

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillChangeFrame(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)
    }

    // MARK: -

    func hideKeyboard () {
        view.endEditing(true)
    }

    func setupViews() {
        loginField.textColor = StyleKit.appDarkGray
        loginField.layer.borderWidth = 1
        loginField.layer.borderColor = StyleKit.appLightGray.CGColor

        passwordField.textColor = StyleKit.appDarkGray
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = StyleKit.appLightGray.CGColor

        let tap = UITapGestureRecognizer.init(target: self, action: #selector(LoginViewController.hideKeyboard))
        view.addGestureRecognizer(tap)
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

    func keyboardWillChangeFrame(notif: NSNotification) {
        let userInfo = notif.userInfo!
        let rect = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue()
        let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
        scrollBottom.constant = self.view.window!.bounds.size.height - rect.origin.y
        UIView.animateWithDuration(userInfo[UIKeyboardAnimationDurationUserInfoKey]!.doubleValue, delay: 0.0, options: options, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
        }
    }

    func isFormValid () -> Bool {
        if loginField.text?.characters.count > 0 && passwordField.text?.characters.count > 0 {
            return true
        } else if loginField.text?.characters.count == 0 {
            loginField.becomeFirstResponder()
        } else if passwordField.text?.characters.count == 0 {
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
        } else if textField == passwordField {
            passwordField.resignFirstResponder()
        }

        return false
    }
}
