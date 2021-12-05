//  Buttons.swift
//  AssessmentTask
//
//  Created by Adel Aref on 04/12/2021.
//

import Foundation
import UIKit

class PrimaryButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 25
        self.setTitleColor(R.color.whiteTwo(), for: .normal)
        self.titleLabel?.font = TextStyle.primaryButton.font
        self.backgroundColor = R.color.primaryColor()
    }
}
class SeconadryButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 25
        self.setTitleColor(R.color.whiteTwo(), for: .normal)
        self.titleLabel?.font = TextStyle.primaryButton.font
        self.backgroundColor = R.color.secondaryColor()
    }
}
