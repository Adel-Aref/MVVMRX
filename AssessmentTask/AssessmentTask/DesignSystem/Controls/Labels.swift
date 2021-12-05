//  Labels.swift
//  AssessmentTask
//
//  Created by Adel Aref on 04/12/2021.
//

import Foundation
import UIKit

class TitleLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textColor = R.color.black()
        self.font = TextStyle.largeTitle.font
    }
}
class HeadlineLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textColor = R.color.black()
        self.font = TextStyle.headline.font
    }
}
