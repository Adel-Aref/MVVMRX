//
//  OnboardingViewController.swift
//  AssessmentTask
//
//  Created by Adel Aref on 05/12/2021.
//

import UIKit
import RxSwift

class OnboardingViewController: UIViewController {
    @IBOutlet weak var signIntButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonsAction()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    func setupButtonsAction() {
        signIntButton.rx.tap.subscribe { [weak self](_) in
            guard let self = self else {return}
            if let viewController = LoginViewController.instantiateFromNib() {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }.disposed(by: disposeBag)
        signUpButton.rx.tap.subscribe { [weak self](_) in
            guard let self = self else {return}
            if let viewController = SignUpViewController.instantiateFromNib() {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }.disposed(by: disposeBag)
    }
}
