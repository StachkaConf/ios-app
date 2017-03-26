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

    override func viewDidLoad() {
        viewModel?.presentations.subscribe(onNext: { _ in

        })
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
