//
//  ViewController.swift
//  AssessmentTask
//
//  Created by Adel Aref on 04/12/2021.
//

import Foundation

import UIKit

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: Float) -> NSLayoutConstraint {
        NSLayoutConstraint.deactivate([self])
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: CGFloat(multiplier),
            constant: constant)
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
