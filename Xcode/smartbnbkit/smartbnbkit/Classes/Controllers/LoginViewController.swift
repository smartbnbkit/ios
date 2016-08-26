//
//  LoginViewController.swift
//  smartbnbkit
//
//  Created by Roman Stetsenko on 8/23/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    // TODO: embed in scroll view to fix issue with keyboard on iPhone 4

    @IBOutlet var maskotView: MaskotView!
    @IBOutlet var loginField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!

    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViews()
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
            self?.maskotView.blink()
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay/2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { [weak self] in
                self?.maskotView.blink()
                self?.blink(delay: delay)
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

    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
