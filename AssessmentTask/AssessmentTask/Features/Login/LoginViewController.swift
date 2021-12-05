//
//  LoginViewController.swift
//  AssessmentTask
//
//  Created by Adel Aref on 04/12/2021.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signinButton: UIButton!

    let viewModel = UserViewModel()
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    var phone: String? {
        didSet {
            phoneTextField.text = phone
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBasicsBindings()
    }
    func setUpBasicsBindings() {
        viewModel
            .isSuccess
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { (_) in
                let viewController = HomeViewController.instantiate(fromAppStoryboard: .main)
                let navController = UINavigationController(rootViewController: viewController)
                UIApplication.shared.delegate?.window??.rootViewController = navController

            }).disposed(by: disposeBag)
        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        viewModel
            .isError
            .observe(on: MainScheduler.instance)
            .bind(to: self.rx.isError)
            .disposed(by: disposeBag)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    @IBAction func loginAction(sender: UIButton) {
        let checkErrorExisting = self.viewModel.validateEntries(phone: self.phoneTextField.text,
                                                                password: self.passwordTextField.text)
        if checkErrorExisting {
            if let phone = self.phoneTextField.text, let password = self.passwordTextField.text {
                let user = UserModel()
                user.phone = phone
                user.password = password
                self.viewModel.login(user: user)
            }
        }
    }
    @IBAction func createAccount(sender: UIButton) {
        if let viewController = SignUpViewController.instantiateFromNib() {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    @IBAction func backAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
