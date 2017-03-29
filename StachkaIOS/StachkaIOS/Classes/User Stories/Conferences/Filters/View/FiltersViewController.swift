//
//  FiltersViewController.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 27.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import RxCocoa
import RxSwift

class FiltersViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    var viewModel: FiltersViewModel?

    fileprivate var indexSelecter: PublishSubject<IndexPath> = PublishSubject()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
    }

    private func setupTableView() {
        tableView.register(TickFilterCell.self)
    }

    private func setupBindings() {
        tableView.rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.indexSelecter.onNext(indexPath)
            })
            .disposed(by: disposeBag)

        viewModel?
            .filters
            .bindTo(tableView.rx.items) { tableView, row, model in
                let configurableCell = tableView.dequeueCell(model.associatedCell)
                configurableCell.configure(with: model)

                return configurableCell as! UITableViewCell
            }
            .disposed(by: disposeBag)
    }
}

extension FiltersViewController: FiltersView {
    var indexSelected: Observable<IndexPath> {
        return indexSelecter.asObservable()
    }
}