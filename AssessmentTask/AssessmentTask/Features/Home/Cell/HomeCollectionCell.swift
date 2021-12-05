//
//  MovieCollectionCell.swift
//  EvaPharmaTask
//
//  Created by Adel Aref on 09/09/2021.
//

import UIKit

class HomeCollectionCell: UICollectionViewCell {
    @IBOutlet weak var autherImageView: UIImageView!
    @IBOutlet weak var autherTitleLabel: UILabel!
    var itemCell: HomeModel? {
        didSet {
            autherTitleLabel.text = itemCell?.author ?? ""
            self.autherImageView.setImage(strUrl: itemCell?.download_url ?? "", name: "fawry")

        }
    }
}
