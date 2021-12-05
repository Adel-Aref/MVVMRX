//
//  ViewController.swift
//  AssessmentTask
//
//  Created by Adel Aref on 04/12/2021.
//

import Foundation
import UIKit

extension UIImageView {
    func rotate() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 2
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}
