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

class PresentationInfoViewController: UIViewController {

    enum Constants {
        static let title = "О докладе"
    }

    typealias PresentationDataSource = RxCustomTableViewDelegateDataSource<CellSectionModel>
    fileprivate let heightCalculator = TableViewHeightCalculatorImplementation()

    var viewModel: PresentationInfoViewModel?
    private let disposeBag = DisposeBag()
    private let dataSource = PresentationDataSource()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.title
        
        setupTableView()
        setupBindings()
    }

    private func setupTableView() {
        tableView.register(PresentationInfoCell.self)
        tableView.register(AuthorInfoCell.self)
        tableView.register(AuthorBriefInfoCell.self)
        tableView.register(PresentationDescriptionCell.self)
        tableView.register(AuthorImageCell.self)
        dataSource.configureCell = { (dataSource: TableViewSectionedDataSource<CellSectionModel>,
                                      tableView: UITableView,
                                      indexPath: IndexPath,
                                      item: CellViewModel) in
            let cell = tableView.dequeueCell(item.associatedCell)
            cell.configure(with: item)
            return cell as! UITableViewCell
        }
        dataSource.configureCellHeight = { [weak self] item, tableView, indexPath in
            guard let strongSelf = self else { return 0 }
            return strongSelf.heightCalculator.height(for: indexPath.row, viewModel: item, tableView: tableView)
        }
        //dataSource.titleForHeaderInSection = nil
    }


    private func setupBindings() {
        viewModel?
            .presentationModels
            .bindTo(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        tableView.rx
            .setDelegate(dataSource)
            .disposed(by: disposeBag)
    }
}

extension PresentationInfoViewController: PresentationInfoView {
    
}

