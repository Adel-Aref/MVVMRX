//
//  HomeViewModel.swift
//  AssessmentTask
//
//  Created by Adel Aref on 05/12/2021.
//

import Foundation

import RxSwift
// swiftlint:disable all
class HomeViewModel: BaseViewModel {
    var isLoading: PublishSubject<Bool> = PublishSubject()
    let isSuccess: PublishSubject<[HomeModel]> = PublishSubject()
    var isError: PublishSubject<ErrorMessage> = PublishSubject()
    var isRemoved: PublishSubject<Bool> = PublishSubject()

    var disposeBag: DisposeBag = DisposeBag()
    let repository: Repository
    let realm: LocalStorageProtocol = LocalStorage()

    var refreshClousre: (() -> Void)?
    var cachedMovies = [HomeModel]() {
        didSet {
            refreshClousre?()
        }
    }
    var isLoad = false
    var page = 1
    var totalPage = 10
    public init (_ repo: Repository = HomeRepo()) {
        repository = repo
        isSuccess.disposed(by: disposeBag)
        configureDisposeBag()
    }

    func getHomeData() {
        guard self.isLoad == false else {
            return
        }
        self.isLoading.onNext(true)
        self.isLoad = true
        (repository as? HomeRepo)?.getHomeData(page: self.page) { [weak self] (result) in
            guard let self = self else {
                return
            }
            self.isLoading.onNext(false)
            self.isLoad = false
            switch result {
            case .success(let data):
                if let data = data as? [HomeModel] {
                    if self.page <= self.totalPage {
                        self.page += 1
                    }
                    self.cachedMovies.append(contentsOf: data)
                    self.isSuccess.onNext(self.cachedMovies)

                }
            case .failure(let error):
                let error = ErrorMessage(title: "Error", message: error.localizedDescription, action: nil)
                self.isError.onNext(error)
            }
        }
    }
    func removeUser() {
        if let user = defaults.user {
            let results = realm.getObjects(model: UserModel.self).filter { $0.phone == user.phone }
            if let first = results.first {
                realm.delete(first)
                defaults.isLoggedIn = false
                isRemoved.onNext(true)
            }
        }
    }
}
