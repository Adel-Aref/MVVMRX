//
//  ViewController.swift
//  AssessmentTask
//
//  Created by Adel Aref on 04/12/2021.
//

import Foundation
import UIKit

extension UIViewController {
    static func instantiateFromNib() -> Self? {
        func instantiateFromNib<T: UIViewController>(_ viewType: T.Type) -> T? {
            return Bundle.main.loadNibNamed(String(describing: T.self),
                                     owner: nil, options: nil)?.first
            as? T
        }

        return instantiateFromNib(self)
    }
}
