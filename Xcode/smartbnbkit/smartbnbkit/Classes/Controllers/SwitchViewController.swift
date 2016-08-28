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
    @IBOutlet var imageViewStatus: UIImageView!
    @IBOutlet var labelStatus: UILabel!

    var currentBulbState: Bool = false {
        didSet {
            if currentBulbState {
                switcher.on = true
                imageViewStatus.image = UIImage(named: "image_devices_on")
                labelStatus.text = "Devices are on and running"
            } else {
                switcher.on = false
                imageViewStatus.image = UIImage(named: "image_devices_off")
                labelStatus.text = "Devices are off"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        currentBulbState = true
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
        // TODO: Add spinner and check internet connection
        WebServices.sharedInstance.getSwitchStatus({ (status) in
            self.currentBulbState = status
            }) { (error) in
                Utils.showErrorAlert(self, error: error)
        }
    }

    func toggleState() {
        if currentBulbState {
            turnOff()
        } else {
            turnOn()
        }
    }

    func turnOn() {
        // TODO: Add spinner and check internet connection

        WebServices.sharedInstance.changeSwitchStatus(true, completed: { (status) in
            self.currentBulbState = status
            }) { (error) in
                Utils.showErrorAlert(self, error: error)
        }
    }

    func turnOff() {
        // TODO: Add spinner and check internet connection
        WebServices.sharedInstance.changeSwitchStatus(false, completed: { (status) in
            self.currentBulbState = status
        }) { (error) in
            Utils.showErrorAlert(self, error: error)
        }
    }
}
