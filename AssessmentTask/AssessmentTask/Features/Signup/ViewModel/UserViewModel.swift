//
//  LoginViewModel.swift
//  AssessmentTask
//
//  Created by Adel Aref on 05/12/2021.
//

import Foundation
import RxSwift

class UserViewModel: BaseViewModel {
    // MARK: - RxSwif Variables
    let isSuccess: PublishSubject<Bool> = PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    let isError: PublishSubject<ErrorMessage> = PublishSubject()
    let disposeBag: DisposeBag = DisposeBag()
    let realm: LocalStorageProtocol

    // MARK: - init
    public init (_ realm: LocalStorageProtocol = LocalStorage()) {
        self.realm = realm
        isSuccess.disposed(by: disposeBag)
        configureDisposeBag()
    }
    // MARK: - Error Message
    func showError(message: String, title: String) {
        let error =
        ErrorMessage(title: title,
                     message: message, action: nil)
        self.isError.onNext(error)
    }
    func createAccount(user: UserModel) {
        let results = realm.getObjects(model: UserModel.self).filter { $0.phone == user.phone }
        if results.isEmpty {
            realm.write(user)
            isSuccess.onNext(true)
        } else {
            let error = ErrorMessage(title: "user error", message: "phone already exist", action: nil)
            isError.onNext(error)
        }
    }
    func login(user: UserModel) {
        let results = realm.getObjects(model: UserModel.self).filter { $0.phone == user.phone }
        if results.isEmpty {
            let error = ErrorMessage(title: "user error", message: "user not exist", action: nil)
            isError.onNext(error)
        } else {
            defaults.isLoggedIn = true
            defaults.user = user
            isSuccess.onNext(true)
        }
    }
    // MARK: - Validation
    func validateEntries( phone: String?, password: String?, confirmPass: String? = nil ) -> Bool {
        if !(phone?.isValidMobile() ?? false) {
            showError(message: "Phone number should be vaild phone", title:
                        "Phone validation error")
            return false
        } else if !(password?.isValidPassword() ?? false) {
            showError(message: "Password should be vaild", title: "Password validation error")
            return false
        } else if (password != confirmPass) && confirmPass != nil {
            showError(message: "Password and confirm password don't match", title: "Password validation error")
            return false
        } else {
            return true
        }
    }
}
