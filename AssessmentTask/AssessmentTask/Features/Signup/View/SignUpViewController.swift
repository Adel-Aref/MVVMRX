//
//  SignUpViewController.swift
//  AssessmentTask
//
//  Created by Adel Aref on 04/12/2021.
//

import UIKit
import RxSwift

class SignUpViewController: UIViewController {
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    let viewModel = UserViewModel()
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBasicsBindings()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    func setUpBasicsBindings() {
        viewModel
            .isSuccess
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_)  in
                guard let self = self else { return }
                if let viewController = LoginViewController.instantiateFromNib() {
                    viewController.phone = self.phoneTextField.text ?? ""
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
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
    @IBAction func signUpAction(sender: UIButton) {
        let checkErrorExisting = self.viewModel.validateEntries(phone: self.phoneTextField.text,
                                                                password: self.passwordTextField.text,
                                                                confirmPass: self.confirmPasswordTextField.text)
        if checkErrorExisting {
            if let phone = self.phoneTextField.text, let password = self.passwordTextField.text {
                let user = UserModel()
                user.phone = phone
                user.password = password
                self.viewModel.createAccount(user: user)
            }
        }
    }
    @IBAction func backAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
