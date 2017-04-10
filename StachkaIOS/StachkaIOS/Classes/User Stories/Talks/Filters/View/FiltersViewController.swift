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
    fileprivate var dissappearEvent: PublishSubject<Void> = PublishSubject()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dissappearEvent.onCompleted()
    }

    private func setupTableView() {
        tableView.register(TickFilterCell.self)
    }

    private func setupBindings() {
        tableView.rx
            .itemSelected
            .bindTo(self.indexSelecter)
            .disposed(by: disposeBag)

        viewModel?
            .title
            .subscribe(onNext: { [weak self] title in
                self?.title = title
            })
            .disposed(by: disposeBag)
        
        viewModel?
            .filters
            .bindTo(tableView.rx.items) { tableView, row, model in
                let configurableCell = tableView.dequeueCell(TickFilterCell.self)
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

    var dissappear: Observable<Void> {
        return dissappearEvent.asObservable()
    }
}
