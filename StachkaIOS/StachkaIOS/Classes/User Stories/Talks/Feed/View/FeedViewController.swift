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
import RxDataSources

class FeedViewController: UIViewController {

    typealias FeedDataSource = RxCustomTableViewDelegateDataSource<PresentationSectionModel>

    enum Constants {
        static let title = "Расписание"
        static let filterButtonTitle = "Фильтры"
    }

    fileprivate var indexPublisher: PublishSubject<IndexPath> = PublishSubject()
    fileprivate var indexSelecter: PublishSubject<IndexPath> = PublishSubject()
    fileprivate var filterSelecter: PublishSubject<Void> = PublishSubject()

    var viewModel: FeedViewModel?
    private let disposeBag = DisposeBag()
    private let dataSource = FeedDataSource()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.title
        
        setupTabBar()
        setupNavigationBar()
        setupTableView()
        setupBindings()
    }

    private func setupTableView() {
        tableView.register(PresentationCell.self)
        dataSource.configureCell = { (dataSource: TableViewSectionedDataSource<PresentationSectionModel>,
                                      tableView: UITableView,
                                      indexPath: IndexPath,
                                      item: PresentationCellViewModel) in
            let cell = tableView.dequeueCell(item.associatedCell)
            cell.configure(with: item)
            return cell as! UITableViewCell
        }
        dataSource.configureCellHeight = { item, tableView, _ in
            if let heightCell = item.associatedCell as? ConfigurableStaticHeightCell.Type {
                return heightCell.cellHeight
            }

            return 0
        }
        dataSource.titleForHeaderInSection = { (dataSource: TableViewSectionedDataSource<PresentationSectionModel>,
                                                index: Int) in
            let sectionModel = dataSource[index]
            return sectionModel.timeString
        }
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
            .bindTo(self.filterSelecter)
            .disposed(by: disposeBag)

        tableView.rx
            .willDisplayCell
            .map { $0.indexPath }
            .bindTo(self.indexPublisher)
            .disposed(by: disposeBag)

        tableView.rx
            .itemSelected
            .bindTo(self.indexSelecter)
            .disposed(by: disposeBag)

        viewModel?
            .presentations
            .bindTo(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        tableView.rx
            .setDelegate(dataSource)
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
