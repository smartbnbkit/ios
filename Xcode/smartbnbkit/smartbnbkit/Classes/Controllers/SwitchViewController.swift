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
    @IBOutlet var maskotView: MaskotView!

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
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (!SwitchViewController.tempLoggedIn) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            self.maskotView.blink()
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                self.maskotView.blink()
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                    self.showLogin()
                })
            })
        })
        } else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                self.maskotView.blink(left: false)
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                    self.maskotView.blink(left: true, right: false)
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                        self.maskotView.blink()
                        self.switcher.hidden = false
                        self.switcher.alpha = 0
                        UIView.animateWithDuration(0.15, delay: 0.15, options: [], animations: {
                            self.switcher.alpha = 1
                            }, completion: { (_) in
                        })
                    })
                })
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: -
    private static var tempLoggedIn = false
    func showLogin() {
        if !SwitchViewController.tempLoggedIn {
            let loginVc = self.storyboard!.instantiateViewControllerWithIdentifier(String(LoginViewController))
            loginVc.modalPresentationStyle = .OverFullScreen
            self.presentViewController(loginVc, animated: true, completion: nil)
            self.switcher.hidden = true
            SwitchViewController.tempLoggedIn = true
        }
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
