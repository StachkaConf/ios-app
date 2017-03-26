//
//  FeedViewController.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 26.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class FeedViewController: UIViewController {

    enum Constants {
        static let title = "Расписание"
        static let filterButtonTitle = "Фильтр"
    }

    fileprivate var indexPublisher: PublishSubject<IndexPath> = PublishSubject()
    fileprivate var indexSelecter: PublishSubject<IndexPath> = PublishSubject()
    fileprivate var filterSelecter: PublishSubject<Void> = PublishSubject()

    var viewModel: FeedViewModel?
    private let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        title = Constants.title
        
        setupTabBar()
        setupNavigationBar()
        setupTableView()
        setupBindings()
    }

    private func setupTableView() {
        let presentationCell = UINib(nibName: PresentationCell.identifier, bundle: Bundle.main)
        tableView.register(presentationCell, forCellReuseIdentifier: PresentationCell.identifier)
    }

    private func setupTabBar() {
        tabBarItem = UITabBarItem(title: Constants.title, image: UIImage.TabBar.calendar, selectedImage: UIImage.TabBar.calendar)
    }

    private func setupNavigationBar() {
        let barButtonItem = UIBarButtonItem(title: Constants.filterButtonTitle, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = barButtonItem
    }

    private func setupBindings() {
        navigationItem.rightBarButtonItem?.rx
            .tap
            .subscribe(onNext: { [weak self] in
                self?.filterSelecter.onNext()
            })
            .disposed(by: disposeBag)

        tableView.rx
            .willDisplayCell
            .subscribe(onNext: { [weak self] event in
                self?.indexPublisher.onNext(event.indexPath)
            })
            .disposed(by: disposeBag)

        tableView.rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.indexSelecter.onNext(indexPath)
            })
            .disposed(by: disposeBag)

        viewModel?
            .presentations
            .bindTo(tableView.rx.items(cellIdentifier: PresentationCell.identifier)) {
                index, model, cell in
                guard let configurableCell = cell as? ConfigurableCell else {
                    return
                }
                configurableCell.configure(with: model)
            }
            .disposed(by: disposeBag)
    }
}

extension FeedViewController: ModuleOutputProvider {
    var moduleOutput: ModuleOutput? {
        return viewModel as? ModuleOutput
    }
}

extension FeedViewController: FeedView {
    var indexSelected: Observable<IndexPath> {
        return indexSelecter.asObservable()
    }

    var indexDisplayed: Observable<IndexPath> {
        return indexPublisher.asObservable()
    }

    var filterSelected: Observable<Void> {
        return filterSelecter.asObservable()
    }
}
