//
//  MaskotView.swift
//  smartbnbkit
//
//  Created by Roman Stetsenko on 8/23/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

class MaskotView: UIView {
    @IBOutlet private var rightEye: UIView!
    @IBOutlet private var leftEye: UIView!

    @IBOutlet private var rightEyeHeight: NSLayoutConstraint!
    @IBOutlet private var leftEyeHeight: NSLayoutConstraint!

    var eyeHeight: CGFloat = 50
    var isBlinking = false

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func blinkLeft() {
        self.blink(left: true, right: false)
    }

    func blinkRight() {
        self.blink(left: false, right: true)
    }

    func blink(left left: Bool = true, right: Bool = true, duration: Double = 0.3) {
        if self.isBlinking {
            return
        }
        self.isBlinking = true

        self.eyeHeight = self.rightEyeHeight.constant
        if right {
            self.rightEyeHeight.constant = 2
        }
        if left {
            self.leftEyeHeight.constant = 2
        }
        UIView.animateWithDuration(duration/2, delay: 0.0, options: .CurveEaseOut, animations: {
            self.layoutIfNeeded()
        }) { [weak self] (_) in
            guard let `self` = self else {
                return
            }
            self.rightEyeHeight.constant = self.eyeHeight
            self.leftEyeHeight.constant = self.eyeHeight
            UIView.animateWithDuration(duration/2, delay: 0.0, options: .CurveEaseIn, animations: {
                self.layoutIfNeeded()
            }) { (_) in
                self.isBlinking = false
            }
        }
    }
}
