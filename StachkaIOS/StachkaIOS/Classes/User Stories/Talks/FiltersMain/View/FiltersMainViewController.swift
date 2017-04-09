//
//  FiltersViewController.swift
//  StachkaIOS
//
//  Created by m.rakhmanov on 27.03.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import RxCocoa
import RxSwift

class FiltersMainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    var viewModel: FiltersMainViewModel?

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
        tableView.register(NavigationFilterCell.self)
    }

    private func setupBindings() {
        tableView.rx
            .itemSelected
            .bindTo(self.indexSelecter)
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

extension FiltersMainViewController: FiltersMainView {
    var indexSelected: Observable<IndexPath> {
        return indexSelecter.asObservable()
    }

    var dissappear: Observable<Void> {
        return dissappearEvent.asObservable()
    }
}

extension FiltersMainViewController: ModuleOutputProvider {
    var moduleOutput: ModuleOutput? {
        return viewModel as? ModuleOutput
    }
}
