//
//  HomeViewController.swift
//  AssessmentTask
//
//  Created by Adel Aref on 05/12/2021.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    @IBOutlet weak var authersCollectionView: UICollectionView!

    var viewModel = HomeViewModel()
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBasicBinding()
        setUpOrdersCollectionView()
        viewModel.getHomeData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    private func setupBasicBinding() {
        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        viewModel
            .isError
            .observe(on: MainScheduler.instance)
            .bind(to: self.rx.isError)
            .disposed(by: disposeBag)
        viewModel
            .isRemoved
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { (_) in
               if let viewController = OnboardingViewController.instantiateFromNib() {
                   let navController = UINavigationController(rootViewController: viewController)
                   UIApplication.shared.delegate?.window??.rootViewController = navController
                }

            }).disposed(by: disposeBag)
    }
    func setUpOrdersCollectionView() {
        authersCollectionView.registerNib(identifier: R.nib.homeCollectionCell.name)
        authersCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.isSuccess
            .bind(to: authersCollectionView
                    .rx.items(cellIdentifier: R.nib.homeCollectionCell.name,
                              cellType: HomeCollectionCell.self)) { _, model, cell in

                cell.itemCell = model
            }.disposed(by: disposeBag)
        authersCollectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else {return}
                if let viewController = AutherViewController.instantiateFromNib() {
                    let cell = self.authersCollectionView.cellForItem(at: indexPath) as? HomeCollectionCell
                    viewController.color = cell?.autherImageView.image?.averageColor
                    viewController.homeModel = self.viewModel.cachedMovies[indexPath.row]
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            }).disposed(by: disposeBag)
        authersCollectionView.rx
            .willDisplayCell
            .subscribe(onNext: { _, indexPath in
                if indexPath.row == (self.viewModel.cachedMovies.count) - 1 {
                    self.viewModel.getHomeData()
                }
            })
            .disposed(by: disposeBag)
    }
    @IBAction func logout() {
        let actionsheet = UIAlertController(title: nil, message: nil,
                                            preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title:
            "OK",
                                            style: .default, handler: { (_: UIAlertAction) in
            self.viewModel.removeUser()
        }))
        actionsheet.addAction(UIAlertAction(title:
            "Cancel", style: .cancel, handler: nil))
        self.present(actionsheet, animated: true, completion: nil)
    }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    // swiftlint:disable vertical_parameter_alignment
    func collectionView(_ collectionView: UICollectionView, layout
                            collectionViewLayout: UICollectionViewLayout, sizeForItemAt
                                indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        let cellWidth = (width - 10) / 2
        return CGSize(width: cellWidth, height: height / 2.3)
    }
}
