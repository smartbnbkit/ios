//
//  SwitchViewController.swift
//  smartbnbkit
//
//  Created by Roman Stetsenko on 8/23/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

class SwitchViewController: UIViewController {

    @IBOutlet var switcher: UISwitch!

    var currentBulbState: Bool = false {
        didSet {
            if currentBulbState {
                switcher.on = true
            } else {
                switcher.on = false
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        currentBulbState = true
        self.switcher.hidden = true
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        getState()
        self.navigationController?.navigationBar.barStyle = .Black
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -
    @IBAction func logout() {
        let loginVc = self.storyboard!.instantiateViewControllerWithIdentifier(String(LoginViewController))
        view.window!.rootViewController = loginVc
    }

    @IBAction func switchChanged(sender: UISwitch) {
        toggleState()
    }

    // MARK: -
    func getState() {
        // TODO: NYI
    }

    func toggleState() {
        if currentBulbState {
            turnOff()
        } else {
            turnOn()
        }
    }

    func turnOn() {
        // TODO: NYI
        currentBulbState = true
    }

    func turnOff() {
        // TODO: NYI
        currentBulbState = false
    }
}
