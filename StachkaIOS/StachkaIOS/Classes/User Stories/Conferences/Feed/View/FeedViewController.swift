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
    fileprivate var indexPublisher: PublishSubject<IndexPath> = PublishSubject()
    var viewModel: FeedViewModel?
    private let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        setupTableView()
        setupBindings()
    }

    private func setupTableView() {
        let presentationCell = UINib(nibName: PresentationCell.identifier, bundle: Bundle.main)
        tableView.register(presentationCell, forCellReuseIdentifier: PresentationCell.identifier)
    }

    private func setupBindings() {
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
        return indexPublisher.asObservable()
    }
}
