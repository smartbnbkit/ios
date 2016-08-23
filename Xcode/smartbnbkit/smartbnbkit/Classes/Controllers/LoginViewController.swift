//
//  LoginViewController.swift
//  smartbnbkit
//
//  Created by Roman Stetsenko on 8/23/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var loginField: UITextField!
    @IBOutlet var passwordField: UITextField!

    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: -
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
}
