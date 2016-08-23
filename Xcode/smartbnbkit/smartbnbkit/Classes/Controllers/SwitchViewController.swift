//
//  SwitchViewController.swift
//  smartbnbkit
//
//  Created by Roman Stetsenko on 8/23/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

class SwitchViewController: UIViewController {

    @IBOutlet var bulb: UIView!
    @IBOutlet var switcher: UISwitch!
    @IBOutlet var maskotView: MaskotView!

    var currentBulbState: Bool = false {
        didSet {
            if currentBulbState {
                bulb.backgroundColor = UIColor(red: 252/255, green: 241/255, blue: 89/255, alpha: 1.0)
                switcher.on = true
            } else {
                bulb.backgroundColor = UIColor.grayColor()
                switcher.on = false
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bulb.layer.borderColor = UIColor.darkGrayColor().CGColor
        bulb.layer.borderWidth = 1/UIScreen.mainScreen().scale
        currentBulbState = false
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        getState()

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            self.maskotView.blink()
        })
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        bulb.layer.cornerRadius = bulb.frame.size.width/2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: -
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
