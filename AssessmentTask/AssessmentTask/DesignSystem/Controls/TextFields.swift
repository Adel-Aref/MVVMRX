//  TextFields.swift
//  AssessmentTask
//
//  Created by Adel Aref on 04/12/2021.
//
//
import Foundation
import UIKit

class PrimaryTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 4
        self.borderStyle = .roundedRect
        self.textAlignment = .natural
        self.borderColor = R.color.borderColor()
        self.borderWidth = 1.0
        self.textColor = R.color.blackTwo()
        self.font = TextStyle.input.font
    }
}
