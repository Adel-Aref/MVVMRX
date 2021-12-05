//
//  MovieDetailsViewController.swift
//  EvaPharmaTask
//
//  Created by Adel Aref on 09/09/2021.
//

import UIKit
//swiftlint:disable identifier_name
class AutherViewController: UIViewController {
    @IBOutlet weak var autherTitleLabel: UILabel!
    @IBOutlet weak var WidthLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var autherImageView: UIImageView!
    let viewModel = HomeViewModel()
    var homeModel: HomeModel? {
        didSet {
            setUI()
        }
    }
    var color: UIColor? {
        didSet {
            self.view.backgroundColor = color
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    func setUI() {
        autherTitleLabel.text = homeModel?.author ?? ""
        WidthLabel.text = String(homeModel?.width ?? 0)
        heightLabel.text = String(homeModel?.height ?? 0)
        autherImageView.setImage(strUrl: homeModel?.download_url ?? "", name: "fawry")
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        autherImageView.addGestureRecognizer(imageTap)
        autherImageView.isUserInteractionEnabled = true
    }
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        if let imageView = sender.view as? UIImageView {
            let newImageView = UIImageView(image: imageView.image)
            newImageView.frame = UIScreen.main.bounds
            newImageView.backgroundColor = .black
            newImageView.contentMode = .scaleAspectFit
            newImageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
            newImageView.addGestureRecognizer(tap)
            self.view.addSubview(newImageView)
        }
    }
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
}
