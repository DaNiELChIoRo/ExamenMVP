//
//  Device+Extension.swift
//  ExamenMVP
//
//  Created by Daniel Meneses on 01/03/20.
//  Copyright © 2020 Daniel Meneses. All rights reserved.
//

import UIKit
import AVFoundation

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
